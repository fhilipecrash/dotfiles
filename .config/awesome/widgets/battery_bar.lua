local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local helpers = require("helpers")

local active_color = {
    type = 'linear',
    from = {0, 0},
    to = {75, 20}, -- replace with w,h later
    stops = {
        {0, beautiful.xcolor9}, {0.5, beautiful.xcolor11},
        {1, beautiful.xcolor10}
    }
}

local background_color = beautiful.xcolor0

local battery_bar = wibox.widget {
    max_value = 100,
    value = 50,
    forced_height = dpi(10),
    margins = {top = dpi(10), bottom = dpi(10)},
    forced_width = dpi(200),
    shape = helpers.rrect(beautiful.border_radius),
    bar_shape = helpers.rrect(beautiful.border_radius),
    color = active_color,
    background_color = background_color,
    border_width = 0,
    border_color = beautiful.border_color,
    widget = wibox.widget.progressbar
}

local battery_tooltip = awful.tooltip {}
battery_tooltip:add_to_object(battery_bar)
battery_tooltip.text = 'Not Updated'

awesome.connect_signal("ears::battery", function(value)
    battery_bar:connect_signal('mouse::enter', function()
        battery_tooltip.text = value .. '%'
    end)
end)

local q = 0
local g = gears.timer {
    timeout = 0.03,
    call_now = false,
    autostart = false,
    callback = function()

        if q >= 100 then q = 0 end
        q = q + 1
        battery_bar.value = q
        battery_bar.color = {
            type = 'linear',
            from = {0, 0},
            to = {75 - (100 - q), 20},
            stops = {
                {1 + (q) / 100, beautiful.xcolor10},
                {0.75 - (q / 100), beautiful.xcolor1},
                {1 - (q) / 100, beautiful.xcolor10}
            }
        }
    end
}

awesome.connect_signal("ears::charger", function(plugged)

    awesome.connect_signal("ears::battery", function(value)
        if plugged then
            g:start()
        else
            g:stop()
            battery_bar.value = value
            battery_bar.color = {
                type = 'linear',
                from = {0, 0},
                to = {75 - (100 - value), 20},
                stops = {
                    {1 + (value) / 100, beautiful.xcolor10},
                    {0.75 - (value / 100), beautiful.xcolor9},
                    {1 - (value) / 100, beautiful.xcolor10}
                }
            }

        end
    end)

end)

return battery_bar
