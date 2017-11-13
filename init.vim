set number title ruler showmatch smartindent ignorecase smartcase wrapscan list cursorline expandtab
set listchars=trail:-,nbsp:%,eol:⏎
set foldmethod=syntax
set tabstop=2
set shiftwidth=2
set display=lastline
set pumheight=4
set matchtime=1
colorscheme darkblue
filetype plugin indent on
noremap ; :
noremap z zR
noremap Z zC
noremap U <C-r>
nnoremap Y y$
nnoremap c <C-->

"カーソル位置復元
if has("autocmd")
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif

"quickrun用
"set splitbelow

"deinの設定
let g:python3_host_prog = '/usr/local/bin/python3'
let s:dein_dir = expand('~/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
"let g:deoplete#enable_at_startup = 1
"let g:deoplete#sources#swift#daemon_autostart = 1

if &compatible
  set nocompatible
endif

if !isdirectory(s:dein_repo_dir)
  execute '!git clone git@github.com:Shougo/dein.vim.git' s:dein_repo_dir
endif

execute 'set runtimepath^=' . s:dein_repo_dir

"プラグイン
call dein#begin(s:dein_dir)
call dein#add('Shougo/dein.vim')
call dein#add('Shougo/deoplete.nvim')
call dein#add('scrooloose/syntastic')
call dein#add('scrooloose/nerdtree')
call dein#add('tomtom/tcomment_vim')
call dein#add('thinca/vim-quickrun')
call dein#add('derekwyatt/vim-scala')
call dein#add('munshkr/vim-tidal')
"call dein#add('')
call dein#end()
if dein#check_install()
  call dein#install()
endif

"syntaxハイライト有効
syntax enable
