import subprocess
import requests
import datetime
import schedule
import time

def getUrl():
    with open('url.txt', 'r')as f:
        url = f.read()
    return url


def get_ip(domain):
    res = subprocess.Popen("nslookup {}".format(domain), stdin=subprocess.PIPE, stdout=subprocess.PIPE).communicate()[0]
    response = res.decode("GBK")
    result = []
    # print(response)
    # print("response:%s",response)
    res_list = response.split("s:")
    print(res_list)
    isRight = True
    if len(res_list) == 2:
        isRight = False
    else:
        list_result = res_list[2].split("\r\n")
        isIPV6 = False
        isIPV4 = False
        for i in range(len(list_result)):
            if list_result[i] != '':
                if len(list_result[i].split(':')) != 0:
                    isIPV6 = True
                if len(list_result[i].split('.')) != 0:
                    isIPV4 = True
                result.append(list_result[i].replace('\t', ''))
        print(result)
        print(isIPV4, isIPV6, isRight)
        return isIPV4, isIPV6, isRight


def postInfo(domain):
    domain = domain.replace('\n', '')
    isIPV4, isIPV6, isRight = get_ip(domain)
    s = requests.session()
    url = getUrl()
    data = {"domain": domain, "isIPV4": isIPV4, "isIPV6": isIPV6, "isRight": isRight,
            "time": datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}
    # print(data)
    # s.post("http://localhost:50862/api/info/setHostInfoIP.ashx", data=data)


def task():
    domain = getUrl()
    domains = domain.split(",")
    for i in range(len(domains)):
        if domains[i] != "\n":
            print(domains[i])
            postInfo(domains[i])
if __name__ == "__main__":
    schedule.every().day.at("10:30").do(task)
    while True:
        schedule.run_pending()

    # get_ip("www.ouc.edu.cn")
    # get_ip("www.baidu.com")
