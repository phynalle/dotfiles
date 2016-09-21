syntax on
filetype on

set cindent
set autoindent
set smartindent
set sts=2 sw=2
set expandtab
set nu
set scrolloff=15
set backspace=indent,eol,start

au FileType python,rust setl sw=4 sts=4
au FileType go setl sw=4 ts=4 sts=0 noexpandtab

" if !isdirectory(@%)
"  au VimEnter * nested :TagbarToggle
"  au VimEnter * nested :NERDTreeTabsToggle
"  au VimEnter * wincmd p 
" endif

" Plugins Start
call plug#begin('~/.vim/plugged')
" Vim UI
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/seoul256.vim'
" Language Support
Plug 'rust-lang/rust.vim'
Plug 'Valloric/YouCompleteMe', { 'for': ['c', 'cpp', 'go', 'rust'] }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'nsf/gocode', { 'for': 'go' } 
Plug 'majutsushi/tagbar'
Plug 'scrooloose/syntastic'
Plug 'cespare/vim-toml'
Plug 'plasticboy/vim-markdown'
Plug 'racer-rust/vim-racer'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Utils
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'scrooloose/nerdtree' ", { 'on':  'NERDTreeToggle' }
Plug 'jistr/vim-nerdtree-tabs' ", { 'on': 'NERDTreeTabsToggle' }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'easymotion/vim-easymotion'
call plug#end()
let g:UltiSnipsEditSplit="vertical"



let g:ycm_global_ycm_extra_conf = '.vim/.ycm_extra_conf.py'

set background=light
let g:seoul256_background = 234
colo seoul256

let g:nerdtree_tabs_open_on_console_startup=1


" Key bindings
map <Leader>n <plug>NERDTreeTabsToggle<CR>
map <C-P> :FZF<CR>
nmap <F8> :TagbarToggle<CR>
imap jj <esc>

" let NERDTreeMapOpenInTab='<ENTER>'

" air-line
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" gotags
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" === vim-go ===
" let g:go_fmt_fail_silently = 0
let g:go_fmt_command = "goimports"
" let g:go_autodetect_gopath = 1
" let g:go_auto_sameids = 0
" let g:go_auto_type_info = 0
" let g:go_list_type = "quickfix"

let g:go_highlight_space_tab_error = 0
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_extra_types = 0
let g:go_highlight_build_constraints = 1

" === rust ===
let g:ycm_rust_src_path = '/usr/local/Cellar/rust/src'
" let g:ycm_rust_src_path = '/Users/phynalle/Downloads/rustc-1.11.0/src'
let g:rustfmt_autosave = 1

let g:tagbar_type_rust = {
    \ 'ctagstype' : 'rust',
    \ 'kinds' : [
        \'T:types,type definitions',
        \'f:functions,function definitions',
        \'g:enum,enumeration names',
        \'s:structure names',
        \'m:modules,module names',
        \'c:consts,static constants',
        \'t:traits,traits',
        \'i:impls,trait implementations',
    \]
\}

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
"
" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"


