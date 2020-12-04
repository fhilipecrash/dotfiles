local awful = require("awful")

local update_interval = 15

local status = false
local city = "Rice Fields"
local country = "Communist State"
local status_cmd1 = "nordvpn status"
local status_cmd2 = "nordvpn status | grep City | cut -d ':' -f2"
local status_cmd3 = "nordvpn status | grep Country | cut -d ':' -f2"

awful.widget.watch(status_cmd1, update_interval, function(_, stdout)
    if stdout:find("Disconnected") then
        status = false
        city = "None"
        country = "None"
    else
        status = true
        awful.spawn.easy_async_with_shell(status_cmd2, function(out)
            city = out:match("^%s*(.-)%s*$")
        end)
        awful.spawn.easy_async_with_shell(status_cmd3, function(out)
            country = out:match("^%s*(.-)%s*$")
        end)
    end
    awesome.emit_signal("ears::nord_status", status, city, country)
end)
