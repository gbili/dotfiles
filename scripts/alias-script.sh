#!/bin/sh

[ $# -eq 0 ] && { echo "Usage: $0 -f <filename> -n <scriptname> \nExample:\n$0 -f flush-start.sh -n flshs"; exit 1; }

while getopts f:n: flag
do
    case "${flag}" in
        f) filename=${OPTARG};;
        n) scriptname=${OPTARG};;
    esac
done

scriptfilefullpath=$HOME/dotfiles/scripts/$filename

if [ ! -f $scriptfilefullpath ]; then
  echo "No such script $scriptfilefullpath";
  exit 1;
fi

chmod +x $scriptfilefullpath;
echo alias $scriptname='"/bin/sh $HOME/dotfiles/scripts/'$filename'"' >> $HOME/.bash_aliases;
# . is bash's source equivalent in sh
. $HOME/.bash_aliases;
