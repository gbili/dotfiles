#!/bin/sh

echo -e "Launching Step 0 \n";

$HOME/dotfiles/scripts/ubuntu-recreate/install-docker.sh

echo -e "Launching Step 1 \n";

$HOME/dotfiles/scripts/ubuntu-recreate/launch-nginx-proxy.sh

echo -e "Launching Step 2 \n";

$HOME/dotfiles/scripts/ubuntu-recreate/install-vim-vundle.sh

echo -e "Launching Step 3 \n";

$HOME/dotfiles/scripts/ubuntu-recreate/perpare-cwa.sh

echo -e "Launching Step 4 \n";

$HOME/dotfiles/scripts/ubuntu-recreate/install-docker-registry.sh
