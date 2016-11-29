alias v vim
alias l ls
set fish_greeting ""

if tmux list-sessions | grep attached
	clear
else if tmux list-sessions
	tmux attach
else
	tmux
end
