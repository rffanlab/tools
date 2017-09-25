#encoding:utf8
# 这个脚本是为了能够独立部署Lnmpa包而写的。
# 写这个包的目的是为了替代军哥的LNMP包。
# 军哥的包的SSL存在着在lnmpa的时候饭袋出现问题。


def SetupBackupMySQLAccount():
    pass


class InstallLNMP():
    def __init__(self):
        pass




class InstallLNMPA():
    def __init__(self):
        pass


class InstallLAMP():
    def __init__(self):
        pass





if __name__ == '__main__':
    install_option = raw_input("请确定你要安装的包：lnmp/lnmpa/lamp(大小写不敏感)")
    the_option = install_option.lower()
    if the_option == "lnmp":
        pass
    elif the_option == "lnmpa":
        pass
    elif the_option == "lamp":
        pass
    else:
        exit("只有三个选项:lnmp、lnmpa、lamp 请重新运行")