-- spot-tui.lua
-- Titlebars for ncspot
-- Special thanks to elenapan
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local helpers = require("helpers")
local keys = require("keys")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local toolbar_position = "bottom"
local toolbar_size = dpi(100)
local toolbar_bg = beautiful.xcolor0
local toolbar_enabled_initially = true

local terminal_has_to_move_after_resizing = {["st"] = true}

local music_client = "st -c music -e ncspot"
local update_interval = 15

local music_client_terminal = music_client:match("(%w+)(.+)")
local terminal_has_to_move =
    terminal_has_to_move_after_resizing[music_client_terminal]

local spot_toolbar_toggle = function(c)
    if c.toolbar_enabled then
        c.toolbar_enabled = false
        awful.titlebar.hide(c, toolbar_position)
        c.width = c.width + toolbar_size
        if terminal_has_to_move then c.x = c.x - toolbar_size end
    else
        c.toolbar_enabled = true
        awful.titlebar.show(c, toolbar_position)
        c.width = c.width - toolbar_size
        if terminal_has_to_move then c.x = c.x + toolbar_size end
    end
end

local art = wibox.widget {
    image = gears.filesystem.get_configuration_dir() .. "images/default.png",
    clip_shape = helpers.rrect(dpi(6)),
    resize = true,
    widget = wibox.widget.imagebox
}

local create_button = function(symbol, color, command, playpause)

    local icon = wibox.widget {
        markup = helpers.colorize_text(symbol, color),
        font = "FiraCode Nerd Font Mono 20",
        align = "center",
        valigin = "center",
        widget = wibox.widget.textbox()
    }

    local button = wibox.widget {
        icon,
        forced_height = dpi(40),
        forced_width = dpi(40),
        widget = wibox.container.background
    }

    awful.widget.watch("playerctl status", update_interval,
                       function(widget, stdout)
        if playpause then
            if stdout:find("Playing") then
                widget.markup = helpers.colorize_text("", color)
            else
                widget.markup = helpers.colorize_text("", color)
            end
        end
    end, icon)

    button:buttons(gears.table.join(
                       awful.button({}, 1, function() command() end)))

    button:connect_signal("mouse::enter", function()
        icon.markup = helpers.colorize_text(icon.text, beautiful.xforeground)
    end)

    button:connect_signal("mouse::leave", function()
        icon.markup = helpers.colorize_text(icon.text, color)
    end)

    return button

end

local art_script = [[
bash -c '

tmp_dir="/tmp/awesomewm/spotify/"
tmp_cover_path=${tmp_dir}"cover.png"

if [ ! -d $tmp_dir  ]; then
    mkdir -p $tmp_dir
fi

link="$(playerctl metadata mpris:artUrl | sed -e 's/open.spotify.com/i.scdn.co/g')"

curl -s "$link" --output $tmp_cover_path

echo $tmp_cover_path
']]

local song_title_cmd = "playerctl metadata title"
local song_title = "rice is cringe"

awful.widget.watch(song_title_cmd, update_interval, function(widget, stdout)
    if not (song_title == stdout) then
        awful.spawn.easy_async_with_shell(art_script, function(out)
            local album_path = out:gsub('%\n', '')
            widget:set_image(gears.surface.load_uncached(album_path))
        end)
        song_title = stdout
    end
end, art)

local play_command =
    function() awful.spawn.with_shell("playerctl play-pause") end
local prev_command = function() awful.spawn.with_shell("playerctl previous") end
local next_command = function() awful.spawn.with_shell("playerctl next") end

local spot_play_symbol = create_button("", beautiful.xcolor4, play_command,
                                       true)

local spot_prev_symbol = create_button("玲", beautiful.xcolor4, prev_command,
                                       false)
local spot_next_symbol = create_button("怜", beautiful.xcolor4, next_command,
                                       false)

local spot_create_decoration = function(c)
    awful.titlebar(c, {
        position = toolbar_position,
        size = toolbar_size,
        bg = beautiful.xbackground
    }):setup{
        {
            {
                {
                    {
                        art,
                        left = dpi(0),
                        right = dpi(0),
                        bottom = dpi(0),
                        top = dpi(0),
                        layout = wibox.container.margin
                    },
                    layout = wibox.layout.fixed.horizontal
                },
                {
                    {
                        {
                            spot_prev_symbol,
                            spot_play_symbol,
                            spot_next_symbol,
                            spacing = dpi(60),
                            layout = wibox.layout.fixed.horizontal
                        },
                        margins = dpi(6),
                        widget = wibox.container.margin
                    },
                    bg = beautiful.xcolor0,
                    shape = helpers.rrect(beautiful.border_radius),
                    widget = wibox.container.background
                },
                expand = "outside",
                layout = wibox.layout.align.horizontal
            },
            bg = beautiful.xbackground,
            shape = helpers.rrect(beautiful.border_radius),
            widget = wibox.container.background
        },
        left = dpi(40),
        right = dpi(40),
        bottom = dpi(40),
        top = dpi(0),
        layout = wibox.container.margin
    }

    if not toolbar_enabled_initially then
        awful.titlebar.hide(c, toolbar_position)
    end
end

table.insert(awful.rules.rules, {
    rule_any = {class = {"music"}, instance = {"music"}},
    properties = {},
    callback = spot_create_decoration
})

-- EOF ------------------------------------------------------------------------
