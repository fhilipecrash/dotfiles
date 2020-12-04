-- Emacs Padding
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local helpers = require("helpers")
local keys = require("keys")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local padding = dpi(20)

local emacs_create_decoration = function(c)
    awful.titlebar(c, {
        position = "bottom",
        size = padding,
        bg = beautiful.xbackground
    })

    awful.titlebar(c, {
        position = "top",
        size = padding,
        bg = beautiful.xbackground
    })

    awful.titlebar(c, {
        position = "right",
        size = padding,
        bg = beautiful.xbackground
    })

    awful.titlebar(c, {
        position = "left",
        size = padding,
        bg = beautiful.xbackground
    })
end

table.insert(awful.rules.rules, {
    rule_any = {class = {"emacs"}, instance = {"emacs"}},
    properties = {},
    callback = emacs_create_decoration
})

-- EOF ------------------------------------------------------------------------
