# Neovim

Neovim configuration using [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager.

## Setup

```bash
cd ~/projects/personal/dotfiles
./setup-nvim.sh
```

Requires [Homebrew](https://brew.sh). This installs only what's needed for nvim to actually run — `stow`, plus `neovim`/`tree-sitter-cli`/`ripgrep` (treesitter and telescope, both core plugins, need those two) — stows the config, and syncs plugins via lazy.nvim.

Open `nvim` — Mason auto-installs language servers on first launch. `pyright`/`ts_ls` need Node (`npm`), `gopls` needs `go`; missing either just breaks those specific installs (see Troubleshooting).

Everything else is optional and not installed by the script — see the top-level README's integrations table:
- **Hack Nerd Font**: without it, icons in nvim-tree/bufferline/lualine render as blank boxes. Install and set it as your terminal's font.
- **deno**: without it, only `peek.nvim`'s markdown-preview build fails; the rest of nvim is unaffected.

## Troubleshooting

- **Icons render as blank boxes**: install a Nerd Font and set it as your terminal's font (e.g. iTerm2 → Settings → Profiles → Text → Font → "Hack Nerd Font Mono"). Only applies to new windows/tabs — reopen the one you're testing in.
- **Mason fails on `pyright`/`ts_ls`/`gopls`**: install Node (`nvm`) and/or Go, then retry — `:Mason` and press `i` on the failed rows, or `:MasonInstall pyright typescript-language-server gopls` (Mason's package name differs from the `ts_ls` lspconfig name).

## Plugins

| Category | Plugin | Purpose |
|----------|--------|---------|
| Theme | catppuccin | Colorscheme (mocha) |
| Status | lualine | Status line |
| Files | nvim-tree | File explorer |
| Search | telescope | Fuzzy finder (files, grep, buffers) |
| Search | telescope-file-browser | File browser within telescope |
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
| `,f` | File browser (telescope) |
| `,t` | Find files |
| `,a` | Live grep |
| `,b` | Buffers |
| `,r` | Tags |
| `,q` | Quit window |
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
