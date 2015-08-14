							`这里是Centos 6.5的使用笔记`
			`在使用centos中遇到问题可以去centos的wiki里找答案url:http://wiki.centos.org/zh/`

1、搜索软件源里是否有那些软件
	yum search xxx       ---------这里的xxx就是你要搜索的软件名字（需要root权限）
	yum install xxx      ---------这里的xxx是你将要安装的软件，也可以加 -y 选项（在所有的询问里都使用yes）
2、一般用户是不能使用sudo命令的需要你将用户加入/etc/sudoers文件里在
	"root  ALL=(ALL)    ALL"下面添加"le 	ALL=(ALL)	ALL"
3、一般默认centos6安装后不能启动windows，这是因为Centos6把grub菜单给隐藏了，我们需要编辑/etc/grub.conf里的hiddenmenu这句话给注释掉





