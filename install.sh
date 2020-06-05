#!/bin/bash

GITDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
mkdir -p ~/.vim/colors/
mkdir -p ~/.bash

cp ${GITDIR}/gitconfig ~/.gitconfig
cp ${GITDIR}/tmux.conf ~/tmux.conf
cp ${GITDIR}/vimrc ~/.vimrc
cp ${GITDIR}/solarized.vim ~/.vim/colors/solarized.vim
cp ${GITDIR}/bash_profile ~/.my_bash_profile # avoid clobbering any other bash settings

if ! grep -q "my_bash_profile" ~/.bashrc
then
    echo "source ~/.my_bash_profile" >> ~/.bashrc
fi

if [[ ! -d ~/.bash/git-aware-prompt ]]
then
    cd ~/.bash
    git clone git://github.com/jimeh/git-aware-prompt.git
fi

read -p "GitHub Display Name: " gh_name
read -p "GitHub Email: " gh_email
read -p "Github username: " gh_user

git config --global user.name "$gh_name"
git config --global user.email "$gh_email"
git config --global user.username "$gh_user"

cp roccurl /usr/local/bin/.
