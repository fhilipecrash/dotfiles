-- Special thanks to elenapan
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local helpers = require("helpers")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local update_interval = 5

local art = wibox.widget {
    image = gears.filesystem.get_configuration_dir() .. "images/default.png",
    resize = true,
    forced_height = dpi(80),
    forced_width = dpi(80),
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
        forced_height = dpi(30),
        forced_width = dpi(30),
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

local title_widget = wibox.widget {
    markup = 'This <i>is</i> a <b>textbox</b>!!!',
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

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

    title_widget:set_markup_silently(
        '<span foreground="' .. beautiful.xcolor5 .. '">' .. stdout .. '</span>')

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

local spot = wibox.widget {
    {art, margins = dpi(0), layout = wibox.container.margin},
    {
        {
            title_widget,
            {
                nil,
                {
                    spot_prev_symbol,
                    spot_play_symbol,
                    spot_next_symbol,
                    spacing = dpi(60),
                    layout = wibox.layout.fixed.horizontal
                },
                nil,
                expand = "none",
                layout = wibox.layout.align.horizontal
            },
            layout = wibox.layout.align.vertical
        },
        top = dpi(5),
        bottom = dpi(5),
        widget = wibox.container.margin
    },
    layout = wibox.layout.align.horizontal
}

return spot
