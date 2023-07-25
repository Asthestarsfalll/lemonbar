#!/usr/bin/lua

local lemonbar = "lemonbar -d -p -o 3"

local config = require("config")
local layout = require("layout")

local font_size = config.font_size
local outer_gap = config.outer_gap
local height = config.height
local font = config.font
local x = outer_gap
local width
local scale = config.scale

local function fonts(names)
	local output = ""
	for font in names:gmatch("([^,]+)") do
		output = output .. ' -f "' .. font .. '"-' .. font_size
	end
	return output
end

local function actions(widget)
	if widget.action == nil then
		return ""
	end
	local output = ""
	if widget.action.lclick ~= nil then
		output = output .. "%{A:" .. widget.action.lclick .. ":}"
		I = I + 1
	end
	if widget.action.mclick ~= nil then
		output = output .. "%{A2:" .. widget.action.mclick .. ":}"
		I = I + 1
	end
	if widget.action.rclick ~= nil then
		output = output .. "%{A3:" .. widget.action.rclick .. ":}"
		I = I + 1
	end
	if widget.action.scrollup ~= nil then
		output = output .. "%{A4:" .. widget.action.scrollup .. ":}"
		I = I + 1
	end
	if widget.action.scrolldown ~= nil then
		output = output .. "%{A5:" .. widget.action.scrolldown .. ":}"
		I = I + 1
	end
	return output
end

for _, widget in ipairs(layout.left) do
	I = 0
	width = math.ceil((2 * widget.inner_gap + widget.len) * font_size * scale)
	if widget.command == "lua ./workspace.lua" then
		os.execute("echo " .. x + widget.inner_gap * font_size .. " > ./.x")
		os.execute("echo " .. width - widget.inner_gap * font_size .. " > ./.width")
	end
	os.execute(
		'while true; do echo "'
			.. actions(widget)
			.. "$("
			.. widget.command
			.. string.rep(" ", widget.inner_gap)
			.. ") "
			.. ("%{A}"):rep(I)
			.. '" ; sleep '
			.. widget.interval
			.. "; done | "
			.. lemonbar
			.. fonts(font)
			.. ' -F "#'
			.. widget.color.foreground
			.. '" -B "#'
			.. widget.color.background
			.. '" -g '
			.. ("%d"):format(width)
			.. "x"
			.. height
			.. "+"
			.. ("%d"):format(x)
			.. "+"
			.. outer_gap
			.. " &"
	)
	x = x + width + outer_gap
end

x = config.screen_size[2] - outer_gap

for _, widget in ipairs(layout.right) do
	I = 0
	width = math.ceil((2 * widget.inner_gap + widget.len) * font_size * scale)
	x = x - width
	os.execute(
		'while true; do echo "'
			.. actions(widget)
			.. string.rep(" ", widget.inner_gap)
			.. "$("
			.. widget.command
			.. ") "
			.. ("%{A}"):rep(I)
			.. '" ; sleep '
			.. widget.interval
			.. "; done | "
			.. lemonbar
			.. fonts(font)
			.. ' -F "#'
			.. widget.color.foreground
			.. '" -B "#'
			.. widget.color.background
			.. '" -g '
			.. ("%d"):format(width)
			.. "x"
			.. height
			.. "+"
			.. ("%d"):format(x)
			.. "+"
			.. outer_gap
			.. " &"
	)
	x = x - outer_gap
end
