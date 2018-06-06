import requests
import function
import datetime


def login():
    s = requests.session()
    url = "http://localhost:49890/Ajax/login.ashx"
    data = {'username': 'test', 'password': 'test', 'code': '1234'}
    r = s.post(url, data=data)
    print(r.text)
    url = "http://localhost:49890/Ajax/setHostInfo.ashx"
    data = {'username': 'test', 'ip': '10.132.133.130', 'name': 'test'}
    r = s.post(url, data=data)
    print(r.text)


def setHostInfo():
    s = requests.session()
    url = "http://localhost:49890/Ajax/setHostInfo.ashx"
    data = {'username': 'test', 'ip': '10.132.133.130', 'name': 'test'}
    r = s.post(url, data=data)
    print(r.text)
    # requests.post(url,data=data)


login()
# setHostInfo()