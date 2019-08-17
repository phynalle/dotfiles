" --- general setting ---
syntax on
filetype plugin indent on
set hidden
set cindent
set smartindent
set ts=4
set sts=4
set sw=4
set expandtab
set relativenumber
set number
set hlsearch
set smartcase
" set completeopt-=preview
set completeopt=noinsert,menuone,noselect
set guicursor=
set showtabline=2
set noshowmode
set shell=/bin/zsh
set autoread
set signcolumn=yes
set updatetime=150
set shortmess+=c
set nobackup
set nowritebackup

au FileType c,cpp setl sw=2 sts=2
au FileType go setl sts=0 noexpandtab
au BufEnter * EnableStripWhitespaceOnSave
au CursorHold,FocusGained,BufEnter * :checktime

if (has("termguicolors"))
   set termguicolors
endif

" Plugins Start
call plug#begin('~/.vim/plugged')
"  *---Productivity---*
" Completion Supports

" Vim UI
Plug 'itchyny/lightline.vim'
Plug 'mgee/lightline-bufferline'
Plug 'chriskempson/base16-vim'
Plug 'junegunn/seoul256.vim'
Plug 'liuchengxu/space-vim-dark'

" *---Language Support---*
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'nsf/gocode', { 'for': 'go', 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }
Plug 'isRuslan/vim-es6'
Plug 'sheerun/vim-polyglot'
Plug 'racer-rust/vim-racer'

" *---IDE Support---*
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/cscope.vim'
Plug 'Yggdroot/indentLine'
Plug 'scrooloose/nerdtree' ", { 'on':  'NERDTreeToggle' }
Plug 'jistr/vim-nerdtree-tabs' ", { 'on': 'NERDTreeTabsToggle' }
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

if !has('nvim')
  Plug 'vim-utils/vim-alt-mappings'
endif
call plug#end()

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case --glob "!{.git/*,*.pyc}" '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" Theme
set background=dark
" colo base16-gruvbox-dark-pale
let g:seoul256_background = 235
colo seoul256
hi CursorLineNr guibg=#3F3F3F
hi ExtraWhitespace guibg=Red
" colo space-vim-dark
" hi Comment cterm=italic
" Nerdtree
" let g:nerdtree_tabs_open_on_console_startup=1
" let NERDTreeMapOpenInTab='<ENTER>'

" Key bindings
map <Leader>n <plug>NERDTreeTabsToggle<CR>
nmap <F8> :Vista<CR>
map <C-P> :FZF<CR>
imap jj <esc>

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

" Setting for Rust
" let g:rustfmt_autosave = 1

let g:autofmt_autosave = 1
let g:godef_split=3
let g:godef_same_file_in_same_window=1

" *--- Keybindings to control buffer"
nmap <leader>T :enew<CR>
nmap <C-L> :bnext<CR>
nmap <C-H> :bprevious<CR>
nmap <leader>bl :ls<CR>
nmap <C-1> :b1<CR>
nmap <C-2> :b2<CR>
nmap <C-3> :b3<CR>
nmap <C-4> :b4<CR>
nmap <C-5> :b5<CR>
nmap <C-S-F> :Rg<space>

let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'tabline': {'left': [['buffers']], 'right': [['']]},
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers',
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel',
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'gitbranch': 'fugitive#head',
      \ },
      \ 'component': {
      \   'separator': '',
      \ },
      \ }

let g:lightline#bufferline#unnamed      = '[No Name]'

let g:strip_whitespace_on_save = 1
let g:strip_whitespace_confirm = 0

let g:gitgutter_grep='rg'
" Delete buffer while keeping window layout (don't close buffer's windows).
" Version 2008-11-18 from http://vim.wikia.com/wiki/VimTip165
if v:version < 700 || exists('loaded_bclose') || &cp
  finish
endif
let loaded_bclose = 1
if !exists('bclose_multiple')
  let bclose_multiple = 1
endif

" Display an error message.
function! s:Warn(msg)
  echohl ErrorMsg
  echomsg a:msg
  echohl NONE
endfunction

" Command ':Bclose' executes ':bd' to delete buffer in current window.
" The window will show the alternate buffer (Ctrl-^) if it exists,
" or the previous buffer (:bp), or a blank buffer if no previous.
" Command ':Bclose!' is the same, but executes ':bd!' (discard changes).
" An optional argument can specify which buffer to close (name or number).
function! s:Bclose(bang, buffer)
  if empty(a:buffer)
    let btarget = bufnr('%')
  elseif a:buffer =~ '^\d\+$'
    let btarget = bufnr(str2nr(a:buffer))
  else
    let btarget = bufnr(a:buffer)
  endif
  if btarget < 0
    call s:Warn('No matching buffer for '.a:buffer)
    return
  endif
  if empty(a:bang) && getbufvar(btarget, '&modified')
    call s:Warn('No write since last change for buffer '.btarget.' (use :Bclose!)')
    return
  endif
  " Numbers of windows that view target buffer which we will delete.
  let wnums = filter(range(1, winnr('$')), 'winbufnr(v:val) == btarget')
  if !g:bclose_multiple && len(wnums) > 1
    call s:Warn('Buffer is in multiple windows (use ":let bclose_multiple=1")')
    return
  endif
  let wcurrent = winnr()
  for w in wnums
    execute w.'wincmd w'
    let prevbuf = bufnr('#')
    if prevbuf > 0 && buflisted(prevbuf) && prevbuf != btarget
      buffer #
    else
      bprevious
    endif
    if btarget == bufnr('%')
      " Numbers of listed buffers which are not the target to be deleted.
      let blisted = filter(range(1, bufnr('$')), 'buflisted(v:val) && v:val != btarget')
      " Listed, not target, and not displayed.
      let bhidden = filter(copy(blisted), 'bufwinnr(v:val) < 0')
      " Take the first buffer, if any (could be more intelligent).
      let bjump = (bhidden + blisted + [-1])[0]
      if bjump > 0
        execute 'buffer '.bjump
      else
        execute 'enew'.a:bang
      endif
    endif
  endfor
  execute 'bdelete'.a:bang.' '.btarget
  execute wcurrent.'wincmd w'
endfunction
command! -bang -complete=buffer -nargs=? Bclose call <SID>Bclose(<q-bang>, <q-args>)
nnoremap <silent> <Leader>bd :Bclose<CR>
nnoremap <silent> <Leader>bD :Bclose!<CR>

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" s{char}{char} to move to {char}{char}
nmap <Leader>s <Plug>(easymotion-sn)
nmap <Leader>t <Plug>(easymotion-tn)

let g:vista_default_executive = "ctags"
let g:vista_blink = [1, 250]

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)
