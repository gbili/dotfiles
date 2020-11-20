#!/bin/sh

currdir="$(dirname "$(readlink -f "$0")")"
dotfilesdir="$(dirname "$currdir")"


echo "Current dir: $currdir"
echo "dotfiles dir: $dotfilesdir"

testfilname=".bash_aliases"
testfil="$HOME/$testfilname"
if [ -e $testfil -o -h $testfil ]; then
    mv "$testfil" "$testfil.back"
fi
ln -s "$dotfilesdir/$testfilname" $testfil 

testfilname=".bashrc"
testfil="$HOME/$testfilname"
if [ -e $testfil -o -h $testfil ]; then
    mv "$testfil" "$testfil.back"
fi
ln -s "$dotfilesdir/$testfilname" $testfil 

testfilname=".vimrc"
testfil="$HOME/$testfilname"
if [ -e $testfil -o -h $testfil ]; then
    mv "$testfil" "$testfil.back"
fi
ln -s "$dotfilesdir/$testfilname" $testfil 

# source bash aliases to enable the scripts
# without requiring full path spec
. $HOME/.bash_profile
. $HOME/.bashrc
