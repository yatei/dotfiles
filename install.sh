#!/bin/sh

# check home brew
if [ $(brew --version 2>/dev/null; echo $?) -ne 0 ]; then
    echo "not found \"brew\" command. installing..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    echo "done"
fi

# check .config/ dir
if [ ! -e $HOME/.config ]; then mkdir $HOME/.config; fi

# check fish
if [ $(fish --version 2>/dev/null; echo $?) -ne 0 ]; then
    echo "not found \"fish\" command. installing..."
    mkdir $HOME/.config/fish
    brew install fish
    echo "done"
fi
ln -s $HOME/dotfiles/config.fish $HOME/.config/fish/config.fish

# check neovim
if [ $(nvim --version 2>/dev/null; echo $?) -ne 0 ]; then
    echo "not found \"neovim\" command. installing..."
    mkdir $HOME/.config/nvim/
    brew install neovim
    echo "done"
fi
ln -s $HOME/dotfiles/init.vim $HOME/.config/nvim/init.vim

# check tmux
if [ $(tmux -V 2>/dev/null; echo $?) -ne 0 ]; then
    echo "not found \"tmux\" command. installing..."
    brew install tmux
    echo "done"
fi
ln -s $HOME/dotfiles/tmux.conf $HOME/.tmux.conf

