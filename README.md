# Nuggets Dotfiles
These dotfiles are managed by [dotbot](https://github.com/anishathalye/dotbot)

To install
```
git clone git@github.com:oddnugget/dotfiles.git --recursive
cd dotfiles && ./install
```

`./install` is safe to re-run. macOS-only configs (aerospace, kitty, wezterm, raycast, obsidian) are linked only on Darwin.

## Dependencies
- zsh, [starship](https://starship.rs), [zoxide](https://github.com/ajeetdsouza/zoxide), [fzf](https://github.com/junegunn/fzf)
- [lsd](https://github.com/lsd-rs/lsd), [bat](https://github.com/sharkdp/bat), [ripgrep](https://github.com/BurntSushi/ripgrep), [delta](https://github.com/dandavison/delta)
- tmux >= 3.2
- Neovim >= 0.12 and the [tree-sitter CLI](https://github.com/tree-sitter/tree-sitter/blob/master/crates/cli/README.md) >= 0.26.1 (not from npm) for building parsers
