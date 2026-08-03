---@module 'hl'

-- core keybinds
local mod = "SUPER"

hl.bind(mod .. " + Return", hl.dsp.exec_cmd("ghostty"))
hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + SHIFT" .. " + " .. "Q", hl.dsp.exit())

hl.bind(mod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + j", hl.dsp.focus({ direction = "down" }))

hl.bind(mod .. " + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind(mod .. " + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind(mod .. " + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind(mod .. " + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind(mod .. " + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind(mod .. " + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind(mod .. " + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind(mod .. " + 8", hl.dsp.focus({ workspace = 8 }))
hl.bind(mod .. " + 9", hl.dsp.focus({ workspace = 9 }))
hl.bind(mod .. " + 0", hl.dsp.focus({ workspace = 10 }))

hl.bind(mod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))
hl.bind(mod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = 2 }))
hl.bind(mod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
hl.bind(mod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
hl.bind(mod .. " + SHIFT + 5", hl.dsp.window.move({ workspace = 5 }))
hl.bind(mod .. " + SHIFT + 6", hl.dsp.window.move({ workspace = 6 }))
hl.bind(mod .. " + SHIFT + 7", hl.dsp.window.move({ workspace = 7 }))
hl.bind(mod .. " + SHIFT + 8", hl.dsp.window.move({ workspace = 8 }))
hl.bind(mod .. " + SHIFT + 9", hl.dsp.window.move({ workspace = 9 }))
hl.bind(mod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

hl.bind(mod .. " + SHIFT + h", hl.dsp.window.move({ direction = "l" }))
hl.bind(mod .. " + SHIFT + l", hl.dsp.window.move({ direction = "r" }))
hl.bind(mod .. " + SHIFT + k", hl.dsp.window.move({ direction = "u" }))
hl.bind(mod .. " + SHIFT + j", hl.dsp.window.move({ direction = "d" }))

-- Float/Tile
hl.bind(mod .. " + SHIFT + Space", hl.dsp.window.float())
hl.bind(mod .. " + f", hl.dsp.window.fullscreen())
hl.bind(mod .. " + t", hl.dsp.group.toggle())

-- let me control splits
hl.config({
	dwindle = {
		force_split = 2,
		preserve_split = true,
	},
})
hl.bind(mod .. " + v", hl.dsp.layout("preselect r"))
hl.bind(mod .. " + b", hl.dsp.layout("preselect d"))

-- quickly run programs
hl.bind(mod .. " + Space", hl.dsp.exec_cmd("albert toggle"))
hl.bind(mod .. " + Print", hl.dsp.exec_cmd("flameshot screen -e -n $(hyprctl activeworkspace -j| jq '.monitorID')"))
hl.bind(mod .. " + SHIFT" .. " + " .. "Print", hl.dsp.exec_cmd("screenrecord"))

hl.config({
	general = {
		gaps_in = 0,
		gaps_out = 0,
		allow_tearing = true,
	},
	misc = {
		middle_click_paste = false,
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
	},
	ecosystem = {
		no_update_news = true,
	},
	input = {
		kb_options = "caps:escape",
	},
	cursor = {
		persistent_warps = true,
	},
	binds = {
		-- Fire a drag event only after dragging for more than 10px
		drag_threshold = 10,
	},
})

hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true }) -- LMB
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true }) -- RMB

-- https://gist.github.com/brunoanc/2dea6ddf6974ba4e5d26c3139ffb7580
-- exec-once = wl-clip-persist --clipboard regular
-- move cursor to center

-- desktop monitors
local left = "DP-3"
local center = "DP-1"
local right = "DP-2"
local mode = "2560x1440@165"

hl.monitor({ mode = mode, position = "0x0", output = left })
hl.monitor({ mode = mode, position = "2560x0", output = center })
hl.monitor({ mode = mode, position = "5120x0", output = right })

hl.workspace_rule({ workspace = "1", monitor = left })
hl.workspace_rule({ workspace = "2", monitor = left })
hl.workspace_rule({ workspace = "3", monitor = left })
hl.workspace_rule({ workspace = "4", monitor = center })
hl.workspace_rule({ workspace = "5", monitor = center })
hl.workspace_rule({ workspace = "6", monitor = center })
hl.workspace_rule({ workspace = "7", monitor = center })
hl.workspace_rule({ workspace = "8", monitor = right })
hl.workspace_rule({ workspace = "9", monitor = right })
hl.workspace_rule({ workspace = "10", monitor = right })

hl.window_rule({
	name = "ignore-fullscreen",
	match = { class = ".*" },
	suppress_event = "fullscreen maximize",
})

-- hl.window_rule({
-- 	name = "ignore-float",
-- 	match = { float = true },
-- 	float = false
-- })

hl.window_rule({
	name  = "app-launcher",
	match = {
		class = "albert",
	},
	border_size = 0,
	no_shadow = true,
	dim_around = true,
	no_anim = true,
	stay_focused = true,
})

hl.on("hyprland.start", function()
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("wpaperd -d")
	hl.exec_cmd("waybar")
	hl.exec_cmd("flameshot")
	hl.exec_cmd("albert")
	hl.exec_cmd("hyprctl dispatch workspace 4") -- center cursor
end)
