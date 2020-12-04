local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local icons = require("icons")
icons.init("sheet")

local active_color = {
    type = 'linear',
    from = {0, 0},
    to = {200, 50}, -- replace with w,h later
    stops = {{0, beautiful.xcolor6}, {0.75, beautiful.xcolor4}}
}

local text = {
    markup = "<b>VOL</b>",
    align = 'center',
    font = "Jetbrains Mono 15",
    widget = wibox.widget.textbox
}

local icon = {
    id = "icon",
    image = icons.volume,
    resize = true,
    widget = wibox.widget.imagebox
}

local volume_arc = wibox.widget {
    icon,
    max_value = 100,
    thickness = 8,
    start_angle = 4.71238898, -- 2pi*3/4
    forced_height = 100,
    rounded_edge = true,
    forced_width = 100,
    bg = beautiful.xbackground,
    paddings = 10,
    colors = {active_color},
    widget = wibox.container.arcchart
}

awesome.connect_signal("ears::volume", function(volume, muted)
    if muted then
        volume_arc.bg = beautiful.xcolor1
    else
        volume_arc.bg = beautiful.xbackground
    end

    volume_arc.value = volume
end)

return volume_arc
