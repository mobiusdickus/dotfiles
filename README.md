# dotfiles

My personal config files for various tools and applications.

In order to centralize and have everything version controlled from this project, I am using [GNU stow](https://www.gnu.org/software/stow/), a symlink farm manager.

- **05/03/23: macOS on silicone**

## Dependencies

macOS
```bash
$ brew install stow
```

Ubuntu
```
$ sudo apt-get install stow
```

## Usage

```bash
$ git clone https://github.com/mobiusdickus/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles
$ stow bash -t ~/ 
$ stow nvim -t ~/.config/nvim/
```

It might be useful to separate work related bash configs in a `~/.work` file and load that from your `~/.bash_profile` for cleaner configs and environment.
