local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local helpers = require("helpers")
local dpi = beautiful.xresources.apply_dpi

local offsetx = dpi(56)
local offsety = dpi(300)
local screen = awful.screen.focused()

local icon_theme = "sheet"
local icons = require("icons")
icons.init(icon_theme)

local bright_icon = icons.brightness

local active_color_1 = {
    type = 'linear',
    from = {0, 0},
    to = {200, 50}, -- replace with w,h later
    stops = {{0, beautiful.xcolor6}, {0.50, beautiful.xcolor4}}
}

-- create the bright_adjust component
local bright_adjust = wibox({
    screen = awful.screen.focused(),
    x = screen.geometry.width - offsetx - 8,
    y = (screen.geometry.height / 2) - (offsety / 2),
    width = dpi(48),
    height = offsety,
    shape = helpers.rrect(beautiful.client_radius),
    visible = false,
    border_width = 0,
    border_color = beautiful.xcolor0,
    ontop = true
})

local bright_bar = wibox.widget {
    widget = wibox.widget.progressbar,
    shape = gears.shape.rounded_bar,
    bar_shape = gears.shape.rounded_bar,
    color = active_color_1,
    background_color = beautiful.xcolor0,
    max_value = 100,
    value = 0
}

bright_adjust:setup{
    {
        {
            layout = wibox.layout.align.vertical,
            {
                wibox.container.margin(bright_bar, dpi(14), dpi(20), dpi(20),
                                       dpi(20)),
                forced_height = offsety * 0.75,
                direction = "east",
                layout = wibox.container.rotate
            },
            wibox.container.margin(wibox.widget {
                image = bright_icon,
                widget = wibox.widget.imagebox
            }, dpi(7), dpi(7), dpi(14), dpi(14))
        },
        shape = helpers.rrect(beautiful.client_radius),
        border_width = beautiful.widget_border_width,
        border_color = beautiful.widget_border_color,
        widget = wibox.container.background
    },
    bg = beautiful.xbackground .. "00",
    widget = wibox.container.background
}

-- create a 3 second timer to hide the volume adjust
-- component whenever the timer is started
local hide_bright_adjust = gears.timer {
    timeout = 3,
    autostart = true,
    callback = function() bright_adjust.visible = false end
}

awesome.connect_signal("ears::brightness", function(value)
    bright_bar.value = value
    if bright_adjust.visible then
        hide_bright_adjust:again()
    else
        bright_adjust.visible = true
        hide_bright_adjust:start()
    end
end)
