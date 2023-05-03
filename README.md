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
$ stow bash vim git # some .dotfiles dir name containing config files
```

To symlink to directories other than your home directory use the -t flag

```bash
$ stow nvim -t ~/.config/nvim/ # example
```

Separate work related bash configs for more manageable profile
```bash
$ mkdir ~/.work
```
