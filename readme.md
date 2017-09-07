# 这个工具包里，我会写一下经常使用的配置环境的东西
当然，现在有docker了，我想大家不会使用到这些了预计。不过还是写下来备用


# 关于rlnmp
关于这个工具的叙述：写这个工具的原因是因为，军哥的lnmp在添加SSL之后，如果使用的lnmpa形式的话
将会出现一个问题，如果你访问的是https，你前端nginx加载的资源却会变成http。这是因为nginx和apache之间的数据通信是
http的，所以才会有这个包。
* 增加了proxy-pass-php-ssl.conf 这个文件反代apache的ssl端口，后端apache的SSL端口将会使用8443这个端口作为反代端口
* 使用rlnmp这个Python包来进行操作。
* Python支持版本2.7(2.6未测试，毕竟我现在所有的Python2.7的包)