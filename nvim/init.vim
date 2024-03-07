" options
set background=dark
set clipboard=unnamedplus
set completeopt=noinsert,menuone,noselect
set cursorline
set hidden
set inccommand=split
set mouse=a
set number
set relativenumber
set splitbelow splitright
set title
set ttimeoutlen=0
set wildmenu

" tabs size
set expandtab
set shiftwidth=2
set tabstop=2

" syntax
filetype plugin indent on
syntax on

" color supprt
set t_Co=256
if $TERM !=? 'xterm-256color'
  set termguicolors
endif

" italics
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

" file browser
let g:netrw_banner=0
let g:netrw_liststyle=0
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_winsize=25
let g:netrw_keepdir=0
let g:netrw_localcopydircmd='cp -r'

" create file without opening buffer
function! CreateInPreview()
  let l:filename = input('please enter filename: )
  execute 'silent !touch ' . b:netrw_curdir.'/'.l:filename
  redraw!
endfunction

" netrw: create file using touch instead of opening a buffer
function! Netrw_mappings()
  noremap <buffer>% :call CreateInPreview()<cr>
endfunction

augroup auto_commands
  autocmd filetype netrw call Netrw_mappings()
augroup END

" plugin installation
call plug#begin()
  " appearance
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'ryanoasis/vim-devicons'
  Plug 'morhetz/gruvbox'

  " utilities
  Plug 'sheerun/vim-polyglot'
  Plug 'jiangmiao/auto-pairs'
  Plug 'ap/vim-css-color'
  Plug 'preservim/nerdtree'

  " completion / linters / formatters
  Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'npm ci'}
  Plug 'plasticboy/vim-markdown'

  " git
  Plug 'airblade/vim-gitgutter'
call plug#end()

" theme
colorscheme gruvbox

" airline config
let g:airline_theme='simple'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1

" file browser
let NERDTreeShowHidden=1

" file search
let g:ctrlp_user_command=['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" disable math tex conceal feature
let g:tex_conceal=''
let g:vim_markdown_math=1

" markdown
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_frontmatter=1
let g:vim_markdown_conceal=0
let g:vim_markdown_fenced_languages=['tsx=typescriptreact']

" prettier formatting
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
