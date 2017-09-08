#encoding:utf8
# Please keep network good to use following script 请保持网络通畅来使用下面的脚本
import os,platform,tarfile,pip

# 配置区，设置一下配置
headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36"
}

savePath = "."
gopath ="/home/gopath"
usergopath = "/home/ugopath"
profile = "/etc/profile"
gorootsavepath = "/usr/local/"


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

# 安装需要的python 包
pip.main(["install","--upgrade","requests","--quiet"])
pip.main(["install","--upgrade","beautifulsoup4","--quiet"])
pip.main(["install","--upgrade","lxml","--quiet"])

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
    filename = get_filename_from(download_link)
    download(download_link,savePath+"/"+filename)
    extract(savePath+"/"+filename,gorootsavepath)
    with open(profile,"a") as f:
        f.write("export GOROOT=/usr/local/go\n")
        f.write("export GOPATH="+gopath+":"+usergopath+"\n")
        f.write("export PATH=$PATH:$GOROOT/bin:"+gopath+"/bin\n")
    os.popen("source /etc/profile")
#



