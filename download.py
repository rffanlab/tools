import platform,os


# 下载，然后安装pip


py_version = platform.python_version()
py_v_strs = py_version.split(".")


def install_pip():
    urlretrieve("https://downa.win/python/get-pip.py", "get-pip.py")
    os.popen("python get-pip.py setup")


if py_v_strs[0] == str(2):
    from urllib import urlretrieve
    install_pip()
else:
    from urllib.request import urlretrieve
    install_pip()

