alias greprep="/bin/sh $HOME/dotfiles/scripts/greprep"
alias alias-script="/bin/sh $HOME/dotfiles/scripts/alias-script.sh"
alias link-dotfiles="/bin/sh $HOME/dotfiles/scripts/link-dotfiles.sh" # not very usefull, once linked no need to execute this

# Docker wordpress
alias cwa-init="/bin/sh $HOME/dotfiles/scripts/create-wordpress-app/cwa-init.sh"
alias cwa-dup="/bin/sh $HOME/dotfiles/scripts/create-wordpress-app/cwa-dup.sh"
alias cwa-dup-post="/bin/sh $HOME/dotfiles/scripts/create-wordpress-app/cwa-dup-post.sh"
alias cwa-clean="/bin/sh $HOME/dotfiles/scripts/create-wordpress-app/cwa-clean.sh"

# Docker registry
alias docker-registry-install="/bin/sh $HOME/dotfiles/scripts/docker-registry/install.sh"
# Docker or git-server-hooks related scripts
alias docker-build-push="/bin/sh $HOME/dotfiles/scripts/docker-build-push.sh"
alias docker-copy-to-volume="/bin/sh $HOME/dotfiles/scripts/docker-copy-file-to-volume.sh"
alias docker-copy-file-to-approot="/bin/sh $HOME/dotfiles/scripts/docker-copy-file-to-approot.sh"
alias docker-flush-start="/bin/sh $HOME/dotfiles/scripts/docker-flush-start.sh"
alias docker-restart-service="/bin/sh $HOME/dotfiles/scripts/docker-restart-service.sh"
# Database backups / restore
alias docker-db-backup="/bin/sh $HOME/dotfiles/scripts/docker-db/backup.sh"
alias docker-db-restore="/bin/sh $HOME/dotfiles/scripts/docker-db/restore.sh"
# install git-server-hooks
alias git-server-hooks-install="/bin/sh $HOME/dotfiles/scripts/git-server-hooks/install.sh"
# push to git-server-hooks remote named "live" and applies docker-compose up -d on the $ws/<-d>
alias git-pushup="/bin/sh $HOME/dotfiles/scripts/git-push-remote-compose-up.sh"
# add a repo to git-server-hooks running locally
alias git-repoadd="/bin/sh $HOME/dotfiles/scripts/git-server-hooks/repo-add.sh"
# add a repo to git-server-hooks running remotely
alias git-repoaddr="/bin/sh $HOME/dotfiles/scripts/git-server-hooks/repo-add-remote.sh"
# remove a repo to git-server-hooks running locally
alias git-reporemove="/bin/sh $HOME/dotfiles/scripts/git-server-hooks/repo-remove.sh"
# remove a repo to git-server-hooks running locally
alias git-reporeset="/bin/sh $HOME/dotfiles/scripts/git-server-hooks/repo-reset.sh"

# Use the first one to setup a new Ubuntu VPS
alias ubuntu-recreate="/bin/sh $HOME/dotfiles/scripts/ubuntu-recreate/all-steps.sh"
alias ubuntu-recreate-install-docker="/bin/sh $HOME/dotfiles/scripts/ubuntu-recreate/install-docker.sh"
alias ubuntu-recreate-launch-nginx-proxy="/bin/sh $HOME/dotfiles/scripts/ubuntu-recreate/launch-nginx-proxy.sh"
alias ubuntu-recreate-install-docker-registry="/bin/sh $HOME/dotfiles/scripts/ubuntu-recreate/install-docker-registry.sh"
alias ubuntu-recreate-install-vim-vundle="/bin/sh $HOME/dotfiles/scripts/ubuntu-recreate/install-vim-vundle.sh"
alias ubuntu-recreate-prepare-cwa="/bin/sh $HOME/dotfiles/scripts/ubuntu-recreate/prepare-for-cwa.sh"

# Locally
alias cronide-startl="/bin/sh $HOME/dotfiles/scripts/cronide-start-locally.sh"

# Get the ip
alias whereami="/bin/sh $HOME/dotfiles/scripts/whereami.sh"
alias githook-host="/bin/sh $HOME/dotfiles/scripts/githook-host.sh"
alias private-registry-host="/bin/sh $HOME/dotfiles/scripts/private-registry-host.sh"
