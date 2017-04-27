#vim:filetype=conf

alias v nvim
alias l ls
alias o open
alias g git
alias b 'build'
alias ga 'git add -A'
alias gp 'git push'
alias gc 'git commit'
alias gd 'git diff'
alias gs 'git show'
alias gch 'git checkout'
alias gsb 'git show-branch'
alias gpl 'git pull'
alias gcl 'git clone'
alias ta 'tmux attach'
alias tl 'tmux list-sessions'
alias td 'tmux detach'
alias tk 'tmux kill-server'
alias ec 'nvim ~/dotfiles'
alias ef 'nvim ~/.config/fish/config.fish'
alias et 'nvim ~/.tmux.conf'
alias ev 'nvim ~/.config/nvim/init.vim'
alias lr 'ls -R'

set fish_greeting ''
set -U EDITOR nvim

set PATH $PATH ~/app/bin

. ~/.config/fish/secret.fish

if tmux list-sessions | grep attached >&-
    clear
else if tmux list-sessions >&-
    tmux attach
else
    tmux
end

function gauto
    ga
    gc -m "auto commit"
    gp
end

function gcv
        g++ -I/usr/local/Cellar/opencv/2.4.13.2/include/opencv -I/usr/local/Cellar/opencv/2.4.13.2/include -L/usr/local/Cellar/opencv/2.4.13.2/lib -lopencv_calib3d -lopencv_contrib -lopencv_core -lopencv_features2d -lopencv_flann -lopencv_gpu -lopencv_highgui -lopencv_imgproc -lopencv_legacy -lopencv_ml -lopencv_nonfree -lopencv_objdetect -lopencv_ocl -lopencv_photo -lopencv_stitching -lopencv_superres -lopencv_ts -lopencv_video -lopencv_videostab $argv
end

function build
    switch $argv
        case *.c
            gcc $argv
        case *.cc
            g++ $argv
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
        case *.exs
            elixir $argv
        case '*'
            echo 'unknown filetype'
    end
end

function fish_prompt --description 'Write out the prompt'
    # Just calculate these once, to save a few cycles when displaying the prompt
    if not set -q __fish_prompt_hostname
    set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
    end

    if not set -q __fish_prompt_normal
    set -g __fish_prompt_normal (set_color normal)
    end

    if not set -q __git_cb
    set __git_cb ":"(set_color brown)(git branch ^/dev/null | grep \* | sed 's/* //')(set_color normal)""
    end

    switch $USER

    case root

    if not set -q __fish_prompt_cwd
        if set -q fish_color_cwd_root
            set -g __fish_prompt_cwd (set_color $fish_color_cwd_root)
        else
            set -g __fish_prompt_cwd (set_color $fish_color_cwd)
        end
    end

    printf '%s@%s:%s%s%s%s# ' $USER $__fish_prompt_hostname "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" $__git_cb

    case '*'

    if not set -q __fish_prompt_cwd
        set -g __fish_prompt_cwd (set_color $fish_color_cwd)
    end

    printf '%s@%s:%s%s%s%s$ ' $USER $__fish_prompt_hostname "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" $__git_cb

    end
end
