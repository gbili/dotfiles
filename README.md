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

### Install Vim-nox (ruby support for command-t)
This is needed if you use command-t. But command-t is a real pain to install, so maybe just use ctrlp.vim and normal vim install

## Vim
### Use CtrlP instead of Command-t
Works directly out of the box. You can then change CtrlP binding to <leader>t
`map <leader>t :CtrlP .<cs>`

### Use a few plugins for Javascript and react
### Download npm for eslint, babel
`sudo apt install npm`
`npm install -g esling` to install it globally, and make it accessible to ale vim
### npm install -g ERROR EACCES
If you get an error EACCES it means you are having permission troubles.
**you shoud never run npm as sudo**, instead you can change where npm thinks global is.
Give it a local global.
Option 1: Change npm's default directory to a hidden directory in your home folder
```
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
export PATH=~/.npm-global/bin:$PATH
source ~/.profile
```
### Install a few javascript plugins to allow ale to beautify your code
Using npm instead of yarn, do this **in your project's dir**
`yarn add --dev eslint babel-eslint eslint-plugin-react`
then do
`eslint --init`
Then install the following to prettify:
`yarn add --dev prettier eslint-config-prettier eslint-plugin-prettier`
Now if you run: `eslint --fix src/App.js`, your src/App.js will be beautified
This can be used in conjuction with vim plugin, Plug 'skywind300/asyncrun.vim'


[diff-bashrc-profile]:https://askubuntu.com/questions/121413/understanding-bashrc-and-bash-profile "Difference between .bashrc .profile etc."
