function! Spellcheck ()
    setlocal spell spelllang=en_us
endfunction
com! SP call Spellcheck()


call plug#begin()
set encoding=utf-8
set number relativenumber
syntax enable
set noswapfile
set scrolloff=7
set backspace=indent,eol,start
set shiftwidth=4
set autoindent
set fileformat=unix

set nocompatible
filetype plugin on
syntax on


Plug 'catppuccin/nvim'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'SirVer/ultisnips'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'scrooloose/nerdtree' 
Plug 'vimwiki/vimwiki'
Plug 'iamcco/markdown-preview.nvim'
Plug 'pangloss/vim-javascript'

noremap m h
noremap n j
noremap e k
noremap i l
noremap k e

call plug#end()


colorscheme catppuccin
let g:airline_themes='catppuccin'

if (has("termguicolors"))
	set termguicolors
endif

lua require 'colorizer'.setup()

let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'

let NERDTreeQuitOnOpen=1
let g:NERDTreeMinimalUI=1
map <C-o> :NERDTreeToggle<CR>

let g:vimwiki_list = [{'path': '~/Documents/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
