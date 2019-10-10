import requests
from bs4 import BeautifulSoup
import os
import csv
import random
from fake_useragent import UserAgent
import json as js
import time


#  http://comment.sina.com.cn/page/info?version=1&format=json&channel=gn&newsid=comos-hvhiews6189444
def get_comment():
    # 爬取数量预设
    # headers = {'User-Agent': 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Mobile Safari/537.36'}
    if not os.path.exists("./news_comment"):
        os.makedirs("./news_comment")
    # 设置Proxy与UserAgent
    checked_proxies = list()
    fr_ip = open('ip_proxy_original.txt', 'r')
    ips = fr_ip.readlines()
    fr_ip.close()
    for p in ips:
        ip = p.strip('\n').split(',')
        proxy = {ip[2]: ip[2] + '://' + ip[0] + ':' + ip[1]}
        checked_proxies.append(proxy)
    ua = UserAgent()
    # 反爬睡眠设置
    failed_request = 0
    failed_extract = 0
    # 开始爬取
    for filename in os.listdir(r'./news_source'):
        # 获取新闻信息
        fr_news = open("./news_source/" + filename, 'r', encoding='UTF-8')
        reader = csv.DictReader(fr_news)
        fw = open("./news_comment/" + filename, "w", encoding='UTF-8', newline='')
        writer = csv.writer(fw)
        writer.writerow(["new_type", "news_id", "comment", "comment_loc"])
        for news in reader:
            news_type = news['news_type']
            news_id = news['news_id']
            url = 'http://comment.sina.com.cn/page/info?version=1&format=json&channel=' + news_type + '&newsid=' + news_id
            # 发送get请求
            headers = {'User-Agent': ua.random}
            try:
                res = requests.get(url, headers=headers, proxies=random.choice(checked_proxies), timeout=10)
            except Exception as e:
                failed_request = failed_request + 1
                if failed_request % 3 == 0:
                    time.sleep(5)
                print("CommentCollector:UrlRequest:" + str(e))
            else:
                try:
                    soup = BeautifulSoup(res.content, 'lxml')
                    news_json = js.loads(soup.text)
                    for item in news_json['result']['cmntlist']:
                        news_content = item['content'].replace('\n', '').replace('\r', '')
                        writer.writerow([
                            news_type,
                            news_id,
                            news_content,
                            item['area']
                        ])
                except Exception as e:
                    if failed_extract % 3 == 0:
                        time.sleep(5)
                    print("CommentCollector:InfoExtraction:" + str(e))
                    time.sleep(1)
                    try:
                        print("CommentCollector:InfoExtraction:Exception:Retry For Once!" )
                        res_retry = requests.get(url, headers=headers, proxies=random.choice(checked_proxies), timeout=10)
                        soup = BeautifulSoup(res_retry.content, 'lxml')
                        news_json = js.loads(soup.text)
                        for item in news_json['result']['cmntlist']:
                            news_content = item['content'].replace('\n', '').replace('\r', '')
                            writer.writerow([
                                news_type,
                                news_id,
                                news_content,
                                item['area']
                            ])
                    except Exception as e:
                        print("CommentCollector:InfoExtraction:Exception:Retry Failed!" + str(e))
                    else:
                        print("CommentCollector:InfoExtraction:Exception:Retry Succeeded!")
                else:
                    print("CommentCollector:CsvWriter:This News's Comment Got!")
        fr_news.close()
        fw.close()
    print("Comment Collecting Finished!")
