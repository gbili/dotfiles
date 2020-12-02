#!/bin/bash

currdir="$(dirname "$(readlink -f "$0")")"
dotfilesdir="$(dirname "$currdir")"

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
if [ -f $HOME/.bash_profile ]; then
  . $HOME/.bash_profile
elif [ -f $HOME/.profile ]; then
  . $HOME/.profile
fi
. $HOME/.bashrc
