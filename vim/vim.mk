`这里是我常用的一些vim的配置`

set nu                               
set laststatus=2
set tabstop=4
set softtabstop=4
set shiftwidth=4
set cindent
set autoindent
set nobackup
set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%]


`这下面是vim安装YouCompleteMe插件的方法和配置内容`
需要的软件:
	- vim (尽量新的版本，至少 >= 4.3.7，截至 2013-10-27)
	- git (作为vundle插件的支持 sudo apt-get install git)
	- vim 插件 Vundle （参考：https://github.com/gmarik/vundle）
	- vim 插件 syntastic 与 ListToggle
	- CMake (>=2.8) (为c++项目生成 compile database)(sudo apt-get install cmake)
	- pylint (高级python语法检查支持)
	- python (系统自带的python没有dev：sudo apt-get install python-dev)
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

		Bundle 'Valloric/YouCompleteMe'
		Bundle 'Valloric/ListToggle'
		Bundle 'scrooloose/syntastic'

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

