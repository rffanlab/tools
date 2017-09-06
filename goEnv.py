#encoding:utf8
#
import os,platform

# 检查Python版本
version = platform.python_version()
strs = version.split(".")
if strs[0] == str(2):
    if int(strs[1]) < 7:
        exit("Python 2 Version Must use Python 2.7")

osinfo = platform.architecture()
print(osinfo[0])

# 定义了检查已安装包的方法，用以检测是否安装了某个包，如未安装，则安装它
#TODO 还没完善
def check_install_package(package_name):
    has_package = False
    piplist = os.popen("pip list --format=columns").readlines()
    for x in piplist:
        if package_name in x:
            has_package = True
            break
    if not has_package:
        print("Package:"+package_name+" not Installed.Installing it now")
        os.popen("pip install "+package_name)

# 安装了需要的包，包括了requests,beautifulsoup4,lxml
check_install_package("requests")
check_install_package("beautifulsoup4")
check_install_package("lxml")

import requests
def download(url,save):
    s = requests.session()
    r = s.get(url,headers = {"User-Agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36"})
    with open(save,"wb") as f:
        f.write(r.content)





