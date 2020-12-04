local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require('beautiful').xresources.apply_dpi
local helpers = require('helpers')

local popupLib = {}

popupLib.create = function(x, y, height, width, widget)
    local widgetContainer = wibox.widget {
        {widget, margins = dpi(10), widget = wibox.container.margin},
        forced_height = height,
        forced_width = width,
        layout = wibox.layout.fixed.vertical
    }

    local widgetBG = wibox.widget {
        widgetContainer,
        bg = beautiful.xbackground,
        border_color = beautiful.widget_border_color,
        border_width = dpi(beautiful.widget_border_width),
        shape = helpers.rrect(beautiful.client_radius),
        widget = wibox.container.background
    }

    local popupWidget = awful.popup {
        widget = widgetBG,
        visible = false,
        ontop = true,
        x = x,
        y = y,
        bg = beautiful.xbackground .. "00"
    }

    local mouseInPopup = false
    local timer = gears.timer {
        timeout = 1.25,
        single_shot = true,
        callback = function()
            if not mouseInPopup then popupWidget.visible = false end
        end
    }

    popupWidget:connect_signal("mouse::leave", function()
        if popupWidget.visible then
            mouseInPopup = false
            timer:again()
        end
    end)

    popupWidget:connect_signal("mouse::enter",
                               function() mouseInPopup = true end)

    return popupWidget
end

return popupLib
