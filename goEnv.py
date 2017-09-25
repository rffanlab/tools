#encoding:utf8
# Please keep network good to use following script 请保持网络通畅来使用下面的脚本
import os,platform,tarfile

# 为防止新装系统没有安装pip 我们这里用yum来安装easy_install 然后通过easy_install pip 来安装pip
os.popen("yum install -y python-setuptools")
os.popen("easy_install pip")

import pip

# 配置区，设置一下配置
headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36"
}

savePath = "."                        # go压缩包的保存目录
gopath ="/home/gopath"                # gopath目录用来保存从外网下载或者更新的go包
usergopath = "/home/ugopath"          # 保存自己写的go包
profile = "/etc/profile"              # 系统环境配置文件
gorootsavepath = "/usr/local/"        # go压缩包解压的目标目录


# 检查Python版本
version = platform.python_version()
strs = version.split(".")
if strs[0] == str(2):
    if int(strs[1]) < 7:
        exit("Python 2 Version Must use Python 2.7")
osinfo = platform.architecture()
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

# 安装需要的python 包
pip.main(["install","--upgrade","requests","--quiet"])
pip.main(["install","--upgrade","beautifulsoup4","--quiet"])
pip.main(["install","--upgrade","lxml","--quiet"])

import requests
from bs4 import BeautifulSoup

# 下载文件
def download(url,save):
    s = requests.session()
    r = s.get(url,headers = {"User-Agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36"},verify=False)
    with open(save,"wb") as f:
        f.write(r.content)


# 检查网页编码 没有完善
def detect_page_charset(pageContent):
    soup = BeautifulSoup(pageContent, "lxml")
    charset = soup.find("meta", attrs={"http-equiv": "Content-Type"})
    if charset:
        attr = charset.get("content")
        theCharset = attr.split(";")[1].replace(" ", "").split("=")[1]
        return theCharset


# 获取网页内容
def get_remote_content(url):
    s = requests.session()
    r = s.get(url,headers=headers,verify=False)
    return r.content.decode(detect_page_charset(r.content))


# 从url中获取文件名，这个方法比较简陋，请见谅
def get_filename_from(url):
    strs = url.split("/")
    return strs[len(strs)-1]


# 解压.tar.gz包
def extract(filepath,tofilepath="./"):
    with tarfile.open(filepath,"r:gz") as tar:
        tar.extractall(tofilepath)


if __name__ == '__main__':
    download_link = ""
    r = get_remote_content("https://golang.org/dl/")
    soup = BeautifulSoup(r,"lxml")
    latest_version = soup.find("div","toggleVisible")
    all_links = latest_version.find_all("a")
    for x in all_links:
        if downtype in x.get_text().lower():
            download_link = x.get("href")
    print(download_link)
    # 下载最新的go安装包，并解压
    filename = get_filename_from(download_link)
    download(download_link,savePath+"/"+filename)
    extract(savePath+"/"+filename,gorootsavepath)
    # 开始在系统环境追加go环境配置
    with open(profile,"a") as f:
        f.write("export GOROOT=/usr/local/go\n")
        f.write("export GOPATH="+gopath+":"+usergopath+"\n")
        f.write("export PATH=$PATH:$GOROOT/bin:"+gopath+"/bin\n")
    os.popen("mkdir "+gopath)
    os.popen("mkdir "+usergopath)
    os.popen("mkdir "+usergopath+"/src")
    os.popen("source /etc/profile")
#



