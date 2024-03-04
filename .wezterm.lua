local wezterm = require("wezterm")
local act = wezterm.action

------------------------ smart-splits.nvim --------------------------------------------
-- if you are *NOT* lazy-loading smart-splits.nvim (recommended)
local function is_vim(pane)
	-- this is set by the plugin, and unset on ExitPre in Neovim
	return pane:get_user_vars().IS_NVIM == "true"
end

local direction_keys = {
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

local function split_nav(resize_or_move, key)
	return {
		key = key,
		mods = resize_or_move == "resize" and "META" or "CTRL",
		action = wezterm.action_callback(function(win, pane)
			if is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = key, mods = resize_or_move == "resize" and "META" or "CTRL" },
				}, pane)
			else
				if resize_or_move == "resize" then
					win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
				else
					win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
				end
			end
		end),
	}
end

------------------------ Conditional Pane Activation (custom)  ------------------------
--
-- local function isViProcess(pane)
-- 	local nvim = pane:get_user_vars()["WEZTERM_PROG"]
-- 	return nvim:find("n?vim") ~= nil
-- end
--
-- local function conditionalActivatePane(window, pane, pane_direction, vim_direction)
-- 	wezterm.log_info(pane:get_user_vars())
-- 	if isViProcess(pane) then
-- 		wezterm.log_info("is vi process")
-- 		window:perform_action(
-- 			-- This should match the keybinds you set in Neovim.
-- 			act.SendKey({ key = vim_direction, mods = "CTRL" }),
-- 			pane
-- 		)
-- 	else
-- 		window:perform_action(act.ActivatePaneDirection(pane_direction), pane)
-- 	end
-- end

-- wezterm.on("ActivatePaneDirection-right", function(window, pane)
-- 	conditionalActivatePane(window, pane, "Right", "l")
-- end)

-- wezterm.on("ActivatePaneDirection-left", function(window, pane)
-- 	conditionalActivatePane(window, pane, "Left", "h")
-- end)

-- wezterm.on("ActivatePaneDirection-up", function(window, pane)
-- 	conditionalActivatePane(window, pane, "Up", "k")
-- end)

-- wezterm.on("ActivatePaneDirection-down", function(window, pane)
-- 	conditionalActivatePane(window, pane, "Down", "j")
-- end)

local config = {
	font = wezterm.font_with_fallback({
		"Iosevka Term SS14 Light",
		"JetBrainsMono Nerd Font",
		window_background_opacity = 0.95,
	}),
	font_size = 16.0,
	hide_tab_bar_if_only_one_tab = false,
	tab_bar_at_bottom = true,
	use_dead_keys = false,
	enable_tab_bar = true,
	use_fancy_tab_bar = true,
	window_decorations = "RESIZE",
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
	left = 20,
	right = 10,
	bottom = 0,
	top = 20,
}

config.window_frame = {
	font_size = 15.0,
	font = wezterm.font("JetBrainsMono Nerd Font"),
}

config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	split_nav("move", "h"),
	split_nav("move", "j"),
	split_nav("move", "k"),
	split_nav("move", "l"),
	-- resize panes
	split_nav("resize", "h"),
	split_nav("resize", "j"),
	split_nav("resize", "k"),
	split_nav("resize", "l"),

	{ key = '"', mods = "LEADER", action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
	{ key = "%", mods = "LEADER", action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
	-- { key = "c", mods = "LEADER", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },
	-- { key = "h", mods = "CTRL", action = act.EmitEvent("ActivatePaneDirection-left") },
	-- { key = "j", mods = "CTRL", action = act.EmitEvent("ActivatePaneDirection-down") },
	-- { key = "k", mods = "CTRL", action = act.EmitEvent("ActivatePaneDirection-up") },
	-- { key = "l", mods = "CTRL", action = act.EmitEvent("ActivatePaneDirection-right") },
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
