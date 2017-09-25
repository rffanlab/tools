#encoding:utf8
# Written by Rffanlab.Welcome to visit rffanlab.com.
# This file is written for patch lnmp.To Enable Let's Encrypt SSL with lnmpa without http error
# 这个文件是为了替代lnmpa 安装包下的访问SSL链接的时候加载的资源是http的格式的。
import os,sys




class lnmp():
    def __init__(self):
        # lnmp lnmpa lamp
        self.type = ""

    # 检测是lnmp还是lamp，还是lnmpa
    def dete_type(self):
        nginx = False
        apache = False
        lines = os.popen("ps aux|grep nginx|grep -v grep").readlines()
        for x in lines:
            if "nginx" in x:
                nginx = True
        lines2 = os.popen("ps aux|grep httpd|grep -v grep").readlines()
        for y in lines2:
            if "httpd" in y:
                apache = True
        if not os.path.isdir("/usr/local/nginx"):
            nginx = False
        if not os.path.isdir("/usr/local/apache"):
            apache = False
        if nginx and not apache:
            self.type = "lnmp"
        elif nginx and apache:
            self.type = "lnmpa"
        elif not nginx and apache:
            self.type = "lamp"
        print(self.type)


    def start_lnmp(self):
        pass

    def stop_lnmp(self):
        pass

    def restart_lnmp(self):
        pass

    def reload_lnmp(self):
        pass

    def kill_lnmp(self):
        pass

    def status_lnmp(self):
        pass

    def mysql_lnmp(self):
        pass

    def mariadb_lnmp(self):
        pass

    def pureftp_lnmp(self):
        pass

    def httpd_lnmp(self):
        pass

    def vhost_lnmp(self):
        domain = raw_input("请输入你的域名")
        addtional_domain = raw_input("请输入你的附加域名，没有请回车跳过")
        print("请输入目录默认目录为:/home/www/"+domain)
        directory = raw_input("请输入：")
        allowaccesslog = raw_input("要开启日志访问？默认不开启(Y/N)")
        email = raw_input("请输入email用于apache配置：")
        ssl_option = raw_input("是否添加SSL(Y/N)")
        pass

    def db_lnmp(self):
        pass

    def ftp_lnmp(self):
        pass

    def ssl_lnmp(self):
        pass

if __name__ == '__main__':
    lnmp = lnmp()
    lnmp.dete_type()
    args = sys.argv
    arg1 = ""
    arg2 = ""
    if len(args)>1:
        arg1 = args[1]
        if len(args)>2:
            arg2 = args[2]
    else:
        print("""
命令错误，请参照下面命令来使用
命令使用：
使用: lnmp {start|stop|reload|restart|kill|status}
使用: lnmp {nginx|mysql|mariadb|pureftpd|httpd} {start|stop|reload|restart|kill|status}
使用: lnmp vhost {add|list|del}
使用: lnmp database {add|list|edit|del}
使用: lnmp ftp {add|list|edit|del|show}
使用: lnmp ssl add 
""")
        exit()
    if arg1 == "start":
        lnmp.start_lnmp()
    elif arg1 == "stop":
        lnmp.stop_lnmp()
    elif arg1 == "restart":
        lnmp.restart_lnmp()
    elif arg1 == "reload":
        lnmp.reload_lnmp()
    elif arg1 == "kill":
        lnmp.kill_lnmp()
    elif arg1 == "status":
        lnmp.start_lnmp()
    elif arg1 == "mysql":
        lnmp.mysql_lnmp()
    elif arg1 == "mariadb":
        lnmp.mariadb_lnmp()
    elif arg1 == "pureftpd":
        lnmp.pureftp_lnmp()
    elif arg1 == "httpd":
        lnmp.httpd_lnmp()
    elif arg1 == "vhost":
        lnmp.vhost_lnmp()
    elif arg1 == "database":
        lnmp.db_lnmp()
    elif arg1 == "ftp":
        lnmp.ftp_lnmp()
    elif arg1 == "ssl":
        pass
    else:
        print("""
命令错误，请参照下面命令来使用
命令使用：
使用: lnmp {start|stop|reload|restart|kill|status}
使用: lnmp {nginx|mysql|mariadb|pureftpd|httpd} {start|stop|reload|restart|kill|status}
使用: lnmp vhost {add|list|del}
使用: lnmp database {add|list|edit|del}
使用: lnmp ftp {add|list|edit|del|show}
使用: lnmp ssl add
        """)







