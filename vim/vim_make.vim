"这里是我常用的一些vim的配置`

set nocompatible    "关闭vi兼容模式
syntax on			"开启语法高亮
set nu				"行号        
set hls				"高亮
set cursorline		"突出当前行
set ruler			"打开状态栏标尺
set foldenable		"开始折叠
set foldmethod=syntax	"设置折叠域的宽度
setlocal foldlevel=1	"设置折叠层数为1
"set foldclose=all	"设置自动关闭折叠
set showmatch		"插入括号时，短暂的跳转到匹配括号
set matchtime=1		"短暂跳转到匹配括号的时间
set tabstop=4		"tab键的宽度为4
set expandtab		"设
set softtabstop=4	"使用退格键时，一次删除4个空格
set shiftwidth=4	"设置<<和>>命令移动时的宽度为4
set cindent			"c风格的换行
set autoindent		"自动换行
set smartindent		"开启新行时使用智能自动缩进
set nobackup		"不允许自动备份
set laststatus=2	"显示状态栏
set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%]
"下面是对molokai的主题配置,需要将molokai.vim文件拷贝到/usr/share/vim/vim74/colors
set t_Co=256
colorscheme molokai
let g:rehash256 = 1 
let g:molokai_original = 0 


"----下面是插件的安装和配置----

`这下面是vim安装YouCompleteMe插件的方法和配置内容`
需要的软件:
	- vim (尽量新的版本，至少 >= 4.3.7，截至 2013-10-27)
	- git (作为vundle插件的支持 sudo apt-get install git)
	- vim 插件 Vundle （参考：https://github.com/gmarik/vundle）
	- vim 插件 syntastic 与 ListToggle
	- CMake (>=2.8) (为c++项目生成 compile database)(sudo apt-get install cmake)
	- pylint (高级python语法检查支持)
	- python (系统自带的python没有dev：sudo apt-get install python-dev)
    - 如果报错说YCM需要python支持，安装python-dev也没有用的话可以安装vim-nox
安装：
	1、使用git下载vundle
		运行命令： git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
		这样插件将被下载到 ~/.vim/bundle/vundle
	2、编辑.vimrc
		在.vimrc中添加以下内容：

		""""""""""""""""""""" Vundle
		set nocompatible
		filetype off

		set rtp+=~/.vim/bundle/vundle
		call vundle#rc()

		Bundle 'gmarik/vundle'
        "安装插件ycm
		Bundle 'Valloric/YouCompleteMe'
        "安装插件ListToggl
		Bundle 'Valloric/ListToggle'
        "安装静态语法检查syntastic
		Bundle 'scrooloose/syntastic'
        "安装vim-aitline和主题
        Bundle 'vim-airline/vim-airline'
        Plugin 'vim-airline/vim-ariline-themes'

		filetype plugin indent on
		""""""""""""""""""""" Vundle

		然后编辑完成后在命令行中输入下面指令：
		:source ~/.vimrc
		:BundleInstall
		出现Processing等字样说明在下载，完成后会出现Done！的提示字样
		（可能出现YouCompleteMe 需要编译的问题这是正常的不用管）
	3、安装
		cd ~/.vim/bundle/YouCompleteMe
		install.sh --clang-completer
		完事后看~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py
		(如果不存在：install.py --clang-completer)
		cp ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py ~
		.ycm_extra_conf.py是C++的配置文件
	4、不想每次打开vim都烦人的询问是否加载的话在.vimrc里加入下面的配置
		let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
		"Do not ask when starting vim"
		let g:ycm_confirm_extra_conf = 0
		let g:syntastic_always_populate_loc_list = 1

插件配置：
        "------->>CYM插件的匹配配置<<-------
        " 补全内容不以分割子窗口形式出现，只显示补全列表
        set completeopt-=preview
        " 从第二个键入字符就开始罗列匹配项
        let g:ycm_min_num_of_chars_for_completion=2
        " 语法关键字补全         
        let g:ycm_seed_identifiers_with_syntax=1
        "------->>airline<<---------
        "安装字体补丁 https://github.com/powerline/fonts
        "下载下来后./install.sh, 然后在终端里选上带补丁的字体
        "开启tab状态栏
        let g:airline#extensions#tabline#enabled = 1
        " airline 主题配置              
        let g:airline_theme='papercolor'
        "安装字体补丁后必须加上下面一行
        let g:airline_powerline_fonts = 1
