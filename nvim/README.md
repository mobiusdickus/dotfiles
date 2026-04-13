# Neovim

Neovim configuration using [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager.

## Prerequisites

```bash
brew install neovim tree-sitter-cli ripgrep lsd
brew install --cask font-hack-nerd-font
```

Set "Hack Nerd Font" in your terminal (iTerm2 → Profiles → Text → Font).

## Setup

```bash
cd ~/projects/personal/dotfiles
stow nvim -t ~/.config/nvim/
```

Open `nvim` — lazy.nvim bootstraps itself and installs all plugins on first launch. Mason will auto-install language servers.

## Plugins

| Category | Plugin | Purpose |
|----------|--------|---------|
| Theme | catppuccin | Colorscheme (mocha) |
| Status | lualine | Status line |
| Files | nvim-tree | File explorer |
| Search | telescope | Fuzzy finder (files, grep, buffers) |
| Syntax | treesitter | Syntax highlighting via AST |
| LSP | nvim-lspconfig + mason | Language servers (pyright, ts_ls, gopls, terraformls, lua_ls) |
| LSP UI | lspsaga | Enhanced LSP interactions |
| Completion | nvim-cmp | Autocompletion (LSP, buffer, path) |
| Git | fugitive + gitsigns | Git commands + inline signs |
| Database | vim-dadbod + dadbod-ui | SQL client |
| Editing | nvim-surround, autopairs, Comment.nvim | Surround, auto-pairs, commenting |
| Motion | flash.nvim | Quick jump |
| Keys | which-key | Keybinding cheatsheet |
| HTML | emmet-vim | Emmet abbreviations |

## Key Bindings

Leader: `,`

| Key | Action |
|-----|--------|
| `,n` | Toggle file tree |
| `,t` | Find files |
| `,a` | Live grep |
| `,b` | Buffers |
| `,r` | Tags |
| `,db` | Toggle DB UI |
| `,w` + char | Surround word |
| `,Tab` / `,`` ` | Next/prev buffer |
| `s` | Flash jump |
| `gd` | Go to definition |
| `gr` | Find references |
| `K` | Hover docs |
| `,rn` | Rename symbol |
| `,ca` | Code action |
| `,e` | Line diagnostics |
| `,o` | Outline |
| `[d` / `]d` | Prev/next diagnostic |

## Old Config

The previous vim-plug config is preserved in `init.vim.old`.
