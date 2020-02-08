#!/bin/bash

mkdir -p ~/projects/config/

# Oh My ZSH
echo "Setting up ZSH..."
git clone git@github.com:/ohmyzsh/ohmyzsh ~/.oh-my-zsh
ln zshrc ~/.zshrc
ln tmux.conf ~/.tmux.conf

# Git
ln gitconfig ~/.gitconfig

# Xorg
ln xinitrc ~/.xinitrc
ln Xresources ~/.Xresources


# Input method.
git clone git@github.com:/sheepduke/rime-wubi86 ~/projects/config/rime-wubi86
ln -s ~/projects/config/rime-wubi86 ~/.config/ibus/rime
rime_deployer --build ~/.config/ibus/rime

# Emacs.
git clone git@github.com:/sheepduke/emacs-settings ~/.emacs.d
cp ~/.emacs.d/settings/.emacs ~/
