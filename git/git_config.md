git简介
-------

>>> Git是一款免费、开源的分布式版本控制系统，用于敏捷高效地处理任何或小或大的项目.

安装
----

```sh
# debian || ubuntu
sudo aptitude install git
# red hat || centos
sudo yum install git
```

git的公钥
--------

```sh
ssh-keygen -t rsa -C "dongjiahong@hotmail.com"
#接着三个回车
cat ~/.ssh/id_rsa.pub
```

日常git的常用配置
-----------------

```sh
git config --global user.name "董家宏"
git config --global user.email "dongjiahong@hotmail.com"
git config --global color.diff auto # git diff 要顯示顏色
git config --global color.status auto # git status 要顯示顏色
git config --global color.branch auto
```

git的常用指令
------------
```sh
# 将误加入版本库的文件给删除，但是在本地还是保留 这里要加--cache
git rm --cache <file>
# 将工作区文件保存在git的内部栈中
git stash
# 列出git内部栈中保存的工作区文件列表
git stash list
# 恢复工作区到指定的内部栈状态
git stash apply stash_id
# 恢复工作区到上一个内部栈状态
git stash pop
# 清空git内部栈
git stash clear
# push推送指令 
git push <远程仓库> <本地分支>:<远程分支>
# pull拉取指令
git pull <远程仓库> <远程分支>:<本地分支>
```
