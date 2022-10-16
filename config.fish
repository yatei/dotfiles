#vim:filetype=conf

# Alias
alias v 'nvim'
alias l 'ls -F'
alias o 'open'
alias g 'git'
alias b 'build'
alias e 'extract'
alias k 'kubectl'
alias c 'cat'
alias vd 'cd'
alias ka 'kubectl apply -f'
alias kc 'kubectl config'
alias kch 'kubecrl config use-context'
alias kg 'kubectl get'
alias kga 'kubectl get all'
alias kgp 'kubectl get pods'
alias kd 'kubectl describe'
alias ke 'kubectl exec -it'
alias stc 'stern console --all-namespaces'
alias ga 'git add -A'
alias gp 'git push'
alias gc 'git commit'
alias gd 'git diff'
alias gs 'git status'
alias gsh 'git show'
alias gb 'git branch'
alias gcb 'gb|grep "*"|tr -d " *\n"'
alias gch 'git checkout'
alias gsb 'git show-branch'
alias gpl 'git pull'
alias gcl 'git clone'
alias gl 'git log'
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
alias tf 'terraform'

# Env
set fish_greeting ''
set -U EDITOR nvim
set GOPATH $HOME/go/third-party $HOME/go/projects
set PATH $PATH $HOME/app/bin $HOME/dotfiles /opt/homebrew/bin $HOME/.goenv/bin $HOME/app/go/third-party/bin /opt/local/bin $HOME/.goenv/shims $HOME/.nodebrew/current/bin/
set LSCOLORS xbfxcxdxbxegedabagacad

# Recover tmux session
if tmux list-sessions | grep attached >&-
  clear
else if tmux list-sessions >&-
  tmux attach
else
  tmux
end

# Set prompt
function fish_prompt --description 'Write out the prompt'
  # Just calculate these once, to save a few cycles when displaying the prompt
  if not set -q __fish_prompt_hostname
    # set -g __fish_prompt_hostname (hostname -s)
    set -g __fish_prompt_hostname local
  end

  if not set -q __fish_prompt_normal
    set -g __fish_prompt_normal (set_color normal)
  end

  if not set -q __git_cb
    set __git_cb ":"(set_color yellow)(git branch 2>/dev/null | grep \* | sed 's/* //')(set_color normal)""
  end

  if not set -q __k8s_cn
    set __k8s_cn ":"(set_color red)(kubectl config current-context|tr -d '\n')(set_color normal)""
  end

  if not set -q __gcloud_cnf
    set __gcloud_cnf ":"(set_color red)(cat ~/.config/gcloud/active_config|tr -d '\n')(set_color normal)""
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

  printf '%s@%s:%s%s%s%s%s# ' $USER $__fish_prompt_hostname "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" $__git_cb $__gcloud_cnf

  case '*'

  if not set -q __fish_prompt_cwd
    set -g __fish_prompt_cwd (set_color $fish_color_cwd)
  end

  printf '%s@%s:%s%s%s%s%s$ ' $USER $__fish_prompt_hostname "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" $__git_cb $__gcloud_cnf

  end
end


# behavior "cd" command
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

function extract
  switch $argv
    case *.zip
      unzip $argv
    case *.gzip
      gunzip $argv
    case *.tar.gz
      tar zxvf $argv
    case *.tar.bz2
      tar bxvf $argv
    case *
      echo "?"
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

function iterm2_print_user_vars
  set -l git_branch (git branch 2>/dev/null | sed -n '/\* /s///p')
  iterm2_set_user_var gitBranch "$git_branch"
end

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

function weather
  curl wttr.in/~Minato-ku
end

function line
  head -n $argv|tail -n 1
end

# The next line updates PATH for the Google Cloud SDK.
if [ -f '$HOME/google-cloud-sdk/path.fish.inc' ]; . '$HOME/google-cloud-sdk/path.fish.inc'; end
