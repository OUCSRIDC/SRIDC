import subprocess
def get_ip(domain):
    res = subprocess.Popen("nslookup {}".format(domain), stdin=subprocess.PIPE, stdout=subprocess.PIPE).communicate()[0]
    response = res.decode("GBK")
    result = []
    # print(response)
    # print("response:%s",response)
    res_list = response.split("s:")
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


if __name__ == "__main__":
    get_ip("www.ouc.edu.cn")
    # get_ip("www.baidu.com")