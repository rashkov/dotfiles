" Clear default highlighting
" hi clear

" Enable case-insensitive search, include /C in search string to re-enable it
set ignorecase

" Enable highlighting of search terms
set hlsearch

" Setting Tab size to 4
" http://stackoverflow.com/questions/234564/tab-key-4-spaces-and-auto-indent-after-curly-braces-in-vim
" http://stackoverflow.com/questions/1276403/simple-vim-commands-you-wish-youd-known-earlier

set smartindent
set autoindent
set tabstop=2
set shiftwidth=2
set expandtab
set textwidth=0
" gqG - force format all text

" Avoids issues with indenting multiple times

:vnoremap < <gv
:vnoremap > >gv

" {{{ Misc Settings

" Necesary  for lots of cool vim things
set nocompatible
filetype off

" Show what you are typing as a command.
set showcmd

" Needed for Syntax Highlighting and stuff
set grepprg=grep\ -nH\ $*

" Set history length to 10000 lines
set history=10000

" Spaces are better than a tab character
set expandtab
set smarttab

" Tabs
set shiftwidth=2
set softtabstop=2

" Cool tab completion stuff
set wildmenu
set wildmode=list:longest,full

" Got backspace?
set backspace=2

" Line Numbers
set number
set ruler

" Use more prompt
set more

" Treat underscore as word break
"set iskeyword-=_

" Allow saving of files as sudo when I forgot to start vim using sudo.
" http://stackoverflow.com/questions/2600783/how-does-the-vim-write-with-sudo-trick-work
cmap w!! %!sudo tee > /dev/null %
cmap a!! !sudo apachectl restart

" Status line gnarliness
set laststatus=2
set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v][%p%%]
" }}}

autocmd FileType html set omnifunc=htmlcomplete#CompleteTags

" Highlight lines of text over 80 characters in width
highlight OverLength ctermbg=red cterm=bold "ctmerfg=white guibg=#592929 match OverLength /\%81v.\+/

" Limit to 80 chars per line
" set columns=80

" NERDTree
autocmd vimenter * if !argc() | NERDTreeToggle | endif
noremap <F2> :NERDTreeToggle<CR><CR>

" Vundle plugins
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#rc()
Bundle 'gmarik/Vundle.vim'
Bundle 'elzr/vim-json'
Bundle 'scrooloose/nerdtree'
Bundle 'jistr/vim-nerdtree-tabs'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'digitaltoad/vim-jade'
Bundle 'mxw/vim-jsx'
Bundle 'pangloss/vim-javascript'
Bundle 'kchmck/vim-coffee-script'
Bundle 'AndrewRadev/vim-eco'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-fugitive'

" Functions to move buffers around between tabs
function MoveToPrevTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() != 1
    close!
    if l:tab_nr == tabpagenr('$')
      tabprev
    endif
    sp
  else
    close!
    exe "0tabnew"
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc

function MoveToNextTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() < tab_nr
    close!
    if l:tab_nr == tabpagenr('$')
      tabnext
    endif
    sp
  else
    close!
    tabnew
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc
 
" Move buffer to next tab or previous tab via C-m or C-n
map <C-m> :call MoveToNextTab()<CR><C-w>H
map <C-n> :call MoveToPrevTab()<CR><C-w>H 

" extended % matching for html tags
source /usr/share/vim/vim80/macros/matchit.vim

" Ignore list for ctrlp fuzzy search
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$|\v[\/]_site',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

nnoremap <C-h> :TmuxNavigateLeft<cr>
nnoremap <C-j> :TmuxNavigateDown<cr>
nnoremap <C-k> :TmuxNavigateUp<cr>
nnoremap <C-l> :TmuxNavigateRight<cr>
nnoremap <C-\> :TmuxNavigatePrevious<cr>

" Whitespace highlighting
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Colorscheme
colorscheme slate

" Turn things back on, must be done at end of file
syntax enable
filetype plugin indent on

" Set syntastic to use jsxhint wrapper around jshint
let g:syntastic_javascript_checkers = ['jsxhint']
let g:syntastic_coffee_checkers = ['coffeelint']
