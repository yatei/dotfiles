#!/usr/local/bin/fish

#tmux
if ls ~/.tmux.conf
	rm ~/.tmux.conf
end
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
if [ $status -eq 1 ];echo 1;end;exit


#.config/ dir check
if ls ~/.config
else
	mkdir ~/.config
end
if [ $status -eq 1 ];false;end;exit


#fish
if ls ~/.config/fish
	if ls ~/.config/fish/config.fish
		rm ~/.config/fish/config.fish
	end
else
	mkdir ~/.config/fish
end
ln -s ~/dotfiles/config.fish ~/.config/fish/
if [ $status -eq 1 ];false;end;exit


#nvim
if ls ~/.config/nvim
	if ls ~/.config/nvim/init.vim
		rm ~/.config/nvim/init.vim
	end
else
	mkdir ~/.config/nvim
end
ln -s ~/dotfiles/init.vim ~/.config/nvim/
if [ $status -eq 1 ];false;end;exit
