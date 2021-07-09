<!-- vim-markdown-toc GFM -->

* [Git credentials storage](#git-credentials-storage)
* [git init](#git-init)
* [git status](#git-status)
* [git add -A](#git-add--a)
* [git commit -m "MESSAGE"](#git-commit--m-message)
* [git push origin main](#git-push-origin-main)
* [git pull](#git-pull)
* [git branch <new branch name>](#git-branch-new-branch-name)
* [git branch](#git-branch)
* [git checkout <existing branch name>](#git-checkout-existing-branch-name)
* [git push -u origin <branch name>](#git-push--u-origin-branch-name)
* [to merge a branch with the main](#to-merge-a-branch-with-the-main)
* [delete a branch](#delete-a-branch)
* [deleting a branch from remote repository](#deleting-a-branch-from-remote-repository)
    * [git log](#git-log)
    * [`git reset <file>`](#git-reset-file)
* [git clone <repositry URL> <path to clone>](#git-clone-repositry-url-path-to-clone)

<!-- vim-markdown-toc -->

# Git credentials storage

Run `git config --global credential.helper store` to store git credentials
globally

# git init

create a git repository in the current folder

# git status

shows the untracked files in the current directory

# git add -A

add all files to the *staging area* to get ready to be
committed
    this can also be done on a file by file basis by
    using `git add <file>`

# git commit -m "MESSAGE"

commits everything in the current staging area

# git push origin main

Push to remote repository
origin - name of repository
main - branch name

# git pull

Gets any changes from the repository to the local
machine

# git branch <new branch name>

creates a branch with that name

# git branch

list all existing branches

# git checkout <existing branch name>

switch to that branch

# git push -u origin <branch name>

pushes current commit into the branch
-u - associates the current branch to the base branch.
So in the future, we can just do **git push** and **git
pull** from this branch

# to merge a branch with the main

1. `git checkout main`

switch to main branch

2. `git merge <branch name>`

will merge the branch named with the current branch
(main)

3. `git push origin main`

push all changes to remote repository

# delete a branch

`git branch -d <branch name>`

this will only delete the branch on the local machine

# deleting a branch from remote repository

`git push origin --delete <branch name>`

## git log

Shows a history of all git commits

`git reset <file>`
--------------------------
remove file from staging area

# git clone <repositry URL> <path to clone>

will clone a git repository
