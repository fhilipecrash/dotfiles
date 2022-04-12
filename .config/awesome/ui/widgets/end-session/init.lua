local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local clickable_container = require("ui.widgets.clickable-container")
local helpers = require("helpers")

local return_button = function()

	local widget = wibox.widget {
		{
			align = "center",
			valign = "center",
			font = beautiful.icon_font_name .. 18,
			markup = helpers.colorize_text("", beautiful.xforeground),
			widget = wibox.widget.textbox()
		},
		layout = wibox.layout.align.horizontal
	}

	local widget_button = wibox.widget {
		{
			{
				widget,
				margins = dpi(8),
				widget = wibox.container.margin
			},
			widget = clickable_container
		},
		bg = beautiful.transparent,
		shape = gears.shape.circle,
		widget = wibox.container.background
	}

	widget_button:buttons(
		gears.table.join(
			awful.button(
				{},
				1,
				nil,
				function()
					awesome.emit_signal('module::exit_screen:show')
					control_center_toggle()
				end
			)
		)
	)

	return widget_button
end

return return_button
