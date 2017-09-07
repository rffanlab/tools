#encoding:utf8
# Written by Rffanlab.Welcome to visit rffanlab.com.
# This file is written for patch lnmp.To Enable Let's Encrypt SSL with lnmpa without http error
# 这个文件是为了替代lnmpa 安装包下的访问SSL链接的时候加载的资源是http的格式的。
import os,sys




class lnmp():
    def __init__(self):
        pass

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
        pass

    def db_lnmp(self):
        pass

    def ftp_lnmp(self):
        pass

    def ssl_lnmp(self):
        pass

if __name__ == '__main__':
    lnmp = lnmp()
    arg1 = sys.argv[1]
    arg2 = sys.argv[2]
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
命令使用：
        使用: lnmp {start|stop|reload|restart|kill|status}
        使用: lnmp {nginx|mysql|mariadb|pureftpd|httpd} {start|stop|reload|restart|kill|status}
        使用: lnmp vhost {add|list|del}
        使用: lnmp database {add|list|edit|del}
        使用: lnmp ftp {add|list|edit|del|show}
        使用: lnmp ssl add" 
        
        
        """)







