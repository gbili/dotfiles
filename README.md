# Setting up a nix coding environement

## Quick Steps without all the crap

1. You need to git clone this repo to dotfiles:

   ```bash
   cd
   git clone https://github.com/gbili/dotfiles.git
   ```

2. Create the symbolic links to the actual dot files (we also backup preexisting):

   ```bash
   cd
   mv ~/.bashrc ~/.bashrc.back
   ln -s ~/dotfiles/.bashrc ~/.bashrc
   mv ~/.vimrc ~/.vimrc.back
   ln -s ~/dotfiles/.vimrc ~/.vimrc
   ```

3. Install vundle

   ```bash
   cd
   git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
   vim
   # within vim do
   :PluginInstall
   :q
   ```

4. Create an ssh key pair and add the public to github. Accept the default location:

  ```
  ssh-keygen -t rsa
  more ~/.ssh/id_rsa.pub
  # copy the output and add it to github
  ```

## #1!!`*nix` bash: Ctrl-S
When using bash there is a functionality that allows you to send a process to sleep with `c-s` (Ctr+S). This will freeze the terminal when editing a file using vim and typing `c-s`.

To overcome this problem, you need to disable this functionality you need to set `stty -ixon` in your `~/.bash_profile` / `~/.bashrc` / `~/.profile`.
### Troubleshootnig
In ubuntu I put it in `.bashrc` which is included in non login shells, but in ubuntu it also gets included in login shells. In a login shell you cannot call `stty` that is why you have to test whether `.bashrc` is getting included in a login shell and avoid running the command above if it is the case. Have a look at `.bashrc` to see how.

### Where to store my bash script stuff? (`.bashrc`, `.profile`, `.bash_profile`)?
Read [this][diff-bashrc-profile] if you are really interested in the matter, otherwise `~/.bashrc`is loaded for non-login shells. Which is what we want.

## Ubuntu 18.04
### Remap `Caps Lock` to `Ctrl`
- Install gnome-tweaks
  `sudo apt-get install gnome-tweaks`
- Go to Tweaks GUI App and in **Keyboard & Mouse** press the **Additional Layout Options**
- Done

## Npm
Node package manager is used for everything related somehow to javascript
You need to install it with ubuntu and then use that to install the latest version as global. See steps below.
`sudo apt install npm`
### npm install -g ERROR EACCES
If you get an error EACCES it means you are having permission troubles. This is because by default Ubuntu's npm is installed in `/usr` and it needs sudo permission to write to the global modules dir under `/usr`. **You shoud _NEVER_ run npm as sudo**, instead you can change where npm thinks _global_ is.
### Give it a local global.
Change npm's default directory to a hidden directory in your home folder
```
mkdir ~/.npm_modules_global
npm config set prefix '~/.npm_modules_global'
export PATH="$HOME/.npm_modules_global/bin:$PATH"
source ~/.bashrc
```
Once have told npm to consider your home directory as the global modules dir, you can start using it by installing non other than the latest version of npm itself!
```
npm install -g npm
npm --version
```
this has the merit of installing the latest version of npm globally.
From now on, we can safely use npm to install global modules **without giving npm any sudo rights**. You can read more in [here][mich-wanyoike-peter-dierx]

### To many errors, cut the chaos
If everything keeps failing try using `npx <npm-module commands>`. For example you can run *gatsby* with : `npx gatsby develop` this will fetch the right modules required to run gatsby.

## Vim

### Can Install Vim-nox (ruby support for command-t)
This is needed if you use command-t.
> But command-t is a real pain to install, so maybe just use ctrlp.vim and normal vim install

### Use CtrlP instead of Command-t
Works directly out of the box. You can then change CtrlP binding to <leader>t
`map <leader>t :CtrlP .<cs>`

### Use a few plugins for Javascript and react
### Download eslint and babel
`npm install -g eslint` to install it globally, and make it accessible to ale vim

### Install a few javascript plugins to allow ale to beautify your code
Using npm instead of yarn, do this **in your project's dir**
`yarn add --dev eslint babel-eslint eslint-plugin-react`
then do
`eslint --init`
Then install the following to prettify:
`yarn add --dev prettier eslint-config-prettier eslint-plugin-prettier`
Now if you run: `eslint --fix src/App.js`, your src/App.js will be beautified
This can be used in conjuction with vim plugin, Plug 'skywind300/asyncrun.vim'

