alias v nvim
alias l ls
alias ga 'git add -A'
alias gp 'git push -u origin master'
alias gc 'git commit'
set fish_greeting ""
set -U EDITOR nvim

source ~/.config/fish/secret

if tmux list-sessions | grep attached >&-
	clear
else if tmux list-sessions >&-
	tmux attach
else
	tmux
end
