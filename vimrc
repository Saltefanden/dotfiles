set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'Everblush/everblush.vim'
Plugin 'tpope/vim-commentary'
Plugin 'preservim/nerdtree'
" Install nodejs:
" $ curl -sL install-node.now.sh | sudo bash
" Install yarn
" $ curl --compressed -o- -L https://yarnpkg.com/install.sh | bash
" Install project using yarn
" ~/.vim/bundle/coc.nvim$ yarn install
" Remove yarn
" ~$ rm -rf .yarn .yarnrc 
" And delete the added path in .bashrc
Plugin 'neoclide/coc.nvim', {'branch': 'release'}

call vundle#end()            " required

filetype plugin indent on    " required


set nu rnu
syntax on

"Do not prompt to save buffers when switching 
set hidden

"Do not use arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

let g:everblushNR=1
colo everblush

" Start NERDTree and put the cursor back in the other window.
" autocmd VimEnter * NERDTree | wincmd p

" Exit Vim if NERDTree is the only window remaining in the only tab.
" autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
