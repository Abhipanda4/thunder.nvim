" ====================================================================
" Name:        plugins/options.vim
" Description: Settings for most options defined in :help options
" Maintainer:  Abhisek Panda <abhipanda03@gmail.com>
" ====================================================================

" Use 24bit colors
set termguicolors

set completeopt=menuone,noinsert,noselect
set shortmess=filnxtToOFcs

" Line settings
set wrapscan
set linebreak
set backspace=indent,eol,start
set scrolloff=4
set number
set relativenumber

" key to toggle between paste & nopaste
set pastetoggle=<F6>

" Indentation settings
set autoindent
set expandtab
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Layout of new splits should be as expected
set splitbelow
set splitright

" DO NOT redraw screen when executing macros
set lazyredraw

" Buffers can be changed without saving first
set hidden

" Search settings
set magic
set incsearch                " search incrementally
set hlsearch                 " Highlight search results
set ignorecase               " ignore case when searching
set smartcase                " If capital case is entered, search is case sensitive
set inccommand=nosplit       " Live substitution

" CMD Settings
set showcmd
set noshowmode
set cmdheight=2
set history=1000

" Add angular brackets to match with %
set matchpairs+=<:>
set showmatch

" Avoid unnecessary backups
set nobackup
set noswapfile
set nowritebackup

" Persistent undo
set undofile
set undodir=$HOME/.undodir

" Wildignore
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.oo,*.obj,*.exe,*.dll       " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.pyc,__pycache__                " Python byte code
set wildignore+=*.orig                           " Merge resolution files
set wildignore+=$VIMRUNTIME/doc/*.txt            " Individual helpfiles
set wildignore+=$VIMRUNTIME/doc/*.tar.gz         " compressed helpfiles
set wildignore+=**/doc/*.txt                     " All doc files in cwd

" Timeout settings
set timeoutlen=1000
set ttimeoutlen=0
set updatetime=500

" FIllchars
set fillchars=diff:.
