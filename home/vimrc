set nocompatible                " choose no compatibility with legacy vi
syntax enable                   " Turn on syntax highlighting
set encoding=utf-8              " Default text encoding
set showcmd                     " display incomplete commands
filetype plugin indent on       " load file type plugins + indentation
set t_Co=256                    " Trying to get color schemes working remotely
set nohlsearch                  " Search highlighting is super annoying

set path=$PWD/**                " Set the path variable to the current working
                                " directory to make :find work

"" Color Scheme
set background=dark
colorscheme pablo

"" Whitespace
set nowrap                      " don't wrap lines
set tabstop=2 shiftwidth=2      " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode
autocmd BufWritePre * :%s/\s\+$//e  " Strip trailing whitespace on save

"" File completion
set wildmode=list:longest       " Complete the longest common match and show
                                " a list of possible matches

if exists("&wildignorecase")
  set wildignorecase            " Ignore case on autocomplete
endif

"" Ctags
set tags=./tags,tags;

function! DelTagOfFile(file)
  let fullpath = a:file
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let f = substitute(fullpath, cwd . "/", "", "")
  let f = escape(f, './')
  let cmd = 'sed -i "/' . f . '/d" "' . tagfilename . '"'
  let resp = system(cmd)
endfunction

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

"" statusline
set laststatus=2
set statusline=
set statusline=%-3.3n           " buffer number
set statusline+=%t              " tail of the filename
set statusline+=%h              " help file flag
set statusline+=%m              " modified flag
set statusline+=%y              " filetype
set statusline+=%=              " left/right separator
set statusline+=%c,             " cursor column
set statusline+=%l/%L           " cursor line/total lines
set statusline+=\ %P            " percent through file

"" Prefs for MacVim
if has('gui_running')
  set guifont=Source\ Code\ Pro:h13
  set guioptions-=T             " get rid of the toolbar
  set number                    " show line numbers
endif

"" Tab stops, etc
au BufRead,BufNewFile vsql.edit.* set filetype=sql
au FileType php setl sw=4 sts=4 et
au FileType python setl sw=4 sts=4 et
au FileType java setl sw=4 sts=4 et
au FileType scala setl sw=2 sts=2 et
au FileType javascript setl sw=4 sts=4 et
au Filetype markdown set wrap linebreak textwidth=0
autocmd FileType php autocmd BufWritePre <buffer> :%s/\s\+$//e
autocmd FileType ruby autocmd BufWritePre <buffer> :%s/\s\+$//e

"" Ignore files I never want to find
set wildignore+=**/*.class

"" Skeleton files
autocmd BufNewFile  *.py 0r ~/.vim/skel/skeleton.py

"" PHP stuff
let php_sql_query=1
let php_htmlInStrings=1
let php_noShortTags = 1
