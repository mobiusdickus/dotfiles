# dotfiles

Personal config files managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Setup

```bash
git clone https://github.com/mobiusdickus/dotfiles.git ~/projects/personal/dotfiles
cd ~/projects/personal/dotfiles
```

```bash
brew install stow neovim tree-sitter-cli ripgrep lsd
brew install --cask font-hack-nerd-font
```

### Zsh + Zprezto

```bash
./setup-zsh.sh
```

Clones [Zprezto](https://github.com/sorin-ionescu/prezto), stows zsh configs, and sets zsh as default shell.

### Neovim

```bash
./setup-nvim.sh
```

Stows `init.lua` into `~/.config/nvim/` and syncs [lazy.nvim](https://github.com/folke/lazy.nvim) plugins.

## Structure

```
├── zsh/
│   ├── .zshrc            # Zsh config (prezto + custom prompt/aliases)
│   ├── .zshenv           # Env vars for non-interactive shells
│   ├── .zprofile         # Login shell setup (PATH, tools)
│   └── .zpreztorc        # Prezto module config
├── nvim/.config/nvim/
│   └── init.lua          # Neovim config (lazy.nvim)
├── git/
│   └── .gitconfig
├── bash/
│   ├── .bashrc
│   ├── .bash_profile
│   └── .profile
├── keybindings/
│   └── .inputrc
├── setup-zsh.sh
└── setup-nvim.sh
```

## Notes

- Secrets (API keys, tokens) live in `~/.secrets` (sourced from `.zshrc`, not tracked).
- Work credentials live in `~/.work` (sourced from `.zshenv`, not tracked).
