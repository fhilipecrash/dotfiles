-- notif.lua
-- Notification Popup Widget
local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local popupLib = require("utils.popupLib")

local popupWidget = wibox.widget {
    require("notifs.notif-center"),
    expand = "none",
    layout = wibox.layout.fixed.horizontal
}

local width = 400
local margin = 10

local popup = popupLib.create(awful.screen.focused().geometry.width - width -
                                  margin, beautiful.wibar_height + margin, nil,
                              width, popupWidget)

popup:set_xproperty("WM_NAME", "panel")

return popup

-- EOF ------------------------------------------------------------------------
