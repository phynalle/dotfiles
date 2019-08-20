" --- general setting ---
syntax on
filetype plugin indent on
set hidden
set cindent
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set nu
set rnu
set noshowmode
set autoread
set signcolumn=yes
set updatetime=150
set shortmess+=c
set timeoutlen=1000 ttimeoutlen=0

au FileType c,cpp setl sw=2 sts=2
au FileType go setl sts=0 noexpandtab
au BufEnter * EnableStripWhitespaceOnSave
au CursorHold,FocusGained,BufEnter * :checktime

if has('nvim')
  nmap <BS> <C-H>
endif

call plug#begin('~/.vim/plugged')
" UI
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/seoul256.vim'
Plug 'morhetz/gruvbox'

" Language Support
" Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'sheerun/vim-polyglot'

" IDE Support
Plug 'Yggdroot/indentLine'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sensible'
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter'
Plug 'ntpeters/vim-better-whitespace'
Plug 'liuchengxu/vista.vim'
Plug 'cohama/agit.vim'
Plug 'rbgrouleff/bclose.vim'
call plug#end()

if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif

let g:airline_theme = 'gruvbox'
let g:airline#extensions#tabline#enabled = 1

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Theme
" let g:seoul256_background = 235
set termguicolors
set background=light
colo gruvbox
let g:gruvbox_contrast = 'soft'
hi ExtraWhitespace ctermbg=1 guibg=#bf626b

" Key bindings
" nmap <F8> :Vista<CR>
map <C-P> :FZF<CR>

" Keybindings to control buffer
nmap <C-T> :enew<CR>
nmap <C-L> :bnext<CR>
nmap <C-H> :bprevious<CR>
nmap <leader>bl :ls<CR>
nmap <C-1> :b1<CR>
nmap <C-2> :b2<CR>
nmap <C-3> :b3<CR>
nmap <C-4> :b4<CR>
nmap <C-5> :b5<CR>
nmap <C-S-F> :Rg<space>

let g:strip_whitespace_on_save = 1
let g:strip_whitespace_confirm = 0

let g:gitgutter_grep='rg'
nnoremap <silent> <Leader>bD :Bclose!<CR>

" s{char}{char} to move to {char}{char}
nmap <Leader>s <Plug>(easymotion-sn)
nmap <Leader>t <Plug>(easymotion-tn)
