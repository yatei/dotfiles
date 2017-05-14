set number title ruler showmatch smartindent ignorecase smartcase wrapscan expandtab list
set foldmethod=syntax
set tabstop=2
set shiftwidth=4
set display=lastline
set pumheight=4
set matchtime=1
colorscheme delek
filetype plugin indent on
noremap ; :
cnoremap Q q
noremap z zR
noremap Z zC

"カーソル位置復元
if has("autocmd")
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif

syntax enable
