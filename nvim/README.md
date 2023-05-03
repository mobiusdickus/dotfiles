# Neovim

## Dependencies

- Ensure Python versions are installed correctly.
- Install [the_silver_searcher](https://github.com/ggreer/the_silver_searcher).
- Install [powerline fonts](https://github.com/powerline/fonts).
  - For iTerm2 set both the ASCII and NON-ASCII text font to use a Roboto Mono for Powerline.
- Create .config directory `mkdir ~/.config`.
- Create nvim directory `mkdir ~/.config/nvim`.
- Change directory to `~/.config/nvim`.
- Run `stow nvim`.
- Create `~/.config/nvim/swaps` and `~/.config/nvim/backups` directories.

## Set Up

After syslinking the nvim files, neovim will give you a lot of errors. Here are some key things to check.

- Run `:checkhealth` inside nvim.
  - In general just follow the check list here to get things working.
- Install the [vim-plug](https://github.com/junegunn/vim-plug).
  - Run `:PlugInstall` inside nvim.
- Install neovim for python3 and in the `init.vim` file update `let g:python3_host_prog` to the current path of the python version you are using.
- Install neovim for ruby and in the `init.vim` file update `let g:ruby_host_prog` to the current path of the ruby version you are using.
- Install neovim for Node.js.
- Run `:UpdateRemotePlugins` inside nvim. This will get rid of the deoplete warnings.