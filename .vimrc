
colorscheme ir_black         " 着色模式
set guifont=Monaco:h11       " 字体 && 字号
set backspace=2              " 设置退格键可用
set autoindent               " 自动对齐
set autoread                 " auto load file on changed, press :e to load file
set ai!                      " 设置自动缩进
set smartindent              " 智能自动缩进
set shiftwidth=2             " 换行时行间交错使用2空格
set cindent shiftwidth=2     " 自动缩进2空格
set number                   " 显示行号
set mouse=a                  " 启用鼠标
set ruler                    " 右下角显示光标位置的状态行
set incsearch                " 开启实时搜索功能
set hlsearch                 " 开启高亮显示结果
set nowrapscan               " 搜索到文件两端时不重新搜索
set nocompatible             " 关闭兼容模式
set vb t_vb=                 " 关闭提示音
set hidden                   " 允许在有未保存的修改时切换缓冲区
set autochdir                " 设定文件浏览器目录为当前目录
set foldmethod=syntax        " 选择代码折叠类型
set foldlevel=100            " 禁止自动折叠
set laststatus=2             " 开启状态栏信息
set cmdheight=2              " 命令行的高度，默认为1，这里设为2
set showmatch               " 显示括号配对情况
set cursorline              " 突出显示当前行
"set nowrap                  " 设置不自动换行
set writebackup              " 设置无备份文件
set nobackup
set list                     " 显示Tab符，使用一高亮竖线代替
set listchars=tab:\|\ ,
set tabstop=2                " 设置Tab键的宽度        [等同的空格个数]
set expandtab                " 将Tab自动转化成空格    [需要输入真正的Tab键时，使用 Ctrl+V + Tab]
set hlsearch
set incsearch

syntax enable                " 打开语法高亮
syntax on                    " 开启文件类型侦测
filetype indent on           " 针对不同的文件类型采用不同的缩进格式
filetype plugin on           " 针对不同的文件类型加载对应的插件
filetype plugin indent on    " 启用自动补全

set statusline=
set statusline +=%4*\ %<%F%*            "full path
set statusline +=%2*%m%*                "modified flag
set statusline +=%1*%=%5l%*             "current line
set statusline +=%2*/%L%*               "total lines
set statusline +=%1*%4v\ %*             "virtual column number

" 在不同模式下使用不同光标形状
if has("autocmd")
  au InsertEnter * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape ibeam"
  au InsertLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
  au VimLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape ibeam"
endif


" 设置编码
set fenc=utf-8
set encoding=utf-8
set fileencodings=utf-8,gbk,cp936,latin-1

" ======= 引号 && 括号自动匹配 ======= "
function ClosePair(char)
  if getline('.')[col('.') - 1] == a:char
     return "\<Right>"
  else
     return a:char
  endif
endf

:inoremap ( ()<ESC>i

:inoremap ) <C-r>=ClosePair(')')<CR>

:inoremap { {}<ESC>i

:inoremap } <C-r>=ClosePair('}')<CR>

:inoremap [ []<ESC>i

:inoremap ] <C-r>=ClosePair(']')<CR>


" :LoadTemplate       根据文件类型自动加载模板
let g:template_path='~/.vim/template/'

imap <C-a> <ESC>I

imap <C-e> <ESC>A

cmap tree NERDTree

map tn :tabnew<CR>
map tc :tabclose<CR>

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
