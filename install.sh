#!/bin/bash

# install
# brew install tmux fish neovim
# pip3 install --upgrade pip
# pip3 install pynvim
# pip3 install neovim

# homebrew
if [ $(which brew) ]; then 
  echo "brew is already installed. skip"
else
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
brew bundle --file ./Brewfile

#tmux
if [ $(ls ~/.tmux.conf 2>/dev/null) ]; then
	rm ~/.tmux.conf
fi
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf

#fish
if [ $(ls ~/.config/fish/config.fish) ]; then
  rm ~/.config/fish/config.fish
fi
mkdir -p ~/.config/fish
ln -s ~/dotfiles/config.fish ~/.config/fish/

#nvim
if [ $(ls ~/.config/nvim/init.vim) ]; then
  rm ~/.config/nvim/init.vim
fi
mkdir ~/.config/nvim
ln -s ~/dotfiles/init.vim ~/.config/nvim/