## Installing drivers for graphics card
If you installed them manually, undo that with [this answer.][fixing-manually-installed-nvidia-drivers]
```
sudo apt-add-repository -r ppa:graphics-drivers/ppa
sudo apt update
sudo apt remove nvidia*
sudo apt autoremove
```
Use Ubuntu's drivers repository and drivers manager to auto install the things for you.
```
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt update
sudo ubuntu-dirvers autoinstall
```

## Programming CUDA cores
Use use [this answer][installing-cuda-compiler] to install the nvidia cuda compiler.
After having followed the instructions above for installing graphics drivers, run these commands:
```
sudo apt install nvidia-cuda-toolkit gcc-6
nvcc --version
```
This should greet you with something different than : `Command nvcc not found`

## [Headphone Audio HeadSets Bluetooth][headphone-bluetooth]
1. If you have paired your device and it does not show up as a sound device, you will first need to **unpair it**.
2. Once you are sure it is unpaired, you want to restart pulseaudio:
   ```bash
   sudo pkill pulseaudio
   ```
   This will make sure that once you connect your device via bluetooth, it will be listed as a sound device.
3. Now, to connect a bluetooth device, make sure it is discoverable, and then go to bluetooth and double click on the listed item to pari it. It should say: Connected.
4. Then you can go to Settings > Sound and select your headseat from the list.
   - If the headset is already selected and you have no sound, select another output and reselect it again.
   - It can happen that the *sound test* works but no sound comes out from youtube videos, the step of unselecting and reselecting should fix this.

## Configuring git to not ask you for user pass every time
There are plenty of wrong answers in stack overflow. The way to go is to use ssh keys. Follow the steps in [github][github-ssh-key]. 
1. Perform the steps outlined in the link above and
2. Enter a passphrase which must be unrelated to any other password, just a plain new passphrase. 
3. Then you can use the `ssh-agent` to securely save the passphrase so that you don't need to reenter it again, use [this link to see how][gh-passphrases].
4. Then you will need to save the [ssh keys to your github account][saving-ssh-key-to-github].

### Possible Error
If you see this message when you try to push to origin
```
> The authenticity of host 'github.com (IP ADDRESS)' can't be established.
  > RSA key fingerprint is 16:27:ac:a5:76:28:2d:36:63:1b:56:4d:eb:df:a6:48.
  > Are you sure you want to continue connecting (yes/no)?
```
To solve this, 
1. type: `yes` 
2. and ubuntu will ask you for sudo password
3. and the passphrase that you provided when creating the ssh key
4. Provide both and try to push again
5. You should be greeted with: Warning key was permanently added to your trusted hosts or something in those lines...  


[diff-bashrc-profile]:https://askubuntu.com/questions/121413/understanding-bashrc-and-bash-profile "Difference between .bashrc .profile etc."
[installing-cuda-compiler]:https://askubuntu.com/questions/1028830/how-do-i-install-cuda-on-ubuntu-18-04#answer-1036265 "Installing cuda compiler for programming cuda cores"
[fixing-manually-installed-nvidia-drivers]:https://askubuntu.com/questions/1077493/unable-to-install-nvidia-drivers-on-ubuntu-18-04 "fixing manually installed nvidia drivers"
[headphone-bluetooth]:https://askubuntu.com/questions/824404/bluetooth-speaker-connected-but-not-listed-in-sound-output "Best answer ever! No need to install anything"
[github-ssh-key]:https://help.github.com/en/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent "Generating ssh keys"
[gh-passphrases]:https://help.github.com/en/articles/working-with-ssh-key-passphrases "Saving passphrases to avoid entering them again"
[saving-ssh-key-to-github]:https://help.github.com/en/articles/adding-a-new-ssh-key-to-your-github-account "saving ssh key to github account"
[mich-wanyoike-peter-dierx]:https://www.sitepoint.com/beginners-guide-node-package-manager/ "Npm basics - install and more"
