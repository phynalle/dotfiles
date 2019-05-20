set nu
set rnu
set ts=4
set sts=4
set sw=4
set expandtab
set hlsearch
set hidden

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-surround'
Plug 'morhetz/gruvbox'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'liuchengxu/vista.vim'
Plug 'Yggdroot/indentLine'
Plug 'cohama/agit.vim'
Plug 'junegunn/seoul256.vim'
" Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
call plug#end()

" set background=dark
" colo gruvbox
set background=dark
let g:seoul256_background = 235
colo seoul256
hi CursorLineNr ctermbg=236 guibg=#3F3F3F

autocmd BufWritePre * :call TrimWhitespace()

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 0

if has('nvim')
  aug fzf_setup
    au!
    au TermOpen term://*FZF tnoremap <silent> <buffer><nowait> <esc> <c-c>
  aug END
end

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case --glob "!{.git/*,*.pyc}" '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)


function! FZFCustom()
    let cmd = 'fd -tf -E "!{.git/*, *.pyc}"'
    call fzf#run({
        \ 'source': cmd,
        \ 'sink': 'e',
        \ 'options': '',
        \ 'down': '40%' })
endfunction

function! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfunction

nmap <c-p> :call FZFCustom()<CR>
nmap <c-f> :Rg<space>
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

nmap <c-t> :enew<CR>
nmap <c-h> :bp<CR>
nmap <c-l> :bn<CR>
nmap <c-1> :b 1<CR>
nmap <c-2> :b 2<CR>
nmap <c-3> :b 3<CR>
nmap <c-4> :b 4<CR>

inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
nmap <silent> gd <Plug>(coc-definition)

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

function DecorateHotFunction()
    let [_, curline, curcol, _, _] = getcurpos()
    call cursor(1, 1)
    while v:true
        let line = search('^\s*def \w\+(', 'cW')
        if line == 0
            break
        endif

        call cursor(line + 1, curcol)
        if getline(line - 1) =~ '^\s*@hot$'
            continue
        endif
        if line <= curline
            let curline += 1
        endif

        let whitespaces = matchstr(getline(line), '^\s*')
        call append(line - 1, whitespaces.'@hot')
    endwhile
    call cursor(curline, curcol)
endfunction

function ImportHotDecorator()
    let code = "from k1server.hotreload import hot"
    let line = search('^from __future__', 'n')
    if line == 0
        if getline(1) =~ '# -\*- coding'
            let line = 1
        endif
    endif
    if getline(line + 1) != code
        call append(line, code)
    endif
endfunction

function DecorateHotClass()
    call ImportHotDecorator()

    let [_, curline, curcol, _, _] = getcurpos()
    call cursor(1, 1)
    while v:true
        let line = search('^\s*class \w\+', 'W')
        while line > 0
            if getline(line - 1) =~ '^\s*@hot$'
                break
            elseif getline(line - 1) =~ '^\s*@'
                let line -= 1
            else
                break
            endif
        endwhile
        if line == 0
            break
        endif
        if getline(line - 1) =~ '^\s*@hot$'
            continue
        endif
        if line <= curline
            let curline += 1
        endif

        let whitespaces = matchstr(getline(line), '^\s*')
        call append(line - 1, whitespaces.'@hot')
    endwhile
    call cursor(curline, curcol)
endfunction

function DecorateHot()
    call DecorateHotClass()
    call DecorateHotFunction()
endfunction

function RemoveHotDecorated()
    let [_, curline, curcol, _, _] = getcurpos()
    call cursor(1, 1)
    while v:true
        let line = search('^\s*@hot', 'cW')
        if line == 0
            break
        endif
        execute line.',delete'
        if line < curline
            let curline -= 1
        endif
    endwhile
    call cursor(curline, curcol)
    execute search('from k1server.hotreload import hot').',delete'
endfunction

command! Hot call DecorateHot()
command! HotFunc call DecorateHotFunction()
command! HotClass call DecorateHotClass()
command! Hotx call RemoveHotDecorated()
