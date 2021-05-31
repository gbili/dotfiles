# Git server hooks

Relies on :

- git-server-hooks docker container
- git-server-hooks-repo-add docker container

The `HOOKS_NAMESPACE` thing determines what git post-receive hook will be copied into the created git repository. Depending on what kind of application will be hosted in the git repository, you may want different behaviors for git's `post-receive` hook.

Since repos are supposed to run on docker, you have to make sure `node` has access to your checked out repo in case your repo hosts a node app. In that case you want to use the `-n node` namespace option. Unless you are using `node-fs-perms` which does that periodically for you.
