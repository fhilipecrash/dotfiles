-- wibar.lua
-- Wibar (top bar)
local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local helpers = require("helpers")
local icon_theme = "sheet"
local icons = require("icons")

local systray_margin = (beautiful.wibar_height - beautiful.systray_icon_size) /
                           2

-- Helper function that changes the appearance of progress bars and their icons
-- Create horizontal rounded bars
local function format_progress_bar(bar, icon)
    icon.forced_height = dpi(27)
    icon.forced_width = dpi(36)
    icon.resize = true
    bar.forced_width = dpi(100)
    bar.shape = gears.shape.rounded_bar
    bar.bar_shape = gears.shape.rounded_bar

    local w = wibox.widget {
        nil,
        {icon, bar, layout = wibox.layout.fixed.horizontal},
        expand = "none",
        layout = wibox.layout.align.horizontal
    }
    return w
end

-- Awesome Panel -----------------------------------------------------------

-- Init music, panel, and cal
-- local mpd = require("widgets.mpd")
local panelPop = require('bloat.pop.panel')
local calPop = require('bloat.pop.cal')
local awesome_icon = wibox.widget {
    {widget = wibox.widget.imagebox, image = icons.awesome, resize = true},
    layout = wibox.container.margin(awesome_icon, 0, 0, 0)
}

awesome_icon:connect_signal("mouse::enter",
                            function() panelPop.visible = true end)
panelPop:connect_signal("mouse::leave", function()
    panelPop.visible = false
    calPop.visible = false
end)

-- Notifs Panel ---------------------------------------------------------------

local notifPop = require("bloat.pop.notif")
local notif_icon = wibox.widget {
    widget = wibox.widget.imagebox,
    image = icons.notif,
    resize = true
}

notif_icon:connect_signal("mouse::enter", function() notifPop.visible = true end)
notifPop:connect_signal("mouse::leave", function() notifPop.visible = false end)

-- Battery Bar Widget ---------------------------------------------------------

local battery_icon = wibox.widget.imagebox(nil)
local battery_bar = require("widgets.battery_bar")
local battery = format_progress_bar(battery_bar, battery_icon)

-- Systray Widget -------------------------------------------------------------

local mysystray = wibox.widget.systray()
mysystray:set_base_size(beautiful.systray_icon_size)

local mysystray_container = {
    mysystray,
    left = dpi(8),
    right = dpi(8),
    screen = 1,
    widget = wibox.container.margin
}

-- Taglist Widget -------------------------------------------------------------

local taglist_buttons = gears.table.join(
                            awful.button({}, 1, function(t) t:view_only() end),
                            awful.button({modkey}, 1, function(t)
        if client.focus then client.focus:move_to_tag(t) end
    end), awful.button({}, 3, awful.tag.viewtoggle),
                            awful.button({modkey}, 3, function(t)
        if client.focus then client.focus:toggle_tag(t) end
    end), awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
                            awful.button({}, 5, function(t)
        awful.tag.viewprev(t.screen)
    end))

-- Tasklist Widget ------------------------------------------------------------

local tasklist_buttons = gears.table.join(
                             awful.button({}, 1, function(c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal("request::activate", "tasklist", {raise = true})
        end
    end), awful.button({}, 3, function()
        awful.menu.client_list({theme = {width = 250}})
    end), awful.button({}, 4, function() awful.client.focus.byidx(1) end),
                             awful.button({}, 5, function()
        awful.client.focus.byidx(-1)
    end))

-- Create the Wibar -----------------------------------------------------------

awful.screen.connect_for_each_screen(function(s)
    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Create layoutbox widget
    s.mylayoutbox = awful.widget.layoutbox(s)

    if s.index == 1 then
        mysystray_container.visible = true
    else
        mysystray_container.visible = false
    end

    -- Create the wibox
    s.mywibox = awful.wibar({
        position = "top",
        screen = s,
        ontop = true,
        bg = beautiful.wibar_bg,
        size = beautiful.wibar_height
    })
    s.mywibox:set_xproperty("WM_NAME", "wibar")

    -- Remove wibar on full screen
    local function remove_wibar(c)
        if c.fullscreen or c.maximized then
            s.mywibox.visible = false
        else
            s.mywibox.visible = true
        end
    end

    client.connect_signal("property::fullscreen", remove_wibar)

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        style = {shape = gears.shape.rectangle},
        layout = {spacing = 0, layout = wibox.layout.fixed.horizontal},
        widget_template = {
            {
                {
                    {id = 'text_role', widget = wibox.widget.textbox},
                    layout = wibox.layout.fixed.horizontal
                },
                left = 11,
                right = 11,
                widget = wibox.container.margin
            },
            id = 'background_role',
            widget = wibox.container.background
        },
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        style = {shape = helpers.rrect(beautiful.border_radius)},
        layout = {spacing = 10, layout = wibox.layout.fixed.horizontal},
        widget_template = {
            {
                {
                    {id = 'text_role', widget = wibox.widget.textbox},
                    layout = wibox.layout.flex.horizontal
                },
                left = dpi(12),
                right = dpi(12),
                widget = wibox.container.margin
            },
            id = 'background_role',
            widget = wibox.container.background
        }
    }

    -- Add widgets to the wibox
    s.mywibox:setup{
        layout = wibox.layout.align.horizontal,
        expand = "none",
        {
            layout = wibox.layout.fixed.horizontal,
            {
                {
                    awesome_icon,
                    shape = helpers.rrect(beautiful.border_radius),
                    bg = beautiful.xcolor0,
                    widget = wibox.container.background
                },
                margins = dpi(5),
                widget = wibox.container.margin
            },
            {
                {
                    s.mytaglist,
                    shape = helpers.rrect(beautiful.border_radius),
                    bg = beautiful.xbackground,
                    widget = wibox.container.background
                },
                margins = dpi(5),
                widget = wibox.container.margin
            },
            s.mypromptbox
        },
        {s.mytasklist, margins = dpi(5), widget = wibox.container.margin},
        {
            {battery, right = dpi(5), widget = wibox.container.margin},
            helpers.horizontal_pad(0),
            {
                {
                    {
                        mysystray_container,
                        top = dpi(4),
                        layout = wibox.container.margin
                    },
                    shape = helpers.rrect(beautiful.border_radius),
                    bg = beautiful.xcolor0,
                    widget = wibox.container.background
                },
                margins = dpi(5),
                widget = wibox.container.margin
            },
            helpers.horizontal_pad(0),
            {
                {
                    {
                        notif_icon,
                        margins = dpi(2),
                        widget = wibox.container.margin
                    },
                    shape = helpers.rrect(beautiful.border_radius),
                    bg = beautiful.xcolor0,
                    widget = wibox.container.background
                },
                margins = dpi(5),
                widget = wibox.container.margin
            },

            {
                {
                    {
                        s.mylayoutbox,
                        margins = dpi(4),
                        widget = wibox.container.margin
                    },
                    shape = helpers.rrect(beautiful.border_radius),
                    bg = beautiful.xcolor0,
                    widget = wibox.container.background
                },
                margins = dpi(5),
                widget = wibox.container.margin
            },

            layout = wibox.layout.fixed.horizontal
        }
    }
end)

-- EOF ------------------------------------------------------------------------
