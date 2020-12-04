local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local helpers = require("helpers")
local pad = helpers.pad

-- Construct layouts
--------------------------------------------------------------------------------

-- Poster (image)
------------------------------------------------------------
local box_image = wibox.widget {
    shape = helpers.rrect(dpi(10)),
    widget = wibox.widget.imagebox
}

local image_cont = wibox.widget {
    box_image,
    shape = gears.shape.circle,
    widget = wibox.container.background
}

box_image:set_image(gears.filesystem.get_configuration_dir() .. "images/me.png")

------------------------------------------------------------

-- Text lines
------------------------------------------------------------
local mpd_title = wibox.widget {
    markup = "<span foreground='" .. beautiful.xcolor6 ..
        "'><b>FhilipeCrash</b></span>",
    widget = wibox.widget.textbox
}
local mpd_artist = wibox.widget {
    markup = "<span foreground='" .. beautiful.xcolor4 ..
        "'><b>Fhilipe Coelho</b></span>",
    widget = wibox.widget.textbox
}

mpd_title:set_font(beautiful.font)
mpd_title:set_valign("top")
mpd_artist:set_font("Iosevka Nerd Font 14")
mpd_artist:set_valign("top")

local text_area = wibox.layout.fixed.vertical()
text_area:add(wibox.container.constraint(mpd_artist, "exact", nil, dpi(26)))
text_area:add(wibox.container.constraint(mpd_title, "exact", nil, dpi(26)))
------------------------------------------------------------

-- Bring it all together
------------------------------------------------------------
local align_vertical = wibox.layout.align.vertical()
align_vertical:set_top(nil)
align_vertical:set_middle(text_area)
align_vertical:set_bottom(nil)
local area = wibox.layout.fixed.horizontal()
area:add(image_cont)
area:add(wibox.container.margin(align_vertical, dpi(30), dpi(20), dpi(25), 0))
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

return main_wd
