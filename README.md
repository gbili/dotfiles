# Setting up a nix coding environement

## #1!!`*nix` bash: Ctrl-S
When using bash there is a functionality that allows you to send a process to sleep with `c-s` (Ctr+S). This will freeze the terminal when editing a file using vim and typing `c-s`.

To overcome this problem, you need to disable this functionality you need to set `stty -ixon` in your `~/.bash_profile` / `~/.bashrc` / `~/.profile`.

### Where to store my bash script stuff?
Read [this][diff-bashrc-profile] if you are really interested in the matter, otherwise `~/.bashrc`is loaded for non-login shells. Which is what we want.

## Ubuntu 18.04
### Remap `Caps Lock` to `Ctrl`
- Install gnome-tweaks
  `sudo apt-get install gnome-tweaks`
- Go to Tweaks GUI App and in **Keyboard & Mouse** press the **Additional Layout Options**
- Done

### Install Vim-nox (ruby support)
This is needed if you use command-t. But command-t is a real pain to install, so maybe just use ctrlp.vim and normal vim install


[diff-bashrc-profile]:https://askubuntu.com/questions/121413/understanding-bashrc-and-bash-profile "Difference between .bashrc .profile etc."
