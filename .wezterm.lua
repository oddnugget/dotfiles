local wezterm = require("wezterm")

return {
	font = wezterm.font_with_fallback({
		"JetBrains Mono ExtraLight",
		"JetBrains Mono Nerd Font Regular",
	}),
	font_size = 14.0,
	use_dead_keys = false,
	enable_tab_bar = false,
	enable_kitty_keyboard = false,
	audible_bell = "Disabled",
	send_composed_key_when_left_alt_is_pressed = false,
	color_scheme = "Catppuccin Macchiato",
}
