import requests
from bs4 import BeautifulSoup
import time


def get_ip():
    # ua = UserAgent()
    # headers = {'User-Agent': ua.random}
    headers = {
        'User-Agent': 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Mobile Safari/537.36'}
    # , proxies = {'HTTP': 'HTTP://113.58.234.218:22'}
    url = 'https://www.xicidaili.com/nn/1'
    try:
        res = requests.get(url, timeout=5, headers=headers)
    except Exception as e:
        print("IpCollector:get_ip:UrlRequest:" + str(e))
        print("IpCollector:get_ip:UrlRequest:Restart Get Ip!")
        time.sleep(3)
        get_ip()
    else:
        soup = BeautifulSoup(res.text, 'lxml')
        ips = soup.select('#ip_list tr')
        f = open('ip_proxy_original.txt', 'w')
        for i in ips:
            try:
                ipp = i.select('td')
                ip = ipp[1].text
                host = ipp[2].text
                type = ipp[5].text
                f.write(ip + ',' + host + ',' + type + '\n')
                print("IpCollector:get_ip:this ip succeeded")
            except Exception as e:
                print("IpCollector:get_ip:InfoExtraction:" + str(e))
        f.close()
    print("IpCollector:get_ip:finished!")


def check_ip():
    url = 'https://www.baidu.com'
    fr = open('ip_proxy_original.txt', 'r')
    ips = fr.readlines()
    fr.close()
    fw = open('ip_proxy_checked.txt', 'w')
    for p in ips:
        ip = p.strip('\n').split(',')
        proxy = {ip[2]: ip[2] + '://' + ip[0] + ':' + ip[1]}
        try:
            res = requests.get(url, proxies=proxy, timeout=3)
        except Exception as e:
            print("IpCollector:check_ip:this ip failed!" + str(e))
        else:
            if res.status_code == 200:
                print("IpCollector:check_ip:this ip succeeded!")
                fw.write(p)
    fw.close()
    print("IpCollector:check_ip:finished!")


if __name__ == "__main__":
    get_ip()
    check_ip()
