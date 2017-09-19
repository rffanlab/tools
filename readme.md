# 这个工具包里，我会写一下经常使用的配置环境的东西
当然，现在有docker了，我想大家不会使用到这些了预计。不过还是写下来备用

# 关于goEnv的介绍
### 作用
该脚本是用来在CentOS下部署go环境用的.
### 测试
测试环境为CentOS 7 系统默认自带的Python 已安装了pip脚本
### 会额外安装的包
request,beautifulsoup4,lxml
### 报错
如果python版本低于2.7将会报错，因此建议使用我的脚本安装python2.7，并使用python2.7奔跑。可以使用installpy27.sh 这个安装python27



# 关于installpy27的介绍
### 作用
* 该脚本用于独立安装python2.7.13到系统，并添加python解析器到系统环境，名字为python27。
* 为python2.7安装pip并添加到系统环境名字为pip27

### 支持系统
目前仅仅写了centos系列（debian系列的小伙伴，请自行修改相关脚本）
### 测试
* CentOS 7   PASS
* CentOS 6   PASS
* CentOS 5   Untested

### 报错
目前脚本运行之后需要自行运行"source /etc/profile" 来让环境变量生效。目前测试中还未出现报错，如果有报错，请及时告知




# 关于rlnmp（未完成）
关于这个工具的叙述：写这个工具的原因是因为，军哥的lnmp在添加SSL之后，如果使用的lnmpa形式的话
将会出现一个问题，如果你访问的是https，你前端nginx加载的资源却会变成http。这是因为nginx和apache之间的数据通信是
http的，所以才会有这个包。
* 增加了proxy-pass-php-ssl.conf 这个文件反代apache的ssl端口，后端apache的SSL端口将会使用8443这个端口作为反代端口
* 使用rlnmp这个Python包来进行操作。
* Python支持版本2.7(2.6未测试，毕竟我现在所有的Python2.7的包)