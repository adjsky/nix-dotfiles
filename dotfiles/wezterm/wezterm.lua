local wezterm = require("wezterm")

local custom_color_scheme = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
custom_color_scheme.background = "#1e2030"
custom_color_scheme.tab_bar.background = "transparent"

local keys = {
	{
		key = "c",
		mods = "SUPER",
		action = wezterm.action.CopyTo("Clipboard"),
	},
	{
		key = "c",
		mods = "CTRL|SHIFT",
		action = wezterm.action.CopyTo("Clipboard"),
	},

	{
		key = "v",
		mods = "SUPER",
		action = wezterm.action.PasteFrom("Clipboard"),
	},
	{
		key = "v",
		mods = "CTRL|SHIFT",
		action = wezterm.action.PasteFrom("Clipboard"),
	},

	{
		key = "=",
		mods = "SUPER",
		action = wezterm.action.IncreaseFontSize,
	},
	{
		key = "=",
		mods = "CTRL",
		action = wezterm.action.IncreaseFontSize,
	},

	{
		key = "-",
		mods = "SUPER",
		action = wezterm.action.DecreaseFontSize,
	},
	{
		key = "-",
		mods = "CTRL",
		action = wezterm.action.DecreaseFontSize,
	},

	{
		key = "0",
		mods = "SUPER",
		action = wezterm.action.ResetFontSize,
	},
	{
		key = "0",
		mods = "CTRL",
		action = wezterm.action.ResetFontSize,
	},

	{
		key = "t",
		mods = "SUPER",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "t",
		mods = "CTRL",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},

	{
		key = "1",
		mods = "SUPER",
		action = wezterm.action.ActivateTab(0),
	},
	{
		key = "1",
		mods = "CTRL",
		action = wezterm.action.ActivateTab(0),
	},

	{
		key = "2",
		mods = "SUPER",
		action = wezterm.action.ActivateTab(1),
	},
	{
		key = "2",
		mods = "CTRL",
		action = wezterm.action.ActivateTab(1),
	},

	{
		key = "3",
		mods = "SUPER",
		action = wezterm.action.ActivateTab(2),
	},
	{
		key = "3",
		mods = "CTRL",
		action = wezterm.action.ActivateTab(2),
	},

	{
		key = "4",
		mods = "SUPER",
		action = wezterm.action.ActivateTab(3),
	},
	{
		key = "4",
		mods = "CTRL",
		action = wezterm.action.ActivateTab(3),
	},

	{
		key = "5",
		mods = "SUPER",
		action = wezterm.action.ActivateTab(4),
	},
	{
		key = "5",
		mods = "CTRL",
		action = wezterm.action.ActivateTab(4),
	},

	{
		key = "w",
		mods = "SUPER",
		action = wezterm.action.CloseCurrentTab({ confirm = true }),
	},
	{
		key = "w",
		mods = "CTRL",
		action = wezterm.action.CloseCurrentTab({ confirm = true }),
	},

	{
		key = "%",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SplitHorizontal({
			domain = "CurrentPaneDomain",
		}),
	},
	{
		key = '"',
		mods = "CTRL|SHIFT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "RightArrow",
		mods = "CTRL|SHIFT",
		action = wezterm.action.AdjustPaneSize({ "Right", 1 }),
	},
	{
		key = "LeftArrow",
		mods = "CTRL|SHIFT",
		action = wezterm.action.AdjustPaneSize({ "Left", 1 }),
	},
	{
		key = "UpArrow",
		mods = "CTRL|SHIFT",
		action = wezterm.action.AdjustPaneSize({ "Up", 1 }),
	},
	{
		key = "DownArrow",
		mods = "CTRL|SHIFT",
		action = wezterm.action.AdjustPaneSize({ "Down", 1 }),
	},
	{
		key = "LeftArrow",
		mods = "CTRL",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "RightArrow",
		mods = "CTRL",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		key = "UpArrow",
		mods = "CTRL",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "DownArrow",
		mods = "CTRL",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
}

local config = {
	font = wezterm.font("JetBrains Mono"),
	font_size = 14,
	front_end = "WebGpu",

	default_cursor_style = "BlinkingBar",

	disable_default_key_bindings = true,

	window_padding = {
		left = 6,
		right = 6,
		top = 6,
		bottom = 6,
	},
	animation_fps = 60,

	color_schemes = {
		["custom"] = custom_color_scheme,
	},
	color_scheme = "custom",

	keys = keys,
}

wezterm.plugin.require("https://github.com/nekowinston/wezterm-bar").apply_to_config(config, {
	position = "bottom",
	max_width = 32,
	dividers = "slant_right",
	indicator = {
		leader = {
			enabled = true,
			off = " ",
			on = " ",
		},
		mode = {
			enabled = true,
			names = {
				resize_mode = "RESIZE",
				copy_mode = "VISUAL",
				search_mode = "SEARCH",
			},
		},
	},
	tabs = {
		numerals = "arabic",
		pane_count = "superscript",
		brackets = {
			active = { "", ":" },
			inactive = { "", ":" },
		},
	},
	clock = {
		enabled = false,
	},
})

return config
