import subprocess
import requests
import datetime


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
        print(isIPV4, isIPV6)
        return isIPV4, isIPV6, isRight


def postInfo(domain):
    isIPV4, isIPV6, isRight = get_ip(domain)
    s = requests.session()
    url = getUrl()
    data = {"ip": domain, "isIPV4": isIPV4, "isIPV6": isIPV6, "isRight": isRight,
            "time": datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}
    s.post("http://localhost:49890/Ajax/setHostInfoIP.ashx", data=data)


if __name__ == "__main__":
    domain = getUrl()
    domains = domain.split(",")
    for i in range(len(domains)):
        print(domains[i])
        postInfo(domains[i])

    # get_ip("www.ouc.edu.cn")
    # get_ip("www.baidu.com")
