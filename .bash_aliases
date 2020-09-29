alias link-dotfiles="bash $HOME/dotfiles/scripts/link-dotfiles.bash" # not very usefull, once linked no need to execute this

# Docker wordpress
alias cwa-install="bash $HOME/dotfiles/scripts/create-wordpress-app/create-wordpress-app.bash"
alias cwa-dup="bash $HOME/dotfiles/scripts/create-wordpress-app/cwa-dup.bash"
alias cwa-dup-post="bash $HOME/dotfiles/scripts/create-wordpress-app/cwa-dup-post.bash"
alias cwa-clean="bash $HOME/dotfiles/scripts/create-wordpress-app/cwa-clean.bash"
alias greprep="bash $HOME/dotfiles/scripts/greprep"
alias flush-start="sh $HOME/dotfiles/scripts/flush-start.sh"
alias alias-script="/bin/sh $HOME/dotfiles/scripts/alias-script.sh"
alias docker-build-push="/bin/sh $HOME/dotfiles/scripts/docker-build-push.sh"
alias git-pushup="/bin/sh $HOME/dotfiles/scripts/git-push-remote-compose-up.sh"
alias git-repoadd="/bin/sh $HOME/dotfiles/scripts/git-server-hooks/repo-add.sh"
alias git-repoaddr="/bin/sh $HOME/dotfiles/scripts/git-server-hooks/repo-add-remote.sh"
alias git-reporemove="/bin/sh $HOME/dotfiles/scripts/git-server-hooks/repo-remove.sh"
alias git-reporeset="/bin/sh $HOME/dotfiles/scripts/git-server-hooks/repo-reset.sh"
alias docker-restart-service="/bin/sh $HOME/dotfiles/scripts/docker-restart-service.sh"
alias docker-copy-to-volume="/bin/sh $HOME/dotfiles/scripts/docker-copy-file-to-volume.sh"
alias docker-copy-file-to-approot="/bin/sh $HOME/dotfiles/scripts/docker-copy-file-to-approot.sh"

alias ubuntu-recreate="sh $HOME/dotfiles/scripts/ubuntu-recreate/all-steps.sh"
alias ubuntu-recreate-install-docker="sh $HOME/dotfiles/scripts/ubuntu-recreate/install-docker.sh"
alias ubuntu-recreate-launch-nginx-proxy="sh $HOME/dotfiles/scripts/ubuntu-recreate/launch-nginx-proxy.sh"
alias ubuntu-recreate-install-vim-vundle="sh $HOME/dotfiles/scripts/ubuntu-recreate/install-vim-vundle.sh"
