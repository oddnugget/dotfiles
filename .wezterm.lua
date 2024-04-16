local wezterm = require("wezterm")

------------------------ smart-splits.nvim --------------------------------------------
local function is_vim(pane)
	return pane:get_user_vars().IS_NVIM == "true"
end

local config = {
	font = wezterm.font_with_fallback({
		"Iosevka Term SS14 Light",
		"JetBrainsMono Nerd Font",
		window_background_opacity = 0.95,
	}),
	-- debug_key_events = true,
	font_size = 17.0,
	hide_tab_bar_if_only_one_tab = false,
	tab_bar_at_bottom = true,
	use_dead_keys = false,
	enable_tab_bar = false,
	use_fancy_tab_bar = true,
	window_decorations = "RESIZE",
	audible_bell = "Disabled",
	-- send_composed_key_when_left_alt_is_pressed = false,
	-- force_reverse_video_cursor = true,
	color_scheme = "Kanagawa (Gogh)",
}

config.window_padding = {
	left = 20,
	right = 10,
	bottom = 0,
	top = 40,
}

config.window_frame = {
	font_size = 15.0,
	font = wezterm.font("JetBrainsMono Nerd Font"),
}

-- config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	-- split_nav("move", "h"),
	-- split_nav("move", "j"),
	-- split_nav("move", "k"),
	-- split_nav("move", "l"),

	-- { key = '"', mods = "LEADER", action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
	-- { key = "%", mods = "LEADER", action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
	-- { key = "c", mods = "LEADER", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },
	-- { key = "h", mods = "SHIFT|CMD", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
	-- { key = "j", mods = "SHIFT|CMD", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
	-- { key = "k", mods = "SHIFT|CMD", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
	-- { key = "l", mods = "SHIFT|CMD", action = wezterm.action({ ActivatePaneDirection = "Right" }) },
	-- { key = "1", mods = "LEADER", action = wezterm.action({ ActivateTab = 0 }) },
	-- { key = "2", mods = "LEADER", action = wezterm.action({ ActivateTab = 1 }) },
	-- { key = "3", mods = "LEADER", action = wezterm.action({ ActivateTab = 2 }) },
	-- { key = "4", mods = "LEADER", action = wezterm.action({ ActivateTab = 3 }) },
	-- { key = "5", mods = "LEADER", action = wezterm.action({ ActivateTab = 4 }) },
	-- { key = "6", mods = "LEADER", action = wezterm.action({ ActivateTab = 5 }) },
	-- { key = "7", mods = "LEADER", action = wezterm.action({ ActivateTab = 6 }) },
	-- { key = "8", mods = "LEADER", action = wezterm.action({ ActivateTab = 7 }) },
	-- { key = "9", mods = "LEADER", action = wezterm.action({ ActivateTab = 8 }) },
	-- { key = "n", mods = "LEADER", action = wezterm.action({ ActivateTabRelative = 1 }) },
	-- { key = "p", mods = "LEADER", action = wezterm.action({ ActivateTabRelative = -1 }) },
	-- { key = "d", mods = "LEADER", action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
}

return config
