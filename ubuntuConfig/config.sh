#!/bin/bash

#该脚本是针对ubuntu(debian)系列的linux安装后的初始化。
#----------以root　身份运行----------#
#安装的软件有:
#		g++; tmux; vim; [gnome ,unity]-tweak-tool; cmake
#		boost; java; 
#
#
#


INSTALL="apt-get install -y"
VIMRC="/home/lele/.vimrc"
TMUXRC="/home/lele/.tmux.conf"
AUTOREMOVE="apt-get autoremove"
#-------------２、安装vim------------>
${INSTALL} vim
#配置vim

if [ -f ${VIMRC} ]
then
	echo "~/.vimrc 已经存在"
else
	cp /etc/vim/vimrc ${VIMRC}
	cat vimConfig >> ${VIMRC}
fi

#------------３、安装g++------------->
${INSTALL} g++

#------------４、安装tmux------------>
${INSTALL} tmux
if [ -f ${TMUXRC} ]
then
	echo "~/.tmux.conf 已经存在"
else
	cp tmuxConfig ${TMUXRC}
fi

#-----------５、主题安装------------->
#(更多主题见：http://www.ubuntuthemes.org,账号：112233880密码：dong123邮箱：dongjiahong@hotmail.com)
#主题选择工具
#unity tool
#${INSTALL} unity-tweak-tool
#gnome tool
${INSTALL} gnome-tweak-tool
#vertex-them主题比较喜欢
add-apt-repository -y ppa:noobslab/themes
apt-get update
${INSTALL} vertex-theme

#----------６、安装cmake------------>
${INSTALL} cmake

#７、
#８、

#移除不需要的安装包
${AUTOREMOVE}
