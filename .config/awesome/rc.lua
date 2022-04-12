pcall(require, "luarocks.loader")
--[[
 _____ __ _ __ _____ _____ _____ _______ _____
|     |  | |  |  ___|  ___|     |       |  ___|
|  -  |  | |  |  ___|___  |  |  |  | |  |  ___|
|__|__|_______|_____|_____|_____|__|_|__|_____|
               ~ AestheticArch ~
            https://github.com/rxyhn
--]]

-- 📚 Library
local gfs = require("gears.filesystem")
local awful = require("awful")
local beautiful = require("beautiful")
dpi = beautiful.xresources.apply_dpi

-- 🎨 Themes
themes = {
      "day",      -- [1] 🌕 Beautiful Light Colorscheme
      "night",    -- [2] 🌑 Aesthetic Dark Colorscheme
}

theme = themes[2]
beautiful.init(gfs.get_configuration_dir() .. "theme/" .. theme .."/theme.lua")

-- 🌊 Default Applications
terminal = "alacritty"
editor = terminal .. " -e " .. os.getenv("EDITOR")
vscode = "code"
browser = "google-chrome-stable"
launcher = "rofi -show drun -theme " .. gfs.get_configuration_dir() .. "theme/rofi.rasi"
file_manager = "nautilus"
music_client = terminal .. " --class music -e ncmpcpp"

-- 🌏 Weather API
openweathermap_key = "5a89d1a76e30a20bdafacd21bd86ec45" -- API Key
openweathermap_city_id = "3393001" -- City ID
weather_units = "metric" -- Unit

-- 🖥 Screen
screen_width = awful.screen.focused().geometry.width
screen_height = awful.screen.focused().geometry.height

-- 🚀 Launch Autostart
awful.spawn.with_shell(gfs.get_configuration_dir() .. "configuration/autostart")

-- 🤖 Import Configuration & module
require("configuration")
require("module")

-- ✨ Import Daemons, UI & Widgets
require("signal")
require("ui")

-- 🗑 Garbage Collector Settings
collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)

