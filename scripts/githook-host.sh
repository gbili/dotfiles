#!/bin/sh

MYIP="$(${HOME}/dotfiles/scripts/whereami.sh)";

if [ "$MYIP" = '199.241.137.4' ]; then
  export SERVER_URL_NS='ssdnodes.'
  export GITHOOKS_HOST="${SERVER_URL_NS}githook.co"
else
  export SERVER_URL_NS=''
  export GITHOOKS_HOST="${SERVER_URL_NS}githook.co"
fi

echo $GITHOOKS_HOST
