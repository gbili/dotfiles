#!/bin/sh

MYIP="$(${HOME}/dotfiles/scripts/whereami.sh)";

if [ "$MYIP" = '199.241.137.4' ]; then
  export SERVER_URL_NS='ssdnodes.'
  export PRIV_REG_HOST="${SERVER_URL_NS}zivili.ch"
else
  export SERVER_URL_NS=''
  export PRIV_REG_HOST="docker.zivili.ch"
fi

echo $PRIV_REG_HOST
