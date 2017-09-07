#encoding:utf8
#
import os,platform

# 配置区，设置一下配置
headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36"
}

savePath = ""




# 检查Python版本
version = platform.python_version()
strs = version.split(".")
if strs[0] == str(2):
    if int(strs[1]) < 7:
        exit("Python 2 Version Must use Python 2.7")

osinfo = platform.architecture()

print(osinfo)

downtype = ""
if "windows" in osinfo[1].lower():
    downtype = "windows"
elif "elf" in osinfo[1].lower():
    downtype = "linux"
print(downtype)
if osinfo[0] == "32bit":
    downtype = downtype+"-386"
elif osinfo[0] == "64bit":
    downtype = downtype+"-amd64"


print(downtype)




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
    print("Package "+package_name+" Installed")

# 安装了需要的包，包括了requests,beautifulsoup4,lxml
check_install_package("requests")
check_install_package("beautifulsoup4")
check_install_package("lxml")

import requests
from bs4 import BeautifulSoup
def download(url,save):
    s = requests.session()
    r = s.get(url,headers = {"User-Agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36"},verify=False)
    with open(save,"wb") as f:
        f.write(r.content)

def detect_page_charset(pageContent):
    soup = BeautifulSoup(pageContent, "lxml")
    charset = soup.find("meta", attrs={"http-equiv": "Content-Type"})
    if charset:
        attr = charset.get("content")
        theCharset = attr.split(";")[1].replace(" ", "").split("=")[1]
        return theCharset


def get_remote_content(url):
    s = requests.session()
    r = s.get(url,headers=headers,verify=False)
    return r.content.decode(detect_page_charset(r.content))


def get_filename_from(url):
    strs = url.split("/")
    return strs[len(strs)-1]



if __name__ == '__main__':
    download_link = ""
    if "" in osinfo[1].lower():
        pass
    r = get_remote_content("https://golang.org/dl/")
    soup = BeautifulSoup(r,"lxml")
    latest_version = soup.find("div","toggleVisible")
    all_links = latest_version.find_all("a")
    for x in all_links:
        if downtype in x.get_text().lower():
            download_link = x.get("href")
        print(x)
    print(download_link)
    filename = get_filename_from(download_link)
    download(download_link,"./"+filename)
    os.popen("tar zxvf "+filename)
    print os.path.isdir("go")




