## 安装淘宝的tfs

* [TFS源码](https://github.com/alibaba/tfs)
* [TFSwiki](http://code.taobao.org/p/tfs/wiki/index/)

### 1.环境

* os:centos 6.8
* gcc:gcc 4.4
* 

### 2.安装步骤

*所有的安装的都是在root用户下进行的*

#### 1.官方的[安装教程](https://github.com/alibaba/tfs/blob/master/INSTALL.md) 根据官方教程我们需要安装如下软件：

```sh
# 1.自动构建工具
yum install automake.noarch
# 2.需要使用的libtool库
yum install libtool.x86_64
# 3.用于命令行编辑的库
yum install readline-devel.x86_64
# 4.用于数据压缩和解压的库
yum install zlib-devel.x86_64
# 5.用于生成全局唯一ID的库
yum install e2fsprogs-devel.x86_64
# 6.使用tcmalloc google的内存管理库（源里没有）
yum install google-perftools.x86_64
```

上面是准备工作，其中`第5步` 和 `第6步` 会有些问题.第五步如果只是安装`e2fsprogs-devel.x86_64` 的话在编译时会报错`uuid/uuid.h no file` 所以需要安装下面这个库：
```sh
yum install libuuid-devel
```

第6步的问题是源里没有找到`google-perftools.x86_64` 这个软件，而去下载的话又需要翻墙，这里提供百度网盘的链接[google-perftools](https://pan.baidu.com/s/1sl7uUdf) 下载完成后按照如下方式安装：

```sh
./configure  --enable-frame-pointers  
make &&  make install  
echo "/usr/local/lib" > /etc/ld.so.conf.d/usr_local_lib.conf 
ldconfig 
```

#### 2.安装淘宝的工具库tb-common-utils

```sh
# 新建一个目录并下载源码，这里需要下载的版本是18
svn co -r 18 http://code.taobao.org/svn/tb-common-utils/trunk tb-common-utils
# 设置环境变量TBLIB_ROOT，我是在root用户下想给所有人用所以在/etc/profile里添加
export TBLIB_ROOT=/usr/local/tb/tbtools
source /etc/profile
# 编译并安装tb-common-utils
cd tb-common-utils
bash build.sh
# 在/usr/local/tb/tbtools目录下看到include、lib两个目录说明安装完成
```

#### 3.安装TFS

下载[源码tfs](https://codeload.github.com/alibaba/tfs/zip/master)

```sh
cd tfs-master
bash build.sh init
./configure --prefix=/usr/local/tb/tfs --with-release
make
make install
```

不出意外的换上面的步骤能够成功的安装TFS，那么你在安装目录`/usr/local/tb/tfs` 中应该出现下面几个子目录：
* bin：包含tfs所有的可执行程序文件，如nameserver(NS)、dataserver(DS)、tfstool。
* conf：包含tfs的配置文件，如NS的配置文件ns.conf，DS的配置文件ds.conf,一开始里面是空的将源码里的conf 拷贝过来就好。
* include：包含TFS客户端库相关的头文件，应用程序使用TFS需要包含这些头文件。
* lib： 包含TFS客户端的静/动态库，应用程序使用TFS需要连接libtfsclient。
* logs：用于存储TFS运行过程中的日志。
* script：包含tfs常用的一些运维脚本，如stfs用于格式化DS， tfs启动/停止NS、DS。

### 4.部署TFS

部署TFS可以参考[单机部署TFS](http://blog.chinaunix.net/uid-30047365-id-4669845.html)

部署TFS主要需要注意的是修改`ns.conf` 和`ds.conf` 这两个文件他们分别是nameserver和dataserver两个服务的配置文件.这两个文件的修改可以参考TFS的wiki。配置里有些需要注意的地方在wiki里都有说明.

由于在`ds.conf` 文件中一配置为`mount_name = /home/lele/tfs/disk` 这里直接的指出了数据存储的目录，为了能正常的使用这个数据存储点我们需要执行下面的命令:

```sh
cd /usr/local/tb/tfs/scripts
./stfs format 1				#格式化/home/lele/tfs/disk
./tfs start_ns				#启动nameserver
./tfs start_ds 1			#启动dataserver
```

#### 上传和下载文件

这里我们使用`/usr/local/tb/tfs/bin` 目录下的`tfstool` 工具来上传文件
```sh
cd /usr/local/tb/tfs/bin
./tfstool -s 192.168.1.127:8108 -i "put filename"
```

然后我们会发现上传后会返回`blockid` 和`fileid` 并返回*T* 开头的文件名；同样下载我们也可以使用`tfstool` 工具

```sh
cd /usr/local/tb/tfs/bin
./tfstool -s 192.168.1.127:8101 -i "get T** file"
```

我们可以将文件获取下来名字为`file` 然后我通过`md5sum` 指令可以看出上传和下载的两个文件的md5指是一样的。

### 5.安装nginx-tfs

>>> 这个模块实现了TFS的客户端，为TFS提供了RESTful API. 

#### 安装编译

```sh
#TFS模块使用了一个开源JSON库来支持JSON,需要安装[yajl](https://codeload.github.com/lloyd/yajl/legacy.tar.gz/2.1.0)
cd yajl
./config --prefix=/usr/local/yajl
make
make install

#下载[nginx](nginx.org)
cd nginx
./configure --add-module=/path/nginx-tfs
make
make install
```

下面是nginx的配置具体可以参考[文档](https://github.com/alibaba/nginx-tfs)

```sh
#nginx配置示例
http {
    tfs_upstream tfs_rc {
        server 127.0.0.1:6100;
        type rcs;
        rcs_zone name=tfs1 size=128M;
        rcs_interface eth0;
        rcs_heartbeat lock_file=/logs/lk.file interval=10s;
    }

    server {
          listen       7500;
          server_name  localhost;

          tfs_keepalive max_cached=100 bucket_count=10;
          tfs_log "pipe:/usr/sbin/cronolog -p 30min /path/to/nginx/logs/cronolog/%Y/%m/%Y-%m-%d-%H-%M-tfs_access.log";

          location / {
              tfs_pass tfs://tfs_rc;
          }
    }
}
```

