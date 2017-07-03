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
set number
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
" Plug 'junegunn/seoul256.vim'
Plug 'morhetz/gruvbox'

" *---Language Support---*
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'nsf/gocode', { 'for': 'go', 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }
Plug 'cespare/vim-toml'
Plug 'plasticboy/vim-markdown'

" *---Editor Support---*
" Plug 'Valloric/YouCompleteMe', { 'for': ['c', 'cpp', 'go', 'rust', 'python'] }
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/cscope.vim'

Plug 'scrooloose/syntastic'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" *---Productivity---*
Plug 'Shougo/neocomplete.vim'
Plug 'scrooloose/nerdtree' ", { 'on':  'NERDTreeToggle' }
Plug 'jistr/vim-nerdtree-tabs' ", { 'on': 'NERDTreeTabsToggle' }
Plug 'easymotion/vim-easymotion'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'kien/ctrlp.vim'
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'Townk/vim-autoclose'

call plug#end()

" Theme
set background=dark
" let g:seoul256_background = 234
" colo seoul256
colo gruvbox

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
let g:ycm_rust_src_path = '/Users/phynalle/.rustup/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src'
" let g:rustfmt_autosave = 1

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

" Default fzf layout
" - down / up / left / right
" let g:fzf_layout = { 'right': '~40%' }

let g:syntastic_cpp_compiler_options = '--std=c++1y'

nmap <leader>T :enew<cr>
nmap <C-L> :bnext<CR>
nmap <C-H> :bprevious<CR>
nmap <leader>bw :bw<CR>
nmap <leader>bq :bd<CR>
nmap <leader>bl :ls<CR>

" *--- Setting for neocomplete ---*
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
