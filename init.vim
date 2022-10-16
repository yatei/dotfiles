set number title ruler showmatch smartindent ignorecase smartcase wrapscan list cursorline expandtab wildmenu
set listchars=trail:-,nbsp:%,eol:⏎
set foldmethod=syntax
set tabstop=2
set shiftwidth=2
set display=lastline
set pumheight=4
set matchtime=1
filetype plugin indent on
noremap ; :
noremap z zR
noremap Z zC
noremap U <C-r>
nnoremap Y y$
noremap T :tabnew 
noremap t :tabnew<CR>
noremap <Tab> gt
noremap <S-Tab> gT
noremap ! :q!<CR>
noremap @ :wq<CR>
:let tmp = @@
:silent normal gvy
:let selected = @@
:let @@ = tmp
:echo selected
noremap q :%s/
noremap Q :%s/
inoremap { {}
inoremap [ []
inoremap ( ()<Left>
noremap PP "0p
noremap x "_x

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
let g:python3_host_prog = '/usr/bin/python3'
let s:dein_dir = expand('~/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#swift#daemon_autostart = 1

if &compatible
  set nocompatible
endif

if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif

execute 'set runtimepath^=' . s:dein_repo_dir

"プラグイン
call dein#begin(s:dein_dir)
call dein#add('Shougo/dein.vim')
call dein#add('Shougo/deoplete.nvim')
call dein#add('Shougo/vimshell.git')
call dein#add('scrooloose/syntastic')
call dein#add('scrooloose/nerdtree')
call dein#add('tomtom/tcomment_vim')
call dein#add('munshkr/vim-tidal')
call dein#add('junegunn/fzf')
call dein#add('c9s/helper.vim')
call dein#add('c9s/treemenu.vim')
call dein#add('tomasr/molokai')
call dein#add('sjl/badwolf')
call dein#end()
if dein#check_install()
  call dein#install()
endif

"syntaxハイライト有効
colorscheme molokai
syntax enable
hi CursorLineNr cterm=reverse
hi clear CursorLine
