# Nuggets Dotfiles
These dotfiles are managed by [chezmoi](https://chezmoi.io). Configs stay in their tool folders
(`nvim/`, `zsh/`, …) and `home/` holds the chezmoi entries that symlink them into place, so
editing `~/.config/nvim` edits this repo.

To install on a new machine
```
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply oddnugget
```

On a machine that already has this repo cloned
```
chezmoi init --apply --source ~/dotfiles
```

Run `chezmoi apply` after pulling to pick up new links and tools.

See [GUIDE.md](GUIDE.md) for how everything fits together, the keybinds and troubleshooting.

## Machine types
`home/.chezmoi.toml.tmpl` sets `devbox = true` when `/devbox` exists.
- **devbox**: CLI tools come from the devbox binwrappers; mise only installs the language servers.
- **everything else**: mise installs the CLI tools too.

macOS-only configs (aerospace, kitty, wezterm, raycast, obsidian) are skipped elsewhere via `home/.chezmoiignore`.

## Tools
[mise](https://mise.jdx.dev) installs the tools listed in `home/private_dot_config/mise/config.toml.tmpl`.
`home/run_onchange_after_install-tools.sh.tmpl` installs mise if needed and re-runs
`mise install` whenever that list changes.

Still needed from the system or Homebrew: zsh, tmux >= 3.2, git, a C compiler (for treesitter parsers).

## Legacy: dotbot
`./install` (dotbot) still works and links the same files. It will be removed once chezmoi is verified.
