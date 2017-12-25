" --- general setting ---
syntax on
filetype plugin indent on
set hidden
set exrc
set cindent
set autoindent
set smartindent
set softtabstop=2
set shiftwidth=2
set expandtab
set relativenumber
set number
set scrolloff=15
set backspace=indent,eol,start
set hlsearch
set smartcase

au FileType python,rust setl sw=4 sts=4
au FileType go setl sw=4 ts=4 sts=0 noexpandtab

" Plugins Start
call plug#begin('~/.vim/plugged')

" Vim UI
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'nanotech/jellybeans.vim'

" *---Language Support---*
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'racer-rust/vim-racer', { 'for': 'rust' }
Plug 'sebastianmarkow/deoplete-rust', { 'for': 'rust' }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'nsf/gocode', { 'for': 'go', 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'cespare/vim-toml'
Plug 'plasticboy/vim-markdown'

" *---IDE Support---*
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/cscope.vim'
Plug 'scrooloose/syntastic'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Yggdroot/indentLine'

"   *---Productivity---*
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'scrooloose/nerdtree' ", { 'on':  'NERDTreeToggle' }
Plug 'jistr/vim-nerdtree-tabs' ", { 'on': 'NERDTreeTabsToggle' }
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'jiangmiao/auto-pairs'

if !has('nvim')
  Plug 'vim-utils/vim-alt-mappings'
endif

call plug#end()

" Theme
" set background=dark
colo jellybeans

" air-line
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" Nerdtree
" let g:nerdtree_tabs_open_on_console_startup=1
" let NERDTreeMapOpenInTab='<ENTER>'

" Key bindings
map <Leader>n <plug>NERDTreeTabsToggle<CR>
nmap <F8> :TagbarToggle<CR>
map <C-P> :FZF<CR>
imap jj <esc>

" nnoremap <C-t>     :tabnew<CR>
" inoremap <C-t>     <Esc>:tabnew<CR>
" nnoremap tt  :tabedit<Space>
" nnoremap td  :tabclose<CR>

" syntastic
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

au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <Leader>s <Plug>(go-implements)

au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)

" === rust ===
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
let g:godef_split=3
let g:godef_same_file_in_same_window=1

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:syntastic_cpp_compiler_options = '--std=c++1y'

nmap <leader>T :enew<cr>
nmap <C-L> :bnext<CR>
nmap <C-H> :bprevious<CR>
nmap <leader>bw :bw<CR>
nmap <leader>bq :bd!<CR>
nmap <leader>bl :ls<CR>
nmap <C-1> :b1<CR>
nmap <C-2> :b2<CR>
nmap <C-3> :b3<CR>
nmap <C-4> :b4<CR>
nmap <C-5> :b5<CR>

" *--- Setting for deoplete ---*
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#auto_complete_start_length = 3
let g:deoplete#max_menu_width = 80

" *--- Setting for indentLine ---*
let g:indentLine_enabled = 0
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = '·'


