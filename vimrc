" LastModified: 2013-12-05 22:49:37
" based on http://github.com/jferris/config_files/blob/master/vimrc

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
" 启用vi兼容格式
set nocompatible

" 使用vundle必须加上
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup
set nowritebackup
" 记录历史命名条数
set history=50" keep 50 lines of command line history
" 编辑时显示光标状态
set ruler" show the cursor position all the time
set showcmd" display incomplete commands
" 快速匹配
set incsearch" do incremental searching

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
  " 高亮查找
  set hlsearch
endif

" Switch wrap off for everything
" set nowrap
set wrap

" 粘帖插入
set paste

" 语言设置
" set langmenu=zh_CN.UTF-8
" set helplang=cn

" 设置当文件被外部改变到时候自动读入文件
if exists("&autoread")
  set autoread
endif

" 换行不截断单词
set linebreak

"使用autocmd命名,保存文件时自动插入最后修改日期和时间
autocmd BufWritePre,FileWritePre vimrc ks|call LastModified()|'s
fun LastModified()
  exe "1,$ s/[L]astModified: .*/LastModified:" .
        \ strftime(" %F %T"). "/e"
endfun


" only do this part when compiled with support for autocommands.
if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Set File type to 'text' for files ending in .txt
  autocmd BufNewFile,BufRead *.txt setfiletype text

  " Enable soft-wrapping for text files
  autocmd FileType text,markdown,html,xhtml,eruby setlocal wrap linebreak nolist

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  " autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Automatically load .vimrc source when saved
  autocmd BufWritePost .vimrc source $MYVIMRC

  augroup END

else

  " 自动对齐
  "always set autoindenting on
  set autoindent

endif " has("autocmd")

" if has("folding")
  " set foldenable
  " set foldmethod=syntax
  " set foldlevel=1
  " set foldnestmax=2
  " set foldtext=strpart(getline(v:foldstart),0,50).'\ ...\ '.substitute(getline(v:foldend),'^[\ #]*','','g').'\ '
" endif

" softtabs, 2 spaces
" tab为2个空格
set tabstop=2
" 当前行之间交错时使用2个空格 
set shiftwidth=2
" 输入tab时自动转换为空格
set expandtab

" always display the status line
set laststatus=2

" \ is the leader character
let mapleader = ","

" edit the README_FOR_APP (makes :R commands work)
map <Leader>R :e doc/README_FOR_APP<CR>

" leader shortcuts for Rails commands
map <Leader>m :Rmodel 
map <Leader>c :Rcontroller 
map <Leader>v :Rview 
map <Leader>u :Runittest 
map <Leader>f :Rfunctionaltest 
map <Leader>tm :RTmodel 
map <Leader>tc :RTcontroller 
map <Leader>tv :RTview 
map <Leader>tu :RTunittest 
map <Leader>tf :RTfunctionaltest 
map <Leader>sm :RSmodel 
map <Leader>sc :RScontroller 
map <Leader>sv :RSview 
map <Leader>su :RSunittest 
map <Leader>sf :RSfunctionaltest 

" hide search highlighting
map <Leader>h :set invhls <CR>

" opens an edit command with the path of the currently edited file filled in
" normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" opens a tab edit command with the path of the currently edited file filled in
" normal mode: <Leader>t
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" inserts the path of the currently edited file into a command
" command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" duplicate a selection
" visual mode: D
vmap D y'>p

" press Shift+P while in visual mode to replace the selection without
" overwriting the default register
vmap P p :call setreg('"', getreg('0')) <CR>

" for Haml
au! BufRead,BufNewFile *.haml         setfiletype haml

" no Help, please
nmap <F1> <Esc>

" press ^F from insert mode to insert the current file name
imap <C-F> <C-R>=expand("%")<CR>

" maps autocomplete to tab
imap <Tab> <C-N>

imap <C-L> <Space>=><Space>

" display extra whitespace(显示已存在所空格和tab)
set list listchars=tab:»·,trail:·

" edit routes
command! Rroutes :e config/routes.rb
command! Rschema :e db/schema.rb

" local config
if filereadable(".vimrc.local")
  source .vimrc.local
endif

" use Ack instead of Grep when available
if executable("ack")
  set grepprg=ack\ -H\ --nogroup\ --nocolor\ --ignore-dir=tmp\ --ignore-dir=coverage
endif

" color scheme
" colorscheme vividchalk
" highlight NonText guibg=#060606
" highlight Folded  guibg=#0A0A0A guifg=#9090D0

" numbers
" 显示行号
set number
" 行号宽度
set numberwidth=5

" snippets are activated by Shift+Tab
let g:snippetsEmu_key = "<S-Tab>"

" tab completion options
" (only complete to the longest unambiguous match, and show a menu)
set completeopt=longest,menu
set wildmode=list:longest,list:full
set complete=.,t

" case only matters with mixed case expressions
set ignorecase
set smartcase

" tags
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"
set tags=./tags;

let g:fuf_splitPathMatching=1

" Open URL
command -bar -nargs=1 OpenURL :!open <args>
function! OpenURL()
  let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;:]*')
  echo s:uri
  if s:uri != ""
    exec "!open \"" . s:uri . "\""
  else
    echo "No URI found in line."
  endif
endfunction
map <Leader>w :call OpenURL()<CR>

