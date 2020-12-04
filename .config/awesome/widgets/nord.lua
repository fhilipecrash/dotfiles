local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local helpers = require("helpers")
local pad = helpers.pad

local c_cmd = function() awful.spawn.with_shell("nordvpn c United_States") end
local d_cmd = function() awful.spawn.with_shell("nordvpn d") end

local create_button = function(cmd, mkup)

    local text = wibox.widget {
        markup = mkup,
        align = 'center',
        font = 'JetBrains Mono 8',
        forced_width = dpi(60),
        widget = wibox.widget.textbox
    }

    local button = wibox.widget {
        {text, margins = dpi(10), layout = wibox.container.margin},
        shape = helpers.rrect(dpi(6)),
        bg = beautiful.xbackground,
        widget = wibox.container.background
    }

    button:buttons(gears.table.join(awful.button({}, 1, function() cmd() end)))

    button:connect_signal("mouse::enter", function()
        text.markup = helpers.colorize_text(text.text, beautiful.xcolor4)
    end)

    button:connect_signal("mouse::leave", function()
        text.markup = helpers.colorize_text(text.text, beautiful.xforeground)
    end)

    return button

end

local connect_button = create_button(c_cmd, "Connect")
local d_connect_button = create_button(d_cmd, "Disconnect")

local nord_box = wibox.widget {
    markup = 'Disconnected',
    align = 'center',
    font = 'JetBrains Mono 12',
    widget = wibox.widget.textbox
}

local box_image = wibox.widget {
    image = gears.surface.load_uncached(
        gears.filesystem.get_configuration_dir() .. "images/nord_d.png"),
    shape = helpers.rrect(dpi(10)),
    widget = wibox.widget.imagebox
}

local image_cont = wibox.widget {
    box_image,
    shape = helpers.rrect(dpi(6)),
    widget = wibox.container.background
}

local align_vertical = {

    nil,
    nord_box,
    {
        connect_button,
        nil,
        d_connect_button,
        spacing = dpi(10),
        layout = wibox.layout.flex.horizontal
    },
    layout = wibox.layout.align.vertical
}
-- align_vertical:set_top(nil)
-- align_vertical:set_middle(nil)
-- align_vertical:set_bottom(text_area)
local area = wibox.layout.fixed.horizontal()
area:add(image_cont)
area:add(wibox.container.margin(align_vertical, dpi(30), dpi(20), 0, 0))
area.bg = beautiful.xcolor0

local main_wd = wibox.widget {
    area,
    left = dpi(20),
    right = dpi(3),
    forced_width = dpi(200),
    forced_height = dpi(100),
    shape = helpers.rrect(dpi(6)),
    bg = beautiful.xcolor0,
    widget = wibox.container.margin
}

awesome.connect_signal("ears::nord_status", function(status, city, country)
    if status then
        nord_box.markup = city .. ", " .. country
        box_image:set_image(gears.surface.load_uncached(
                                gears.filesystem.get_configuration_dir() ..
                                    "images/nord_c.png"))
    else
        nord_box.markup = "Disconnected"
        box_image:set_image(gears.surface.load_uncached(
                                gears.filesystem.get_configuration_dir() ..
                                    "images/nord_d.png"))
    end
end)

return main_wd
