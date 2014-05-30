""" .vimrc

"""
""" Peter Tersløv Forsberg <ptrf@pronoia.dk>
""" 2009-2014 - Feel free to copy as much as you want

""" Remap of mapleader - <leader>
let mapleader = ","

""" Behavioral
set nocompatible
set noinsertmode
set bs=2
set incsearch
set hlsearch
set showmatch
set path=.,~/
set updatecount=50
set ttyfast
set report=0
set nomodeline
set novisualbell
set shortmess=atI
" Start scrolling three lines before the horizontal window border
set scrolloff=3
" Show the current mode
set showmode
set noerrorbells
" Don’t reset cursor to start of line when moving around.
set nostartofline
set autoread
set autowrite
" Enhance command-line completion
set wildmenu
" Don’t add empty newlines at the end of files
set binary
set noeol
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed
" Ignore case of searches
set ignorecase

""" Input
set backspace=indent,eol,start
set expandtab
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set pastetoggle=<Leader>p
" Use UTF-8 without BOM
set encoding=utf-8 nobomb

""" Terminal variables.
set t_Co=256
set t_ti=
set t_te=

""" Mmm, inkpot. Plus, we like syntax hilighting!
colorscheme inkpot
syntax on

""" Remove no from nocursorcolumn to get fancy crosshair
set nocursorcolumn
set cursorline

""" Backup, swaps, undos, etc.
set backup
set backupdir=~/.vim/backups/
set swapfile
set directory=~/.vim/swaps/
set undolevels=1000
set undodir=~/.vim/undof

""" Encoding, file formats
set enc=utf-8
set tenc=utf-8
set fileformat=unix

""" Visual appearance
" Keep at least 3 lines above and below cursor
set so=3
set nonumber
set ruler
set laststatus=2

""" GUI options
" Font face and no toolbar
set gfn=Inconsolata
set go=acgi


""""
"""" REMAPS
""""

"""" MOVEMENT
" Make tab jump to next bracket
nnoremap <tab> %
vnoremap <tab> %

" Make arrow keys useless
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Easy move between splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Make j and k move up and down, regardless of line wraps etc.
nnoremap j gj
nnoremap k gk

map <C-S-k> <C-]>
map <C-S-j> <C-t>

" Sudo to write
cmap w!! w !sudo tee % >/dev/null

"""
""" LEADERS
"""

" :nohlsearch
nnoremap <leader><space> :noh<cr>

" :vsplit, move focus to new window
nnoremap <leader>w <C-w>v<C-w>l

" reformat paragraph
nnoremap <leader>q gqip

" put a line of ='s below the current line w/ same width
nnoremap <leader>1 yypVr=
nnoremap <leader>2 yypVr-

" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

"""
""" FUNCTIONS
"""

""" If we have a nice font, we want tabs and trails to show visually.
if (&termencoding == "utf-8") || has("gui_running")
    if v:version >= 700
        set list listchars=tab:▸\ ,trail:·,extends:…,nbsp:‗,eol:¬
    else
        set list listchars=tab:»·,trail:·,extends:…
    endif
else
    if v:version >= 700
        set list listchars=tab:>-,trail:.,extends:>,nbsp:_
    else
        set list listchars=tab:>-,trail:.,extends:>
    endif
endif

""" Make sure we have needed directories in place
if has("unix")
    if !isdirectory(expand("~/.vim/"))
        !mkdir -p ~/.vim/backups/
        !mkdir -p ~/.vim/swaps/
        !mkdir -p ~/.vim/undofiles/
    endif
endif

if has("folding")
    set foldenable
    set foldmethod=indent
    set foldlevelstart=99
endif

if has("title")
    set title
endif

if has("eval")
    filetype on
    filetype indent on
    filetype plugin on
endif

if has("autocmd")
    autocmd BufNewFile,BufRead *.txt                     setf txt
    autocmd FileType mail,txt set nohlsearch formatoptions+=t textwidth=72 nonu
    autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
    autocmd BufNewFile,BufRead *.md setfiletype markdown syntax=markdown
endif


"""
""" PLUGINS
"""

""" Pathogen infect
execute pathogen#infect()

""" markdown mode
let g:vim_markdown_initial_foldlevel=1

""" Secure modelines
let g:secure_modelines_verbose = 1
let g:secure_modelines_modelines = 15

""" Github comment
let g:github_user = 'ptrf'
let g:github_comment_open_browser = 1

""" Git gutter
let g:gitgutter_eager = 1
