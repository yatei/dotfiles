#vim:filetype=conf

alias v 'nvim'
alias l 'ls -F'
alias o 'open'
alias g 'git'
alias b 'build'
alias e 'extract'
alias ga 'git add -A'
alias gp 'git push'
alias gc 'git commit'
alias gd 'git diff'
alias gs 'git show'
alias gb 'git branch'
alias gch 'git checkout'
alias gsb 'git show-branch'
alias gpl 'git pull'
alias gcl 'git clone'
alias tm 'tmux'
alias ta 'tmux attach'
alias tl 'tmux list-sessions'
alias td 'tmux detach'
alias tk 'tmux kill-server'
alias ec 'nvim ~/dotfiles'
alias ef 'nvim ~/.config/fish/config.fish'
alias et 'nvim ~/.tmux.conf'
alias ev 'nvim ~/.config/nvim/init.vim'
alias lr 'ls -R'
alias 目grep 'less'
alias today "date +'%y%m%d'"
alias tailf "tail -f"
alias lf "find (pwd)"

set fish_greeting ''
set -U EDITOR nvim

set GOPATH $HOME/app/go/third-party $HOME/app/go/projects
set PATH $PATH $HOME/app/bin $HOME/dotfiles $HOME/app/go/third-party/bin /opt/local/bin

export LSCOLORS=xbfxcxdxbxegedabagacad
set PATH $PATH ~/app/bin ~/dotfiles

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
  gp origin $argv
end

function gcv
  g++ -I/usr/local/Cellar/opencv/2.4.13.2/include/opencv -I/usr/local/Cellar/opencv/2.4.13.2/include -L/usr/local/Cellar/opencv/2.4.13.2/lib -lopencv_calib3d -lopencv_contrib -lopencv_core -lopencv_features2d -lopencv_flann -lopencv_gpu -lopencv_highgui -lopencv_imgproc -lopencv_legacy -lopencv_ml -lopencv_nonfree -lopencv_objdetect -lopencv_ocl -lopencv_photo -lopencv_stitching -lopencv_superres -lopencv_ts -lopencv_video -lopencv_videostab $argv
end

function build
  switch $argv
    case *.c
      gcc $argv -o (basename $argv .c)
    case *.cc
      g++ $argv
    case *.rb
      ruby $argv
    case *.pl
      perl $argv
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
    case *.go
      go run $argv
    case *.tex
      platex $argv
      platex $argv
      dvipdfmx (basename $argv .tex)
      rm -f (basename $argv .tex).log (basename $argv .tex).aux (basename $argv .tex).dvi
    case *.md
      pandoc $argv > (basename $argv .md).html
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

function cd
  if test (count $argv) -eq 0
    return 0
  else if test (count $argv) -gt 1
    printf "%s\n" (_ "Too many args for cd command")
    return 1
  end
  # Avoid set completions.
  set -l previous $PWD

  if test "$argv" = "-"
    if test "$__fish_cd_direction" = "next"
      nextd
    else
      prevd
    end
    return $status
  end
  builtin cd $argv
  set -l cd_status $status
  # Log history
  if test $cd_status -eq 0 -a "$PWD" != "$previous"
    set -q dirprev[$MAX_DIR_HIST]
    and set -e dirprev[1]
    set -g dirprev $dirprev $previous
    set -e dirnext
    set -g __fish_cd_direction prev
  end

  if test $cd_status -ne 0
    return 1
  end
  ls -F
  return $status
end

function tst
  /usr/local/bin/t stream timeline>$HOME/dotfiles/tweet&
end

function extract #作れ
  switch $argv
    case *.zip
    case *.gzip
    case *.tar.gz
    case *.tar.bz2
    case *.7z
    case *.rar
    case *.tar.z
    case *
  end
end

function gauto
	ga
	gc -m "auto commit"
	gp origin $argv
end

function gcv
	g++ -I/usr/local/Cellar/opencv/2.4.13.2/include/opencv -I/usr/local/Cellar/opencv/2.4.13.2/include -L/usr/local/Cellar/opencv/2.4.13.2/lib -lopencv_calib3d -lopencv_contrib -lopencv_core -lopencv_features2d -lopencv_flann -lopencv_gpu -lopencv_highgui -lopencv_imgproc -lopencv_legacy -lopencv_ml -lopencv_nonfree -lopencv_objdetect -lopencv_ocl -lopencv_photo -lopencv_stitching -lopencv_superres -lopencv_ts -lopencv_video -lopencv_videostab $argv
end

function build
	switch $argv
		case *.c
			gcc $argv -o (basename $argv .c)
		case *.cc
			g++ $argv
		case *.rb
			ruby $argv
		case *.pl
			perl $argv
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
		case *.go
			go run $argv
		case *.tex
			platex $argv
			platex $argv
			dvipdfmx (basename $argv .tex)
			rm -f (basename $argv .tex).log (basename $argv .tex).aux (basename $argv .tex).dvi
		case *.md
			pandoc $argv > (basename $argv .md).html
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

	printf '%s@%s:%s%s%s%s\n#' $USER $__fish_prompt_hostname "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" $__git_cb

	case '*'

	if not set -q __fish_prompt_cwd
		set -g __fish_prompt_cwd (set_color $fish_color_cwd)
	end

	printf '%s@%s:%s%s%s%s\n$' $USER $__fish_prompt_hostname "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" $__git_cb

	end
end

function cd
	if test (count $argv) -eq 0
		return 0
	else if test (count $argv) -gt 1
		printf "%s\n" (_ "Too many args for cd command")
		return 1
	end
	# Avoid set completions.
	set -l previous $PWD

	if test "$argv" = "-"
		if test "$__fish_cd_direction" = "next"
			nextd
		else
			prevd
		end
		return $status
	end
	builtin cd $argv
	set -l cd_status $status
	# Log history
	if test $cd_status -eq 0 -a "$PWD" != "$previous"
		set -q dirprev[$MAX_DIR_HIST]
		and set -e dirprev[1]
		set -g dirprev $dirprev $previous
		set -e dirnext
		set -g __fish_cd_direction prev
	end

	if test $cd_status -ne 0
		return 1
	end
	ls -1
	return $status
end

function tst
	/usr/local/bin/t stream timeline>$HOME/dotfiles/tweet&
end

function extract #作れ
	switch $argv
		case *.zip
		case *.gzip
		case *.tar.gz
		case *.tar.bz2
		case *.7z
		case *.rar
		case *.tar.z
		case *
	end
end

function ucase
  echo $argv|tr [a-z] [A-Z]
end

function lcase
  echo $argv|tr [A-Z] [a-z]
end

function ascii
  echo -n $argv|od -tu1 -An|tr -d ' \n'
end
