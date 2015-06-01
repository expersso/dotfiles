" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set ignorecase      " ignore case in searching
set smartcase       " search case-sensitive when using any caps
set number
set nobackup
set noswapfile
set hidden " Allow moving between buffers even when not saved

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
" leader + q to remove search highlights
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  nmap <leader>q :nohlsearch<CR>
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin on
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=79
set smarttab
set expandtab
set smartindent
	
autocmd FileType python set omnifunc=pythoncomplete#Complete

" Match parentheses
let loaded_matchparen = 1

execute pathogen#infect()

let g:SuperTabDefaultCompletionType = "context"
let g:jedi#popup_on_dot = 0

" Enable wildmenu
set wildmenu
set wildmode=list:longest,full
set wildignore+=*.pyc,*.zip,*.gz,*.bz,*.tar.*,*.jpg,*.png,*.gif,*.avi,*.wmv,*.ogg,*.mp3,*.mov,*.bz2,*.pdf

" toggle NERDTreeToggle
nnoremap <c-n> :NERDTreeToggle<CR>

" open NERDTree automaticallt if no file opened
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" show dotfiles in NERDTree
let NERDTreeShowHidden=1

" Options for Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" setup statusline
set laststatus=2
set statusline=   " clear the statusline for when vimrc is reloaded
set statusline+=%-3.3n\                      " buffer number
set statusline+=%F\                          " file name
set statusline+=%h%m%r%w                     " flags
set statusline+=[%{strlen(&ft)?&ft:'none'},  " filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc}, " encoding
set statusline+=%{&fileformat}]              " file format
set statusline+=%=                           " right align
set statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}\  " highlight
set statusline+=%b,0x%-8B\                   " current char
set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset

"remap Y to be like C and D
nnoremap Y y$

"vertical/horizontal scroll off settings
set scrolloff=3
set sidescrolloff=7
set sidescroll=1

" add filetypes to match tags
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
    \ 'php' : 1,
    \}

" type lorem in insert mode
inoreabbrev lorem Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi.

" use matchit (% to jump to matching hmtl tag), Use set filetype=html in other files.
source /usr/share/vim/vim74/macros/matchit.vim

set background=dark
colorscheme solarized

set showmatch

let g:slime_target = "tmux"

" jedi-vim: set where split opens up
let g:jedi#popup_select_first = 1
let g:jedi#use_tabs_not_buffers = 1

" set jedi-vim preview window to bottom
augroup PreviewOnBottom
	autocmd InsertEnter * set splitbelow
	autocmd InsertLeave * set splitbelow!
augroup END

" change color of pop-up menu
" highlight   clear
highlight   Pmenu         ctermfg=0 ctermbg=2
" highlight   PmenuSel      ctermfg=0 ctermbg=7
" highlight   PmenuSbar     ctermfg=7 ctermbg=0
" highlight   PmenuThumb    ctermfg=0 ctermbg=7

" Toggle showing hidden characters
nmap <leader>l :set list!<CR>

" Toggle showing Syntastic
nmap <leader>s :SyntasticToggleMode<CR>

" allow moving between windows by ctrl+hjkl, i.e. drop c-w prefix
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Map CtrlP to c-p
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'c'

" Set syntax highlighting for markdown files
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

"Move around Vim command line using normal Emacs key-bindings
:cnoremap <C-a>  <Home>
:cnoremap <C-b>  <Left>
:cnoremap <C-f>  <Right>
:cnoremap <C-d>  <Delete>
:cnoremap <M-b>  <S-Left>
:cnoremap <M-f>  <S-Right>
:cnoremap <M-d>  <S-right><Delete>
:cnoremap <Esc>b <S-Left>
:cnoremap <Esc>f <S-Right>
:cnoremap <Esc>d <S-right><Delete>
:cnoremap <C-g>  <C-c>

" add 256 color support
"if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
    "set t_Co=256
"endif

" open splits in correct position
set splitright
set splitbelow

" set /g as default in search+replace
set gdefault

" remove startup message
set shortmess+=I
