import requests
import function
import datetime

def getUrl():
    with open('url.txt', 'r')as f:
        url = f.read()
    return url

def postInfo():
    s = requests.session()
    url = getUrl()
    data = {"host_id": function.ipInfo(), "osInfo": function.osInfo(), "diskInfo": function.diskInfo(),
            "memoryInfo": function.memInfo(), "cpuInfo": function.cpuInfo(), "portInfo": function.portInfo(),
            "time": datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}
    s.post("http://localhost:49890/Ajax/setHardwareInfo.ashx", data=data)


def main():
    postInfo()
    # print(function.ipInfo())

if __name__ == '__main__':
    main()