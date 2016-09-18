### TFS的HA部署

#### 安装heartbeat

参考文档：[tfs_ha部署](http://www.docin.com/p-534458301.html)
安装heartbeat我们需要执行`yum install heartbeat`但是可能得到的是`No package heartbeat available.` 这时我们需要如下指令：
```sh
# wget http://mirrors.sohu.com/fedora-epel/6/i386/epel-release-6-8.noarch.rpm
# rpm -ivh epel-release-6-8.noarch.rpm

# 执行上面的指令后我们在次安装就好了，这里安装的是3.0版本
# yum install heartbeat
```

