## GnuMakeManual
### 1.简介
GnuMake 需要一个文档被命名为`makefile`、`Makefile`等。这里推荐使用`Makefile`，其主要规则：
```make
target1: target2
	command
target2: prerequiries
	command
...
```
就是你的编译`目标`回去寻找`依赖`,而`依赖`也可以是`目标`，然后是执行的命令，这里需要一个`tab`的分隔
当然可以编写多个`target` 但是只有第一个目标被认为是默认目标，也就是你执行`make`后面不跟目标所执行的
那个目标。通常将第一个目标定位编译全部目标一般命名为`all`

### 2.使用变量 
在make中我们可以使用变量来简化书写，常用的变量语法如下：
```make
VPATH = src:../headers

variable = deferred
variable ?= deferred
variable := deferred
variable += deferred or variable

define variable
	deferred
endef
```

make变量`VPATH`的值指定了make搜索的目录，经常是那些包含依赖的目录，可以指定多个目录用冒号分隔`:`
```make
VPATH = src:../headers
foo:foo.c
```
make会现在本目录找`foo.c`如果没哟找到会去`src`和`../headers`目录去寻找
当然还有另一个小写的`vpath`这个和大写的指令功能类似，但是更加的灵活，`vpath`一共有三种形式的
```make
#vpath pattern directories
vpath %.h ../headers
# 1.对一定格式类型的问价指定一个搜索路径，搜索路径由一列要搜寻的目标构成，他们用冒号分隔,而pattern
#是一个包含一个'$'的字符串。上面表示在../headers目录中寻找所有的.h文件
vpath pattern
# 2.清除和一定类型格式相关联的搜索路径
vpath
# 3.清除所有前面由vpath指定的搜索路径
# example:
vpath %.c foo/
vpath % blish
vpath %.c bar
#上面表示先搜索.c文件在目录foo;然后在目录blish;最后在bar
```

三个神奇的自动变量:

```make
foo:a b c
	$@ $^ $<
a:
	@echo  a
b:
	@echo b
#上面的$@表示make指令时后面跟的目标，
#$^表示依赖列表就是a b c，
#$<表示依赖列表的第一个依赖就是a
```

### 3.指令

make中有不少自带的指令，下面将会对一些常用的指令进行说明
##### 3.1指令include
`include` 指令告诉make暂停当前的makefile文档，先去读取`include`指令指定的makefile文档。该指令单独占
一行，其格式如下：
```make
include filename1 filename2 *.mk
```
上面表示需要包含`filename1`、`filename2`和所有以`.mk`结尾的文件

### 4.通用的匹配符

一个小例子
```make
object = *.o

foo:$(object)
	rm -f $(object)
%:
	touch $@
```
通配符`%`，它可以和任何目标匹配，也就是说如果你执行了`make bar'`而这个`bar`目标并没有被定
义这时将会被`%`给匹配，所以将会执行下面的指令`touch $@`而这个`$@`就是输入中你的target,这里是`bar`

通配符`*`，这里表示所有的`.o`文件在make里使用`$()`来获取变量里的内容

### 5.函数

### 6.小知识点
#### 6.1连接库的搜索目录
当一个依赖的名字是`-lname`的形式时，make特别的在：
* 当前目录下
* vpath目录下
* VPATH目录下
* 以及`/lib`、`/usr/lib`、`prefix/lib`一般prefix为`/usr/local/lib`
中依次去寻找名字为`libname.so`的文件，如果没有找到会寻找`libname.a`文件
