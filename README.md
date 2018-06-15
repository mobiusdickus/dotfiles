# dotfiles

My personal custom configuration files.
The goal is to make transporting my setup across platforms as smoothly and easily as possible. 

## General Management

I am currently managing my all of my dotfiles with [GNU stow](https://www.gnu.org/software/stow/),
a symlink farm manager, and work locally with mac os x machine and remotely with ubuntu 16.04 machine.

Mac OS X
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
$ stow bash vim git # some dir name containing config files
```

### To Do

A script is in the works in order to help install all appropriate software needed in order to have these configs up and modifiable for both of my working platforms.
