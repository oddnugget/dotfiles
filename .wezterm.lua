-- local os = require("os")
local wezterm = require("wezterm")
-- local act = wezterm.action

local config = {
	font = wezterm.font("JetBrains Mono Regular"),
	font_size = 16.0,
	hide_tab_bar_if_only_one_tab = false,
	tab_bar_at_bottom = false,
	use_dead_keys = false,
	enable_tab_bar = false,
	use_fancy_tab_bar = false,
	window_decorations = "RESIZE",
	audible_bell = "Disabled",
	color_scheme = "Catppuccin Macchiato",
	disable_default_key_bindings = true
}

config.keys = {
  -- CTRL-SHIFT-l activates the debug overlay
  { key = 'L', mods = 'SUPER|CTRL', action = wezterm.action.ShowDebugOverlay },
  { key = 't', mods = 'SUPER', action = wezterm.action.SpawnTab 'DefaultDomain' },
  { key = 'n', mods = 'SUPER', action = wezterm.action.SpawnWindow  },
  { key = 'w', mods = 'SUPER', action = wezterm.action.CloseCurrentTab { confirm = true} },
  { key = 'v', mods = 'SUPER', action = wezterm.action.PasteFrom "Clipboard"},
  { key = 'c', mods = 'SUPER', action = wezterm.action.PasteFrom "Clipboard"},
}



-- config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }

-- config.keys = {
-- 	-- Copy mode
-- 	{
-- 		key = "[",
-- 		mods = "LEADER",
-- 		action = act.ActivateCopyMode,
-- 	},

-- 	-- Show tab navigator; similar to listing panes in tmux
-- 	{
-- 		key = "w",
-- 		mods = "LEADER",
-- 		action = act.ShowTabNavigator,
-- 	},
-- 	-- Create a tab (alternative to Ctrl-Shift-Tab)
-- 	{
-- 		key = "c",
-- 		mods = "LEADER",
-- 		action = act.SpawnTab("CurrentPaneDomain"),
-- 	},
-- 	-- Rename current tab; analagous to command in tmux
-- 	{
-- 		key = ",",
-- 		mods = "LEADER",
-- 		action = act.PromptInputLine({
-- 			description = "Enter new name for tab",
-- 			action = wezterm.action_callback(function(window, _, line)
-- 				if line then
-- 					window:active_tab():set_title(line)
-- 				end
-- 			end),
-- 		}),
-- 	},
-- 	-- Move to next/previous TAB
-- 	{
-- 		key = "n",
-- 		mods = "LEADER",
-- 		action = act.ActivateTabRelative(1),
-- 	},
-- 	{
-- 		key = "p",
-- 		mods = "LEADER",
-- 		action = act.ActivateTabRelative(-1),
-- 	},
-- 	-- Close tab
-- 	{
-- 		key = "&",
-- 		mods = "LEADER|SHIFT",
-- 		action = act.CloseCurrentTab({ confirm = true }),
-- 	},

-- 	-- ----------------------------------------------------------------
-- 	-- PANES
-- 	--
-- 	-- These are great and get me most of the way to replacing tmux
-- 	-- entirely, particularly as you can use "wezterm ssh" to ssh to another
-- 	-- server, and still retain Wezterm as your terminal there.
-- 	-- ----------------------------------------------------------------

-- 	-- -- Vertical split
-- 	{
-- 		-- |
-- 		key = "v",
-- 		mods = "LEADER",
-- 		action = act.SplitPane({
-- 			direction = "Right",
-- 			size = { Percent = 50 },
-- 		}),
-- 	},
-- 	-- Horizontal split
-- 	{
-- 		-- -
-- 		key = "s",
-- 		mods = "LEADER",
-- 		action = act.SplitPane({
-- 			direction = "Down",
-- 			size = { Percent = 50 },
-- 		}),
-- 	},
-- 	{
-- 		key = "h",
-- 		mods = "LEADER",
-- 		action = act({ ActivatePaneDirection = "Left" }),
-- 	},
-- 	{
-- 		key = "j",
-- 		mods = "LEADER",
-- 		action = act({ ActivatePaneDirection = "Down" }),
-- 	},
-- 	{
-- 		key = "k",
-- 		mods = "LEADER",
-- 		action = act({ ActivatePaneDirection = "Up" }),
-- 	},
-- 	{
-- 		key = "l",
-- 		mods = "LEADER",
-- 		action = act({ ActivatePaneDirection = "Right" }),
-- 	},
-- 	-- ALT + (h,j,k,l) to resize panes
-- 	{
-- 		key = "h",
-- 		mods = "ALT",
-- 		action = act({ EmitEvent = "resize-left" }),
-- 	},
-- 	{
-- 		key = "j",
-- 		mods = "ALT",
-- 		action = act({ EmitEvent = "resize-down" }),
-- 	},
-- 	{
-- 		key = "k",
-- 		mods = "ALT",
-- 		action = act({ EmitEvent = "resize-up" }),
-- 	},
-- 	{
-- 		key = "l",
-- 		mods = "ALT",
-- 		action = act({ EmitEvent = "resize-right" }),
-- 	},
-- 	-- Close/kill active pane
-- 	{
-- 		key = "x",
-- 		mods = "LEADER",
-- 		action = act.CloseCurrentPane({ confirm = true }),
-- 	},
-- 	-- Swap active pane with another one
-- 	{
-- 		key = "{",
-- 		mods = "LEADER|SHIFT",
-- 		action = act.PaneSelect({ mode = "SwapWithActiveKeepFocus" }),
-- 	},
-- 	-- Zoom current pane (toggle)
-- 	{
-- 		key = "z",
-- 		mods = "LEADER",
-- 		action = act.TogglePaneZoomState,
-- 	},
-- 	{
-- 		key = "f",
-- 		mods = "ALT",
-- 		action = act.TogglePaneZoomState,
-- 	},
-- 	-- Move to next/previous pane
-- 	{
-- 		key = ";",
-- 		mods = "LEADER",
-- 		action = act.ActivatePaneDirection("Prev"),
-- 	},
-- 	-- Rotate panes
-- 	{
-- 		key = "o",
-- 		mods = "LEADER",
-- 		action = act.ActivatePaneDirection("Next"),
-- 	},
-- 	{
-- 		key = "b",
-- 		mods = "CTRL",
-- 		action = act.RotatePanes("CounterClockwise"),
-- 	},
-- 	{ key = "n", mods = "CTRL", action = act.RotatePanes("Clockwise") },
-- }

return config
