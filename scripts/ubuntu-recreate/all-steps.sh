#!/bin/sh

echo "Launching Step 0 \n";

ubuntu-recreate-install-docker

echo "Launching Step 1 \n";

ubuntu-recreate-launch-nginx-proxy

echo "Launching Step 2 \n";

ubuntu-recreate-install-vim-vundle

echo "Launching Step 3 \n";

ubuntu-recreate-perpare-cwa

echo "Launching Step 4 \n";

ubuntu-recreate-install-docker-registry
