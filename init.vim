"自分で設定した分
set number title ruler showmatch smartindent ignorecase smartcase wrapscan expandtab list
set foldmethod=syntax
set tabstop=2
set shiftwidth=4
set display=lastline
set pumheight=4
set matchtime=1
colorscheme delek
filetype plugin indent on
"ここまで

"deinとswiftの設定(コピペ)
let s:dein_dir = expand('/Users/yuma/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &compatible
  set nocompatible
endif

if !isdirectory(s:dein_repo_dir)
  execute '!git clone git@github.com:Shougo/dein.vim.git' s:dein_repo_dir
endif

execute 'set runtimepath^=' . s:dein_repo_dir

call dein#begin(s:dein_dir)
call dein#add('Shougo/dein.vim')
call dein#add('Shougo/deoplete.nvim')
call dein#add('scrooloose/syntastic')
call dein#add('landaire/deoplete-swift')
call dein#add('kballard/vim-swift')
call dein#add('keith/swift.vim')
call dein#end()
if dein#check_install()
  call dein#install()
endif

let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#swift#daemon_autostart = 1
"ここまで
syntax enable
