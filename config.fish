#vim:filetype=conf

alias v nvim
alias l ls
alias t tmux
alias o open
alias g git
alias b 'build'
alias ga 'git add -A'
alias gp 'git push -u origin master'
alias gc 'git commit'
alias gd 'git diff'
alias gs 'git show'
alias gch 'git checkout'
alias gsb 'git show-branch'
alias gpl 'git pull'
alias gcl 'git clone'
alias ta 'tmux attach'
alias tl 'tmus list-sessions'
alias td 'tmux detach'
alias ec 'nvim ~/dotfile'
alias ef 'nvim ~/.config/fish/config.fish'
alias et 'nvim ~/.tmux.conf'
alias ev 'nvim ~/.config/nvim/init.vim'

set fish_greeting ''
set -U EDITOR nvim

. ~/.config/fish/secret.fish

if tmux list-sessions | grep attached >&-
	clear
else if tmux list-sessions >&-
	tmux attach
else
	tmux
end

function a
    if file $argv | grep directory >/dev/null
        cd $argv
    else
        v $argv
    end
end

function build
  switch $argv
    case *.c or *.cpp or *.cc
      gcc $argv
    case *.rb
      ruby $argv
    case *.pl
      perl $perl
    case *.php
      php $argv
    case *.py
      python $argv
    case *.sh
      sh $argc
    case *.swift
      swift $argv
    case *.java
      javac $argv
    case *.tex
      platex $argv
      dvipdfmx (basename $argv .tex)
      rm -f (basename $argv .tex).log (basename $argv .tex).aux (basename $argv .tex).dvi
    case '*'
      echo 'unknown filetype'
  end
end
