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
git config --global user.name "懂家宏"
git config --global user.email "dongjiahong@hotmail.com"
git config --global color.diff auto # git diff 要顯示顏色
git config --global color.status auto # git status 要顯示顏色
git config --global color.branch auto
```

git的常用指令
------------

