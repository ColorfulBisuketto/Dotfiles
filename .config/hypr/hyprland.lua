-- Main config file

-- Begin of the noctalia stuff

hl.on("hyprland.start", function()
	hl.exec_cmd("qs -c noctalia-shell")
end)

hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 10,
	},

	decoration = {
		rounding = 20,
		rounding_power = 2,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = "0xee1a1a1a",
		},

		blur = {
			enabled = true,
			size = 3,
			passes = 2,
			vibrancy = 0.1696,
		},
	},
})

hl.layer_rule({
	name = "noctalia",
	match = {
		namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$",
	},
	no_anim = true,
	ignore_alpha = 0.5,
	blur = true,
	blur_popups = true,
})

local mainMod = "SUPER"
local ipc = "qs -c noctalia-shell ipc call "

-- Core binds
hl.bind(mainMod .. "+Space", hl.dsp.exec_cmd(ipc .. "panel-toggle launcher"))
hl.bind(mainMod .. "+comma", hl.dsp.exec_cmd(ipc .. "settings-toggle"))
hl.bind("ALT + Tab", hl.dsp.exec_cmd(ipc .. "window-switcher"))

-- Media keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. "volume-up"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. "volume-down"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(ipc .. "volume-mute"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("hyprctl hyprsunset gamma +1%"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("hyprctl hyprsunset gamma -1%"))

-- Noctalia Settings
hl.window_rule({
	match = { class = "dev.noctalia.Noctalia" },
	float = true,
	size = { 1080, 920 },
})

-- Custom stuff starts here

local vars = require("vars")

hl.monitor({
	output = vars.mainMonitorDesc,
	mode = "1920x1080@144.03Hz",
	position = "0x0",
	scale = 1.20,
	vrr = 2,
})
hl.monitor({
	output = vars.secondaryMonitorDesc,
	mode = "1920x1080@60.00Hz",
	position = "1600x0",
	scale = 1,
})
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

hl.config({
	xwayland = {
		force_zero_scaling = true,
	},
	input = {
		kb_layout = "us",
		kb_variant = "de_se_fi",
		kb_model = "pc105",
		kb_options = "lv3:ralt_switch,fkeys:basic_13-24",
		kb_rules = "evdev",
		numlock_by_default = true,
		follow_mouse = 1,
		sensitivity = 0, -- 0 means no modification.
		touchpad = {
			natural_scroll = true,
			scroll_factor = 0.25,
		},
	},
	cursor = {
		no_hardware_cursors = 1,
	},
})

hl.device({
	name = "logitech-g203-lightsync-gaming-mouse",
	sensitivity = -0.5,
})
hl.device({
	name = "keychron--keychron-link--keyboard",
	kb_layout = "us",
	kb_variant = "de_se_fi",
	kb_model = "pc104",
	kb_options = "lv3:ralt_switch,fkeys:basic_13-24",
	kb_rules = "evdev",
})

-- Gestures
hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

-- Applications
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(vars.terminal))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd(vars.terminal, { float = true, move = { 0, 0 } }))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(vars.fileManager))

-- Window / Session controls
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd(ipc .. "sessionMenu toggle"))
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(ipc .. "launcher toggle"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(ipc .. "notifications toggleHistory"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd(ipc .. "lockScreen lock"))
hl.bind(mainMod .. " + CONTROL + V", hl.dsp.exec_cmd(ipc .. "launcher clipboard"))

hl.bind(mainMod .. " + V", hl.dsp.window.float())
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen())

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + LEFT", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + RIGHT", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + UP", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + DOWN", hl.dsp.focus({ direction = "d" }))

-- Switch workspaces with mainMod + [0-9]
for index, workspace in ipairs(vars.workspaces) do
	hl.bind(mainMod .. " + " .. index - 1, hl.dsp.focus({ workspace = workspace }))
end

-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for index, workspace in ipairs(vars.workspaces) do
	hl.bind(mainMod .. " + SHIFT + " .. index - 1, hl.dsp.window.move({ workspace = workspace }))
end

-- Move windows with the keyboard
hl.bind(mainMod .. " + SHIFT + LEFT", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + RIGHT", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + UP", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + DOWN", hl.dsp.window.move({ direction = "d" }))

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Move / resize windows with mainMod + LMB/RMB
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Custom stuff
hl.bind("CONTROL + SHIFT + S", hl.dsp.exec_cmd("take-screenshot.sh area"))
hl.bind("CONTROL + SHIFT + ALT + S", hl.dsp.exec_cmd("take-screenshot.sh screen"))

-- Wondowrules

hl.workspace_rule({
	workspace = "1",
	monitor = vars.mainMonitorDesc,
	default = true,
})
hl.workspace_rule({
	workspace = "2",
	monitor = vars.secondaryMonitorDesc,
	default = true,
})

hl.window_rule({
	name = "floating-tui-settings",
	match = {
		class = "(impala)|(bluetui)|(wiremix)",
	},

	float = true,
})
hl.window_rule({
	name = "zen-Picture-in-Picture",
	match = {
		class = "zen",
		initial_title = "Picture-in-Picture",
	},

	float = true,
})

hl.window_rule({
	name = "thunderbird-new-message",
	match = {
		class = "thunderbird",
		initial_title = "Write:.*",
	},

	float = true,
})

hl.window_rule({
	name = "steam-settings",
	match = {
		class = "steam",
		initial_title = "Steam Settings",
	},

	float = true,
})
