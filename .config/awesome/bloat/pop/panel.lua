-- panel.lua
-- Panel Widget
local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local helpers = require("helpers")
local icon_theme = "sheet"
local icons = require("icons")
local popupLib = require("utils.popupLib")

icons.init(icon_theme)

local box_radius = beautiful.client_radius
local box_gap = dpi(8)

local function create_boxed_widget(widget_to_be_boxed, width, height, bg_color)
    local box_container = wibox.container.background()
    box_container.bg = bg_color
    box_container.forced_height = height
    box_container.forced_width = width
    box_container.shape = helpers.rrect(box_radius)

    local boxed_widget = wibox.widget {
        {
            {
                nil,
                {
                    nil,
                    widget_to_be_boxed,
                    layout = wibox.layout.align.vertical,
                    expand = "none"
                },
                layout = wibox.layout.align.horizontal
            },
            widget = box_container
        },
        margins = box_gap,
        color = "#FF000000",
        widget = wibox.container.margin
    }
    return boxed_widget
end

-- Helper function that changes the appearance of progress bars and their icons
-- Create horizontal rounded bars
local function format_progress_bar(bar, markup)
    local text = wibox.widget {
        markup = markup,
        align = 'center',
        valign = 'center',
        font = 'JetBrains Mono 12',
        widget = wibox.widget.textbox
    }
    text.forced_height = dpi(36)
    text.forced_width = dpi(36)
    text.resize = true
    bar.forced_width = dpi(215)
    bar.shape = gears.shape.rounded_bar
    bar.bar_shape = gears.shape.rounded_bar

    -- bar.forced_height = dpi(30)
    -- bar.paddings = dpi(4)
    -- bar.border_width = dpi(2)
    -- bar.border_color = x.color8

    local w = wibox.widget {
        nil,
        {text, bar, spacing = dpi(10), layout = wibox.layout.fixed.horizontal},
        expand = "none",
        layout = wibox.layout.align.horizontal
    }
    return w
end

--- {{{ Volume Widget

local volume_bar = require("widgets.volume_bar")
local volume = format_progress_bar(volume_bar, "<span foreground='" ..
                                       beautiful.xcolor10 ..
                                       "'><b>VOL</b></span>")

apps_volume = function()
    helpers.run_or_raise({class = 'Pavucontrol'}, true, "pavucontrol")
end

volume:buttons(gears.table.join( -- Left click - Mute / Unmute
                   awful.button({}, 1, function() helpers.volume_control(0) end),
    -- Scroll - Increase / Decrease volume
                   awful.button({}, 4, function() helpers.volume_control(5) end),
                   awful.button({}, 5, function() helpers.volume_control(-5) end)))

-- }}}
--
--- {{{ Brightness Widget

local brightness_icon = wibox.widget.imagebox(icons.brightness)
local brightness_bar = require("widgets.brightness_bar")
local brightness = format_progress_bar(brightness_bar, "<span foreground='" ..
                                           beautiful.xcolor12 ..
                                           "'><b>SUN</b></span>")

-- local brightness = require("widgets.brightness_arc")

--- }}}

--- {{{ Ram Widget

-- local ram = require("widgets.ram_arc")

local ram_icon = wibox.widget.imagebox(icons.ram)
local ram_bar = require("widgets.ram_bar")
local ram = format_progress_bar(ram_bar, "<span foreground='" ..
                                    beautiful.xcolor11 .. "'><b>RAM</b></span>")

--- }}}

--- {{{ Cpu Widget

-- local cpu = require("widgets.cpu_arc")

local cpu_icon = wibox.widget.imagebox(icons.cpu)
local cpu_bar = require("widgets.cpu_bar")
local cpu = format_progress_bar(cpu_bar, "<span foreground='" ..
                                    beautiful.xcolor13 .. "'><b>CPU</b></span>")

--- }}}

