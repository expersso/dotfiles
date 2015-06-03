"""""""""" GENERAL OPTIONS """"""""""

set nocompatible               " must be first, because changes other options
set backspace=indent,eol,start " allow backspacing over everything
set history=200                " keep 50 lines of command line history
set ruler                      " show the cursor position all the time
set showcmd                    " display incomplete commands
set incsearch                  " do incremental searching
set ignorecase                 " ignore case in searching
set smartcase                  " search case-sensitive when using any caps
set number                     " show line numbers
set nobackup                   " no backup files
set noswapfile                 " no swapfiles
set hidden                     " Allow moving between buffers even when not saved
set splitright                 " open splits in correct position
set splitbelow                 " open splits in correct position
set gdefault                   " set /g as default in search+replace
set shortmess+=I               " remove startup message
set showmatch                  " show matching bracket when closing
set background=dark

" Tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=79
set smarttab
set expandtab
set smartindent

" Enable wildmenu
set wildmenu
set wildmode=list:longest,full
set wildignore+=*.pyc,*.zip,*.gz,*.bz,*.tar.*,*.jpg,*.png,*.gif,*.avi,*.wmv,*.ogg,*.mp3,*.mov,*.bz2,*.pdf

" Match parentheses
let loaded_matchparen = 1

" setup statusline
set laststatus=2
set statusline=   " clear statusline when vimrc reloaded
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

"vertical/horizontal scroll off settings
set scrolloff=3
set sidescrolloff=7
set sidescroll=1

if has('mouse')
  set mouse=a
endif

" Set syntax highlighting for markdown files
augroup markdown
    au!
    au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

" use matchit (% to jump to matching hmtl tag), Use set filetype=html in other files.
source /usr/share/vim/vim74/macros/matchit.vim

" change color of pop-up menu
highlight   Pmenu   ctermfg=0 ctermbg=2

"""""""""" REMAPPINGS """"""""""

" Move around Vim command line using Emacs key-bindings
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

" move between windows by ctrl+hjkl, i.e. drop c-w prefix
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Toggle showing hidden characters
nmap <leader>l :set list!<CR>

" remap Y to be like C and D
nnoremap Y y$

"""""""""" MISCELLANEOUS """"""""""

" remove auto-continue comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" type lorem in insert mode
inoreabbrev lorem Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi.

" add 256 color support
if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
    set t_Co=256
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
" leader + q to remove search highlights
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  nmap <leader>q :nohlsearch<CR>
endif

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
endif 

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

"""""""""" PLUGINS """"""""""
execute pathogen#infect()

autocmd FileType python set omnifunc=pythoncomplete#Complete

colorscheme gruvbox
let g:SuperTabDefaultCompletionType = "context"
let g:jedi#popup_on_dot = 0

" set jedi-vim preview window to bottom
augroup PreviewOnBottom
	autocmd InsertEnter * set splitbelow
	autocmd InsertLeave * set splitbelow!
augroup END

" jedi-vim: set where split opens up
let g:jedi#popup_select_first = 1
let g:jedi#use_tabs_not_buffers = 1

" toggle NERDTreeToggle
nnoremap <c-u> :NERDTreeToggle<CR>

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

" add filetypes to match tags
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
    \ 'php' : 1,
    \}

let g:slime_target = "tmux"
let g:slime_python_ipython = 1

" Toggle showing Syntastic
nmap <leader>s :SyntasticToggleMode<CR>

" Map CtrlP to c-p
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'c'
"
" global path to ycm config file
let g:ycm_global_ycm_extra_conf = "~/dotfiles/.ycm_extra_conf.py"

" add space to comments
let g:NERDSpaceDelims = 1

" run :Tabularize with leader+a+character
if exists(":Tabularize")
    nmap <Leader>a= :Tabularize /=<CR>
    vmap <Leader>a= :Tabularize /=<CR>
    nmap <Leader>a: :Tabularize /:\zs<CR>
    vmap <Leader>a: :Tabularize /:\zs<CR>
    nmap <Leader>a{ :Tabularize /{<CR>
    vmap <Leader>a{ :Tabularize /{<CR>
    nmap <Leader>a" :Tabularize /"<CR>
    vmap <Leader>a" :Tabularize /"<CR>
endif
