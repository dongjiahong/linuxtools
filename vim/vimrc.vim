"这里是我常用的一些vim的配置`

syntax on			"开启语法高亮
set nu				"行号        
set hls				"高亮
set cursorline		"突出当前行
hi CursorLine cterm=NONE ctermbg=236 ctermfg=NONE
set ruler			"打开状态栏标尺
set tabstop=4		"tab键的宽度为4
set softtabstop=4	"使用退格键时，一次删除4个空格
set shiftwidth=4	"设置<<和>>命令移动时的宽度为4
"set cindent			"c风格的换行
set backspace=2		"mac机器需要开这个能用backspace键
set nofoldenable	"不折叠
set autoindent		"自动换行
set smartindent		"开启新行时使用智能自动缩进
set nobackup		"不允许自动备份
set laststatus=2	"显示状态栏
set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%]
"下面是对molokai的主题配置,需要将molokai.vim文件拷贝到/usr/share/vim/vim74/colors
set t_Co=256
colorscheme molokai
let g:rehash256 = 1 
let g:molokai_original = 1	"1浅色，0深色 
"快捷键
" 定义快捷键的前缀，即<Leader>
let mapleader=","
" 输入,ee 就是打开.vimrc
nmap <leader>ee :e ~/.vimrc<cr>	

"安装：
"	1、使用git下载vundle
"		运行命令：https://github.com/VundleVim/Vundle.vim
"		git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"	2、编辑.vimrc
"		在.vimrc中添加以下内容：

"-------->>> Vundle <<<------
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'tomasr/molokai'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'thinca/vim-quickrun'
Plugin 'SuperTab'

call vundle#end()
filetype plugin indent on

"-------->>NERD Tree<<-------
"宏F2打开目录树
nmap <F2> :NERDTreeToggle <CR>
"-------->>NERD commenter<<---------

"-------->>taglist<<---------
"必须先安装ctags： sudo aptitude install ctags
let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
let Tlist_Show_One_File = 1            "不同时显示多个文件的tag，只显示当前文件的
let Tlist_Exit_OnlyWindow = 1          "如果taglist窗口是最后一个窗口，则退出vim
let Tlist_Use_Right_Window = 1         "在右侧窗口中显示taglist窗口 
"宏，F8打开taglist
nmap <F8> :TagbarToggle<CR>     

"-------->>syntastic<<---------
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"let g:syntastic_cpp_remove_include_errors = 1
let g:syntastic_cpp_check_header = 1

let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libstdc++'

let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'


"映射分割屏幕的快捷键 Ctrl+h 往左屏切,Ctrl+j往上切等
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"------------->cscope<------------
if has("cscope")
  set csprg=/usr/bin/cscope
  set csto=1
  set cst
  set nocsverb
  " add any database in current directory
  if filereadable("cscope.out")
      cs add cscope.out
  endif
  set csverb
endif

"快捷键的配置，这里输入",ss"就是执行cs find s world 命令
nmap <leader>ss :cs find s<C-R>=expand("<cword>")<cr><cr>
nmap <leader>sg :cs find g <C-R>=expand("<cword>")<cr><cr>
nmap <leader>sc :cs find c <C-R>=expand("<cword>")<cr><cr>
nmap <leader>st :cs find t <C-R>=expand("<cword>")<cr><cr>
nmap <leader>se :cs find e <C-R>=expand("<cword>")<cr><cr>
nmap <leader>sf :cs find f<C-R>=expand("<cfile>")<cr><cr>
nmap <leader>si :cs find i<C-R>=expand("<cfile>")<cr><cr>
nmap <leader>sd :cs find d <C-R>=expand("<cword>")<cr><cr>

" ====>markdown 的设置<====
" 不折叠
let g:vim_markdown_folding_disable = 1

" ====>QuickRun 的设置<====
let g:quickrun_config = {
\   "_" : {
\       "outputter" : "message",
\   },
\}
nmap <leader>rr :QuickRun<CR>
" ====>SuperTab<=====
" 0 - 不记录上次的补全方式
" 1 - 记住上次的补全方式,直到用其他的补全命令改变它
" 2 - 记住上次的补全方式,直到按ESC退出插入模式为止
let g:SuperTabRetainCompletionType=2
