call plug#begin('~/.config/nvim/plugged')

" Colorschemes
Plug 'morhetz/gruvbox'
Plug 'mkarmona/colorsbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Directory and Tag Lists
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'ctrlpvim/ctrlp.vim'
" Auto Completion 
Plug 'Shougo/deoplete.nvim'
Plug 'SirVer/ultisnips'
Plug 'craigemery/vim-autotag'
Plug 'honza/vim-snippets'
" Search
Plug 'mileszs/ack.vim'
Plug 'junegunn/fzf.vim'
" Code Specific Formats
Plug 'maxmellon/vim-jsx-pretty'
Plug 'pangloss/vim-javascript'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'jtratner/vim-flavored-markdown'
Plug 'chr4/nginx.vim'
Plug 'sheerun/vim-polyglot'
" Coding Helpers
Plug 'vim-syntastic/syntastic'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'
Plug 'valloric/MatchTagAlways'
Plug 'mattn/emmet-vim'
Plug 'Lokaltog/vim-easymotion'
Plug 'gcmt/wildfire.vim'
Plug 'docunext/closetag.vim'
Plug 'majutsushi/tagbar'
Plug 'jiangmiao/auto-pairs'
Plug 'vimwiki/vimwiki'
Plug 'PeterRincker/vim-argumentative'
Plug 'roxma/vim-hug-neovim-rpc'

call plug#end()

" Change mapleader
let mapleader=","

" ********** NERDTree Settings **********
" Toggle
map <leader>n :NERDTreeToggle<CR>

" ********** Colorscheme Settings **********
colorscheme unokai
"let g:gruvbox_contrast_dark = 'hard'

" ********** Cursor Settings **********
set cursorline
hi CursorLine term=bold cterm=bold guibg=Grey20
" Enable mouse events
set mouse=a

" ********** Status and Tab Settings **********
let g:airline_theme = 'badwolf'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#exclude_preview = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#hunks#enabled=0
" Cycle through buffers
nmap <leader><Tab> :bn<CR>
nmap <leader>` :bp<CR>
" Split movement bindings
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>h
nnoremap <C-h> <C-w>k
nnoremap <C-l> <C-w>l

" ********** Autocompletion Settings **********
let g:deoplete#enable_at_startup = 1
"let g:deoplete#enable_smart_case = 1
call deoplete#custom#option({'smart_case': v:true})
" Python host locations
let g:python3_host_prog = "$HOME/.pyenv/versions/3.13.3/bin/python"
let g:ruby_host_prog = "/usr/bin/ruby"
let g:loaded_perl_provider = 0

" ********** Search Settings **********
" CtrlP mappings
let g:ctrlp_map = '<leader>t'
nmap <leader>r :CtrlPTag<cr>
" Ack search
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>
" Silver Searcher
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
" Go-to-next-tag mapping
nnoremap ; :tnext<CR>
" Easymotion binding and config
nmap <space> <Plug>(easymotion-s2)
let g:EasyMotion_smartcase = 1

" ********** Code Specific Settings **********
" Don't require .jsx for syntax highlighting
let g:jsx_ext_required = 0
" Syntastic checkers
let g:syntastic_javascript_checkers = ['eslint']
" Indent Guides
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_enabled = 0
let g:is_bash = 1

" *********** Settings **********
" Centralize backups, swapfiles and undo history
set backup
set backupdir=~/.config/nvim/backups
set directory=~/.config/nvim/swaps
set undofile
set undodir=~/.config/nvim/undo
set termguicolors

" Misc
set number
set hidden
set cursorline
set expandtab
set gdefault
set hlsearch
set ignorecase
set incsearch
set nowrap
set shiftwidth=2
set splitright
set tabstop=2
set wildchar=<TAB>
set clipboard+=unnamedplus
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js
set wildignore+=*/smarty/*,*/vendor/*,*/node_modules/*,*/.git/*,*/.hg/*,*/.svn/*,*/.sass-cache/*,*/log/*,*/tmp/*,*/build/*,*/ckeditor/*,*/doc/*
