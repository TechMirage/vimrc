" Set compatibility to Vim only.
set nocompatible

" Helps force plug-ins to load correctly when it is turned back on below. 
filetype off

" Turn on syntax highlighting. 
syntax on

" For plug-ins to load correctly.
filetype plugin indent on

" Basic stuff
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Speed up scrolling in Vim
set ttyfast

" Status bar
set laststatus=2

" Encoding, just for grins.
set encoding=utf-8
  
" Fix the searching case restrictions.
set ignorecase
set smartcase

" Relative number information, including autocommands to toggle it
" appropriately.
set number relativenumber

:augroup numbertoggle
:   autocmd!
:   autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:   autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
:augroup END

" Load the plug in manager vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
      silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif

" The plug-in loading stuff!
call plug#begin('~/.vim/plugged')

" The gruvbox theme stuff! Loads from https://github.com/morhetz/gruvbox
Plug 'morhetz/gruvbox'

" The Python tools for Python development.
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
let g:pymode_lint_config = '$HOME/.pylint.rc'
let g:pymode_options_max_line_length=120
" Map a run command for Python scripts.
map <F10> :PymodeRun<CR>

" Git integration
Plug 'tpope/vim-fugitive'

" Zen mode with Markdown support!
Plug 'junegunn/goyo.vim' | 
    \ Plug 'amix/vim-zenroom2'

" Airline - The lightweight status line at the bottom of the screen with
" themes.
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'

" The ever present nerd tree!
Plug 'preservim/nerdtree' |
    \ Plug 'Xuyuanp/nerdtree-git-plugin'
map <C-n> :NERDTreeToggle<CR>
let NERDTreeMinimalUI = 1 
let NERDTreeDirArrows = 1
let NERDTreeQuitOnOpen = 1

" Initialize plugin system!
call plug#end()

" Run the theme
set background=dark
autocmd vimenter * colorscheme gruvbox
" Also set the theme for Airline!
autocmd vimenter * AirlineTheme minimalist
" Start NERDTree automatically as well!
autocmd vimenter * NERDTree
" If NERDTree is the only open thing, then close Vim!
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

