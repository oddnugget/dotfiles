local wezterm = require("wezterm")
local act = wezterm.action

local function isViProcess(pane)
	local nvim = pane:get_user_vars()["WEZTERM_PROG"]
	return nvim:find("n?vim") ~= nil
end

local function conditionalActivatePane(window, pane, pane_direction, vim_direction)
	if isViProcess(pane) then
		window:perform_action(
			-- This should match the keybinds you set in Neovim.
			act.SendKey({ key = vim_direction, mods = "CTRL" }),
			pane
		)
	else
		window:perform_action(act.ActivatePaneDirection(pane_direction), pane)
	end
end

wezterm.on("ActivatePaneDirection-right", function(window, pane)
	conditionalActivatePane(window, pane, "Right", "l")
end)
wezterm.on("ActivatePaneDirection-left", function(window, pane)
	conditionalActivatePane(window, pane, "Left", "h")
end)
wezterm.on("ActivatePaneDirection-up", function(window, pane)
	conditionalActivatePane(window, pane, "Up", "k")
end)
wezterm.on("ActivatePaneDirection-down", function(window, pane)
	conditionalActivatePane(window, pane, "Down", "j")
end)

local config = {
	font = wezterm.font_with_fallback({
		"Iosevka Term SS14 Light",
		"JetBrainsMono Nerd Font",
		window_background_opacity = 0.95,
	}),
	font_size = 16.0,
	hide_tab_bar_if_only_one_tab = true,
	tab_bar_at_bottom = true,
	use_dead_keys = false,
	enable_tab_bar = true,
	use_fancy_tab_bar = true,
	window_decorations = "RESIZE",
	-- enable_kitty_keyboard = true,
	audible_bell = "Disabled",
	send_composed_key_when_left_alt_is_pressed = false,
	force_reverse_video_cursor = true,
	color_scheme = "Kanagawa (Gogh)",
	unix_domains = {
		{ name = "unix" },
		{ name = "obsidian" },
	},
}

config.window_padding = {
	left = 4,
	right = 4,
	bottom = 0,
	top = 2,
}

config.window_frame = {
	font_size = 15.0,
	font = wezterm.font("JetBrainsMono Nerd Font"),
}

config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	{ key = '"', mods = "LEADER", action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
	{ key = "%", mods = "LEADER", action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
	{ key = "c", mods = "LEADER", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },
	{ key = "h", mods = "CTRL", action = act.EmitEvent("ActivatePaneDirection-left") },
	{ key = "j", mods = "CTRL", action = act.EmitEvent("ActivatePaneDirection-down") },
	{ key = "k", mods = "CTRL", action = act.EmitEvent("ActivatePaneDirection-up") },
	{ key = "l", mods = "CTRL", action = act.EmitEvent("ActivatePaneDirection-right") },
	{ key = "1", mods = "LEADER", action = wezterm.action({ ActivateTab = 0 }) },
	{ key = "2", mods = "LEADER", action = wezterm.action({ ActivateTab = 1 }) },
	{ key = "3", mods = "LEADER", action = wezterm.action({ ActivateTab = 2 }) },
	{ key = "4", mods = "LEADER", action = wezterm.action({ ActivateTab = 3 }) },
	{ key = "5", mods = "LEADER", action = wezterm.action({ ActivateTab = 4 }) },
	{ key = "6", mods = "LEADER", action = wezterm.action({ ActivateTab = 5 }) },
	{ key = "7", mods = "LEADER", action = wezterm.action({ ActivateTab = 6 }) },
	{ key = "8", mods = "LEADER", action = wezterm.action({ ActivateTab = 7 }) },
	{ key = "9", mods = "LEADER", action = wezterm.action({ ActivateTab = 8 }) },
	{ key = "n", mods = "LEADER", action = wezterm.action({ ActivateTabRelative = 1 }) },
	{ key = "p", mods = "LEADER", action = wezterm.action({ ActivateTabRelative = -1 }) },
	{ key = "d", mods = "LEADER", action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
}

return config
