" Basic settings
syntax on
filetype plugin indent on
set clipboard=unnamedplus
set nocompatible
set hidden
set wrap
set encoding=utf-8
set fileencoding=utf-8
" set mouse=a

" Tab / indent
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set autoindent
set smartindent

" Performance
set nolazyredraw
set updatetime=100
set ttyfast
set laststatus=2

" UI
set showmode
set number
set relativenumber
set showcmd
set incsearch

set wildmenu
set wildmode=longest:full,full

set omnifunc=syntaxcomplete#Complete

if filereadable(expand("~/.vimrc.plug"))
  source ~/.vimrc.plug
endif

autocmd VimEnter * if filereadable(expand("~/.vimrc.path")) |	source ~/.vimrc.path | endif

let mapleader = ";"
" let mapleader = " "
" nnoremap <SPACE> <Nop>

colorscheme gotham256

if has("patch-8.1.0360")
  set diffopt+=internal,algorithm:patience
endif

" --- FZF settings with bat preview ---
let $BAT_THEME='gotham'
let $FZF_DEFAULT_OPTS='--color=16 --reverse --border'
let g:fzf_preview_window = ['right:60%:wrap']

if executable('bat')
  let g:fzf_preview_command = 'bat -A --style=numbers --color=always --theme=gotham --line-range :500 {}'
else
  let g:fzf_preview_command = 'cat {}'
endif

" --- NERDTree Configure ---
" autocmd VimEnter * NERDTree | NERDTreeFind | wincmd p 
" autocmd BufEnter * if (winnr("$") == 1 && &filetype == "nerdtree") | quit | endif

let NERDTreeDirArrows = 1
let NERDTreeMapKeys = 1
let g:nerdtree_vis_confirm_open = 0
let g:nerdtree_vis_confirm_delete = 0
let g:nerdtree_vis_confirm_copy = 0
let g:nerdtree_vis_confirm_move = 0
let g:nerdtree_vis_confirm_append_arglist = 0
let g:nerdtree_vis_confirm_set_arglist = 0
let g:NERDTreeHijackNetrw = 1


xnoremap <leader>n :call NERDTreeVisualSelection()<CR>
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <leader>nm :NERDTreeMirror<CR>:NERDTreeFocus<CR>
nnoremap <leader>nt :NERDTreeToggle<CR>
nnoremap <leader>nf :NERDTreeFind<CR>
nnoremap <leader>nr :NERDTreeRefreshRoot<CR>

" --- Floaterm Configure ---
let g:floaterm_title         = 'terminal: $1/$2'
let g:floaterm_wintype       = 'split'
let g:floaterm_position      = 'center'
let g:floaterm_height 			 = 0.6
let g:floaterm_width 				 = 0.4
let g:floaterm_autoclose 		 = 1
let g:floaterm_autoinser 		 = 1

let g:floaterm_keymap_new = '<Leader>ft'
let g:floaterm_keymap_toggle = '<Leader>t'
let g:floaterm_keymap_prev = '<Leader>h'
let g:floaterm_keymap_next = '<Leader>l'
hi link FloatermBorder Normal

" --- VIM Session ---
let g:session_dir = expand('~/.vim/sessions')

function! s:SessionList(A, L, P)
  if !isdirectory(g:session_dir)
    return []
  endif
  let l:files = globpath(g:session_dir, '*.vim', 0, 1)
  let l:names = map(l:files, 'fnamemodify(v:val, ":t:r")')
  return l:names
endfunction

command! -nargs=1 -complete=customlist,s:SessionList SaveSession call s:SaveSession(<f-args>)
function! s:SaveSession(name)
  if !isdirectory(g:session_dir)
    call mkdir(g:session_dir, "p")
  endif
  let l:path = g:session_dir . '/' . a:name . '.vim'
  execute 'mks! ' . fnameescape(l:path)
  echo 'Session saved: ' . l:path
endfunction

command! -nargs=1 -complete=customlist,s:SessionList LoadSession call s:LoadSession(<f-args>)
function! s:LoadSession(name)
  if !isdirectory(g:session_dir)
    call mkdir(g:session_dir, "p")
  endif

  let l:path = g:session_dir . '/' . a:name . '.vim'

  silent! wa

  for buf in range(1, bufnr('$'))
    if bufexists(buf) && getbufvar(buf, '&modifiable') && !getbufvar(buf, '&buftype') =~# 'nofile'
      silent! execute 'bwipeout! ' . buf
    endif
  endfor

  " Load hoặc tạo session
  if filereadable(l:path)
    execute 'source ' . fnameescape(l:path)
    echo 'Session loaded safely: ' . l:path
  else
    execute 'mks! ' . fnameescape(l:path)
    echo 'New session created: ' . l:path
  endif
endfunction

" --- VIM Tab ---
nnoremap <leader>tn :tabnext<CR>
nnoremap <leader>tp :tabprevious<CR>
nnoremap <leader>tt :tabnew<CR>
nnoremap <leader>td :tabclose<CR>
nnoremap <leader>tr :tabmove +1<CR>
nnoremap <leader>tl :tabmove -1<CR>

" Number jump
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt

nmap <F8> :TagbarToggle<CR>

" --- VIM CTag ---
let g:gutentags_enabled = 1
let g:gutentags_ctags_executable = 'ctags'
let g:gutentags_cache_dir = '~/.cache/tags'
let g:gutentags_project_root = ['.hg', '.project']
let g:gutentags_add_default_project_roots = 0

" --- VIM lightline ---
let g:lightline = {
      \ 'colorscheme': 'gotham256',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }
"--- VIM CLIPBOARDS ---"
function! OSC52YankFromRegister()
    let l:save_reg = getreg('"')
    let l:save_type = getregtype('"')
    silent! normal! gvy
    let l:text = getreg('"')
    let l:b64 = system('base64', l:text)
    let l:b64 = substitute(l:b64, '\n', '', 'g')
    silent! execute "!printf '\\033]52;c;" . l:b64 . "\\a'"
    silent! redraw!
    call setreg('"', l:save_reg, l:save_type)
endfunction

nnoremap y y:call OSC52YankFromRegister()<CR>
xnoremap y y:call OSC52YankFromRegister()<CR>
nnoremap yy yy:call OSC52YankFromRegister()<CR>
nnoremap rg :execute 'Rg ' . escape(getreg('"'), ' \')<CR>
