" Commands
" 1. install plugin with vundle
"   - https://github.com/VundleVim/Vundle.vim#quick-start
"   - Launch vim and run :PluginInstall 
"   - To install from command line: vim +PluginInstall +qall
"
" 2. complie coffee
"   - https://github.com/kchmck/vim-coffee-script#compile-to-javascript
"   - :make!

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'jelera/vim-javascript-syntax'

Plugin 'kchmck/vim-coffee-script'

Plugin 'dkprice/vim-easygrep'

" All of your Plugins must be added before the following line
call vundle#end()            " required

colorscheme Mustang
set t_Co=256
set guifont=Monaco:h11       
set backspace=2              
set autoindent               
set autoread                 
set ai!                      
set smartindent              
set shiftwidth=2
set cindent shiftwidth=2
set number                   
set mouse=a                  
set ruler                    
set incsearch                
set hlsearch                 
set nowrapscan               
set nocompatible             
set vb t_vb=                 
set hidden                   
set autochdir                
set foldmethod=syntax        
set foldlevel=100            
set laststatus=2             
set cmdheight=2              
set showmatch               
set cursorline              
set writebackup              
set nobackup
set list                     
set listchars=tab:\|\ ,
set tabstop=2                
set expandtab                
set hlsearch
set incsearch

set statusline=
set statusline +=%4*\ %<%F%*            "full path
set statusline +=%2*%m%*                "modified flag
set statusline +=%1*%=%5l%*             "current line
set statusline +=%2*/%L%*               "total lines
set statusline +=%1*%4v\ %*             "virtual column number

syntax enable                
syntax on                    
filetype indent on           
filetype plugin on           
filetype plugin indent on    
let g:instant_markdown_autostart = 0

" Most prefer to automatically switch to the current file directory when
" a new buffer is opened; to prevent this behavior, add the
" following to
" your .vimrc.before.local file:
if !exists('g:spf13_no_autochdir')
  autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
  " Always switch to the current file directory
endif

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

set fenc=utf-8
set encoding=utf-8
set fileencodings=utf-8,gbk,cp936,latin-1

function ClosePair(char)
  if getline('.')[col('.') - 1] == a:char
     return "\<Right>"
  else
     return a:char
  endif
endf

set columns=80
set lines=40
if has("gui_macvim")
  set fuopt+=maxhorz
endif

:inoremap ( ()<ESC>i

:inoremap ) <C-r>=ClosePair(')')<CR>

:inoremap { {}<ESC>i

:inoremap } <C-r>=ClosePair('}')<CR>

:inoremap [ []<ESC>i

:inoremap ] <C-r>=ClosePair(']')<CR>


" :LoadTemplate     
let g:template_path='~/.vim/template/'

imap <C-a> <ESC>I
imap <C-e> <ESC>A
imap <C-d> <ESC>lxi

nmap U :later<CR>

map tree NERDTree

map tn :tabnew<CR>

let s:entrance_path = getcwd()

fun! MyGrep(name, ...)
  if a:name == ""
    echoerr "Command Locate need a parameter!"
  else
    echo "Begin searching \"" . a:name. "\"(start from " . s:entrance_path . ")"
    let a:files = s:entrance_path . "/**"
    let a:type = ""
    if a:0 > 1
      echoerr "Command Locate can only take two parameters top!"
      return
    endif
    if a:0 == "1"
      let a:type = "/*." . a:1
    endif
    execute "noautocmd vimgrep \"" . a:name. "\" " . a:files . a:type
  endif
endfunction

command! -nargs=* Locate call MyGrep(<f-args>)

" for php
imap <C-p> <?php<CR>?><CR><ESC>kk

" for rubocop.vim
let g:vimrubocop_keymap = 0
let g:vimrubocop_config = '/Users/kilen/.vim/plugin/rubocop_configs/default.yml'
nmap ro :RuboCop<CR>

" for pathogen
execute pathogen#infect()

