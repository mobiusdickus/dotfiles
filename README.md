# dotfiles

Personal config files managed with [GNU stow](https://www.gnu.org/software/stow/).

- **04/13/26: Neovim migrated to lazy.nvim, Zsh migrated to Prezto**
- **05/03/23: macOS on silicone**

## Dependencies

```bash
brew install stow neovim tree-sitter-cli ripgrep lsd
brew install --cask font-hack-nerd-font
```

Prezto (one-time):
```bash
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
```

## Usage

```bash
git clone https://github.com/mobiusdickus/dotfiles.git ~/projects/personal/dotfiles
cd ~/projects/personal/dotfiles

# Zsh (includes .zshrc and .zpreztorc)
stow zsh -t ~/

# Neovim
stow nvim -t ~/.config/nvim/

# Bash (legacy)
stow bash -t ~/
```

## Structure

```
├── nvim/
│   ├── init.lua          # Neovim config (lazy.nvim)
│   ├── init.vim.old      # Previous vim-plug config (backup)
│   └── README.md
├── zsh/
│   ├── .zshrc            # Zsh config (prezto + custom prompt/aliases)
│   ├── .zpreztorc        # Prezto module config
│   └── .zshrc.old        # Previous .zshrc (backup)
├── bash/
│   ├── .bashrc
│   ├── .bash_profile
│   └── .profile
├── git/
│   └── .gitconfig
├── vim/
│   └── vimrc
└── keybindings/
    └── .inputrc
```

It might be useful to separate work related configs in a `~/.work` file and source it from your shell config.
