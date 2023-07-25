local c = require("themes/" .. "catppuccin_frappe")
local config = require("config")
local inner_gap = config.inner_gap
local low = config.low_priority
local middle = config.middle_priority
local high = config.high_priority

-- local handle = assert(io.popen("xdotool get_num_desktops", "r"))
-- local num = assert(handle:read("*a"))
-- handle:close()
local num = 3

local widgets = {}
local terminal = "st -c float "

local theme = {
	foreground = c.pink,
	background = c.base,
	secondary = c.blue,
	fade = c.surface2,
	fade2 = c.surface0,
}

widgets.battery = {
	color = {
		foreground = theme.foreground,
		background = theme.background,
	},
	action = {
		lclick = "powerprofilesctl set power-saver && dunstify -h string\\:x-dunst-stack-tag\\:power-mode Power-saver mode",
		mclick = "powerprofilesctl set balanced && dunstify -h string\\:x-dunst-stack-tag\\:power-mode Balanced mode",
		rclick = "powerprofilesctl set performance && dunstify -h string\\:x-dunst-stack-tag\\:power-mode Performance mode",
	},
	command = "./battery.sh",
	len = 4,
	interval = low,
	inner_gap = inner_gap,
}

widgets.workspace = {
	color = {
		foreground = theme.fade,
		background = theme.background,
		focus = theme.foreground,
		occupied = theme.secondary,
	},
	action = {
		lclick = "xdotool set_desktop $(lua ./switch-workspace.lua)",
		rclick = "xdotool set_desktop_for_window $(xdotool getwindowfocus) $(lua ./switch-workspace.lua)$",
	},
	command = "lua ./workspace.lua",
	len = num + (num + 1) * 1.5,
	interval = high,
	inner_gap = inner_gap,
}

widgets.date = {
	color = {
		foreground = theme.secondary,
		background = theme.background,
	},
	action = {
		lclick = terminal .. " -e calcurse",
		rclick = terminal .. " -e nvim ~/.todo.md",
	},
	command = "./date.sh",
	len = 8,
	interval = low,
	inner_gap = inner_gap,
}

widgets.time = {
	color = {
		foreground = theme.foreground,
		background = theme.background,
	},
	action = {
		lclick = terminal .. " tty-clock -s -c -C 5 -D",
	},
	command = 'echo " $(date "+%H:%M")"',
	len = 4,
	interval = middle,
	inner_gap = inner_gap,
}

widgets.backlight = {
	color = {
		foreground = theme.foreground,
		background = theme.background,
	},
	action = {
		lclick = "light -S 20",
		scrollup = "light -A 5",
		scrolldown = "light -U 5",
	},
	command = "echo  $(light -G | cut -d . -f 1)",
	len = 3,
	interval = 0.1,
	inner_gap = inner_gap,
}

widgets.memory = {
	color = {
		foreground = theme.foreground,
		background = theme.background,
	},
	action = {
		lclick = terminal .. " htop",
	},
	command = "echo ' ' $(free -h --mega | sed -n 2p | awk '{print substr($3, 1, length($3)-1) \"/\" $2}')",
	len = 5,
	interval = middle,
	inner_gap = inner_gap,
}

widgets.cpu = {
	color = {
		foreground = theme.foreground,
		background = theme.background,
	},
	action = {},
	command = "echo ' '閭 $(top -n 1 -b | sed -n '3p' | awk '{printf \"%02d%\", 100 - $8}')",
	--   $(sensors | grep Package | awk '{print substr($4, 2)}'
	len = 2,
	interval = middle,
	inner_gap = inner_gap,
}

widgets.tempture = {
	color = {
		foreground = theme.foreground,
		background = theme.background,
	},
	command = "echo ' '🌡$(sensors | grep Package | awk '{print substr($4, 2)}')",
	len = 3,
	interval = low,
	inner_gap = inner_gap,
}

widgets.wifi = {
	color = {
		foreground = theme.secondary,
		background = theme.background,
	},
	action = {
		lclick = terminal .. " nmtui",
	},
	command = "echo 直 $(nmcli | grep 已连接 | awk '{print $3}')",
	len = 7,
	interval = low,
	inner_gap = inner_gap,
}

widgets.music = {
	color = {
		foreground = theme.secondary,
		background = theme.background,
		control = theme.foreground,
		bar = theme.fade2,
	},
	action = {
		lclick = terminal .. "cava",
		scrollup = "playerctl position 5+",
		scrolldown = "playerctl position 5-",
	},
	command = "lua ./music.lua",
	len = 15,
	interval = middle,
	inner_gap = inner_gap,
}

widgets.volumebar = {
	color = {
		foreground = theme.secondary,
		background = theme.background,
		muted = theme.fade,
		high = theme.foreground,
		barbg = theme.fade2,
	},
	action = {
		lclick = "amixer set Master toggle -q",
		scrollup = "amixer set Master 5%+ -q",
		scrolldown = "amixer set Master 5%- -q",
	},
	command = "lua ./volumebar.lua",
	len = 8,
	interval = high,
	inner_gap = inner_gap,
}

widgets.cava = {
	color = {
		foreground = theme.foreground,
		background = theme.background,
	},
	action = {
		lclick = terminal .. "cava",
	},
	command = "lua ./cava.lua",
	len = 5,
	interval = 0,
	inner_gap = inner_gap,
}

widgets.special = {
	color = {
		foreground = theme.foreground,
		background = theme.background,
	},
	action = {
		lclick = "feh --randomize --bg-fill " .. config.wallpaper_dir .. "*.png",
		rclick = "feh --bg-fill " .. config.wallpaper_dir .. config.default_wallpaper,
		mclick = "exit 0",
	},
	command = "echo --",
	len = 1,
	interval = 1000,
	inner_gap = inner_gap,
}

return widgets
