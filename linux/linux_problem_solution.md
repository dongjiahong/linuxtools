Linux日常运维日志
----

### yum指令
如果你执行`yum search **` 时发现 **Segmentation fault** 这一般是你自己编译了`libz.so`这个包造成的，这里一般清理缓存就好，执行`yum clean all`如果还是不行那么需要你重新将`libz.so`的包链接会久版本.

### libc.so问题
这里一个很关键的包缺少这个包会导致几乎所有的指令都不能用了，这时你需要将软连接给链会去就好，执行如下：
```shell
#LD_PRELOAD=/lib/libc-2.6.1.so ln -s /lib/libc-2.6.1.so libc.so.6
```
还有一个问题是，一但你修改了这个libc.so.6的软链，yum就不能用了，就想上面的问题，可以使用`yum clean all` 解决，但是这样`libc.so.6`的软链将会被修改回去