--- {{{ Clock

local fancy_time_widget = wibox.widget.textclock("%H%M")
fancy_time_widget.markup = fancy_time_widget.text:sub(1, 2) ..
                               "<span foreground='" .. beautiful.xcolor12 ..
                               "'>" .. fancy_time_widget.text:sub(3, 4) ..
                               "</span>"
fancy_time_widget:connect_signal("widget::redraw_needed", function()
    fancy_time_widget.markup = fancy_time_widget.text:sub(1, 2) ..
                                   "<span foreground='" .. beautiful.xcolor12 ..
                                   "'>" .. fancy_time_widget.text:sub(3, 4) ..
                                   "</span>"
end)
fancy_time_widget.align = "center"
fancy_time_widget.valign = "center"
fancy_time_widget.font = "JetBrains Mono 55"

local fancy_time = {fancy_time_widget, layout = wibox.layout.fixed.vertical}

local fancy_date_widget = wibox.widget.textclock("%m/%d/%Y")
fancy_date_widget.markup = fancy_date_widget.text:sub(1, 3) ..
                               "<span foreground='" .. beautiful.xcolor12 ..
                               "'>" .. fancy_date_widget.text:sub(4, 6) ..
                               "</span>" .. "<span foreground='" ..
                               beautiful.xcolor6 .. "'>" ..
                               fancy_date_widget.text:sub(7, 10) .. "</span>"
fancy_date_widget:connect_signal("widget::redraw_needed", function()
    fancy_date_widget.markup = fancy_date_widget.text:sub(1, 3) ..
                                   "<span foreground='" .. beautiful.xcolor12 ..
                                   "'>" .. fancy_date_widget.text:sub(4, 6) ..
                                   "</span>" .. "<span foreground='" ..
                                   beautiful.xcolor6 .. "'>" ..
                                   fancy_date_widget.text:sub(7, 10) ..
                                   "</span>"

end)
fancy_date_widget.align = "center"
fancy_date_widget.valign = "center"
fancy_date_widget.font = "JetBrains Mono 12"

local fancy_date = {fancy_date_widget, layout = wibox.layout.fixed.vertical}

---}}}

-- {{{ Music Widget

--[[
local mpd = require("widgets.mpd")
local mpd_box = create_boxed_widget(mpd, 400, 125, beautiful.xcolor0)
local mpd_area = {
    nil,
    {
        mpd_box,
        left = dpi(5),
        right = dpi(5),
        top = dpi(0),
        bottom = dpi(0),
        layout = wibox.container.margin
    },
    nil,
    layout = wibox.layout.align.vertical
}
--]]

local spot = require("widgets.spot")
local spot_box = create_boxed_widget(spot, 400, nil, beautiful.xcolor0)

-- }}}

--[[
local nord = require("widgets.nord")
local nord_box = create_boxed_widget(nord, 400, 135, beautiful.xcolor0)
local nord_area = {
    nil,
    {
        nord_box,
        left = dpi(5),
        right = dpi(5),
        top = dpi(0),
        bottom = dpi(0),
        layout = wibox.container.margin
    },
    nil,
    layout = wibox.layout.align.vertical
}
-]]
-- {{{ Info Widget

local info = require("widgets.info")
local info_box = create_boxed_widget(info, 400, 125, beautiful.xcolor0)

---}}}

local sys = wibox.widget {
    volume,
    brightness,
    cpu,
    ram,
    layout = wibox.layout.flex.vertical
}
local sys_box = create_boxed_widget(sys, 400, 225, beautiful.xcolor0)

local time = wibox.widget {
    {fancy_time, fancy_date, layout = wibox.layout.align.vertical},
    top = dpi(10),
    left = dpi(20),
    right = dpi(20),
    bottom = dpi(10),
    widget = wibox.container.margin
}

local time_box = create_boxed_widget(time, 400, 159, beautiful.xcolor0)

local panelWidget = wibox.widget {
    info_box,
    time_box,
    {sys_box, spot_box, layout = wibox.layout.align.vertical},
    layout = wibox.layout.align.vertical
}

local width = 400
local margin = 10

local panelPop = popupLib.create(margin, beautiful.wibar_height + margin, nil,
                                 width, panelWidget)

panelPop:set_xproperty("WM_NAME", "panel")

return panelPop

-- EOF ------------------------------------------------------------------------
