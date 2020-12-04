local naughty = require("naughty")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")
local awful = require("awful")
local dpi = beautiful.xresources.apply_dpi
local helpers = require("helpers")

require("notifs.brightness")
require("notifs.volume")
require("notifs.battery")

naughty.config.defaults.ontop = true
naughty.config.defaults.icon_size = dpi(32)
naughty.config.defaults.screen = awful.screen.focused()
naughty.config.defaults.timeout = 3
naughty.config.defaults.title = "System Notification"
naughty.config.defaults.margin = dpi(20)
naughty.config.defaults.border_width = beautiful.widget_border_width
naughty.config.defaults.border_color = beautiful.widget_border_color
naughty.config.defaults.position = "top_right"
naughty.config.defaults.shape = helpers.rrect(0)

naughty.config.padding = dpi(10)
naughty.config.spacing = dpi(5)
naughty.config.icon_dirs = {
    "/usr/share/icons/Papirus-Dark/24x24/apps/", "/usr/share/pixmaps/"
}
naughty.config.icon_formats = {"png", "svg"}

-- Timeouts
naughty.config.presets.low.timeout = 3
naughty.config.presets.critical.timeout = 0

naughty.config.presets.normal = {
    font = beautiful.font,
    fg = beautiful.fg_normal,
    bg = beautiful.bg_normal,
    position = "top_right"
}

naughty.config.presets.low = {
    font = beautiful.font,
    fg = beautiful.fg_normal,
    bg = beautiful.bg_normal,
    position = "top_right"
}

naughty.config.presets.critical = {
    font = "JetBrains Mono Bold 10",
    fg = "#ffffff",
    bg = "#ff0000",
    position = "top_right",
    timeout = 0
}

naughty.config.presets.ok = naughty.config.presets.normal
naughty.config.presets.info = naughty.config.presets.normal
naughty.config.presets.warn = naughty.config.presets.critical

--[[ naughty.connect_signal("request::display", function(n)

    naughty.layout.box {
        notification = n,
        type = "notification",
        widget_template = {
            {
                {
                    {
                        {
                            {
                                naughty.widget.icon,
                                {
                                    naughty.widget.title,
                                    naughty.widget.message,
                                    spacing = 4,
                                    layout = wibox.layout.fixed.vertical
                                },
                                fill_space = true,
                                spacing = 4,
                                layout = wibox.layout.fixed.horizontal
                            },
                            naughty.list.actions,
                            spacing = 10,
                            layout = wibox.layout.fixed.vertical
                        },
                        margins = 10,
                        widget = wibox.container.margin
                    },
                    id = "background_role",
                    widget = naughty.container.background
                },
                strategy = "max",
                width = beautiful.notification_max_width or
                    beautiful.xresources.apply_dpi(500),
                widget = wibox.container.constraint
            },
            bg = beautiful.xbackground,
            border_color = beautiful.widget_border_color,
            border_width = beautiful.widget_border_width,
            shape = helpers.rrect(beautiful.client_radius),
            widget = wibox.container.background
        }
    }
end)
--]]
