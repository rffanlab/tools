# encoding:utf8
import requests
import os
from bs4 import BeautifulSoup
# script should install requests beautifulsoup4 lxml first using pip install to install latest

path = "/home/www/downa"
bashdir = "/home/www/downa/bash"
phpdir = "/home/www/downa/php"
pythondir  = "/home/www/downa/python"


headers = {
    "User-Agents":"Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36"
}

def DownloadFile(withUrl,ToFilePath):
    try:
        if os.path.isfile(ToFilePath):
            os.remove(ToFilePath)
        r = requests.get(withUrl,stream=True)
        with open(ToFilePath,"wb") as theFile:
            theFile.write(r.content)
    except Exception as e:
        try:
            if os.path.isfile(ToFilePath):
                os.remove(ToFilePath)
            r = requests.get(withUrl, stream=True)
            with open(ToFilePath, "wb") as theFile:
                theFile.write(r.content)
        except Exception as e:
            print e


def FindLatestPythonVersion():
    # for x in
    urlAndFiles = {
        "win":{},
        "macos":{},
        "source":{}
    }
    try:
        r = requests.get("https://www.python.org/downloads/",headers=headers)
        soup = BeautifulSoup(r.content,"lxml")
        windowns = soup.find("div","download-os-windows")
        macosdowns = soup.find("div","download-os-mac-osx")
        sourceDowns = soup.find("div","download-os-source")
        winUrls = windowns.find_all("a")
        macosUrls = macosdowns.find_all("a")
        sourceUrls = sourceDowns.find_all("a")
        for x in winUrls:
            theUrl = x.get("href")
            fileNameUndealed = theUrl.split("/")
            fileName = fileNameUndealed[(len(fileNameUndealed)-1)]
            urlAndFiles["win"][fileName]=theUrl
        for y in macosUrls:
            theUrl = y.get("href")
            fileNameUndealed = theUrl.split("/")
            fileName = fileNameUndealed[(len(fileNameUndealed)-1)]
            urlAndFiles["macos"][fileName] = theUrl
        for z in sourceUrls:
            theUrl = z.get("href")
            fileNameUndealed = theUrl.split("/")
            fileName = fileNameUndealed[(len(fileNameUndealed)-1)]
            urlAndFiles["source"][fileName] = theUrl
        return urlAndFiles
    except Exception as e:
        try:
            r = requests.get("https://www.python.org/downloads/", headers=headers)
            soup = BeautifulSoup(r.content, "lxml")
            windowns = soup.find("div", "download-os-windows")
            macosdowns = soup.find("div", "download-os-mac-osx")
            sourceDowns = soup.find("div", "download-os-source")
            winUrls = windowns.find_all("a")
            macosUrls = macosdowns.find_all("a")
            sourceUrls = sourceDowns.find_all("a")
            for x in winUrls:
                theUrl = x.get("href")
                fileNameUndealed = theUrl.split("/")
                fileName = fileNameUndealed[(len(fileNameUndealed) - 1)]
                urlAndFiles["win"][fileName] = theUrl
            for y in macosUrls:
                theUrl = y.get("href")
                fileNameUndealed = theUrl.split("/")
                fileName = fileNameUndealed[(len(fileNameUndealed) - 1)]
                urlAndFiles["macos"][fileName] = theUrl
            for z in sourceUrls:
                theUrl = z.get("href")
                fileNameUndealed = theUrl.split("/")
                fileName = fileNameUndealed[(len(fileNameUndealed) - 1)]
                urlAndFiles["source"][fileName] = theUrl
                return urlAndFiles
        except Exception as e:
            print e


def DownloadComposer():
    filePath = os.path.join(phpdir,"composer.phar")
    if os.path.isdir(phpdir):
        composerUrl = "https://getcomposer.org/composer.phar"
        DownloadFile(composerUrl,filePath)
    else:
        os.mkdir(phpdir)

def DownloadPythonFiles():
    pythonVer = FindLatestPythonVersion()
    if not os.path.isdir(pythondir):
        os.mkdir(pythondir)
    for x in pythonVer["win"]:
        print x
        filePathToSave = os.path.join(pythondir,x)
        DownloadFile(pythonVer["win"][x],filePathToSave)

    for x in pythonVer["macos"]:
        print x
        filePathToSave = os.path.join(pythondir,x)
        DownloadFile(pythonVer["macos"][x],filePathToSave)

    for x in pythonVer["source"]:
        print x
        filePathToSave = os.path.join(pythondir,x)
        DownloadFile(pythonVer["source"][x],filePathToSave)



def main():
    DownloadComposer()
    # FindLatestPythonVersion()
    DownloadPythonFiles()

if __name__ == '__main__':
    main()



