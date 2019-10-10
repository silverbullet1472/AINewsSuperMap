import requests
import json as js
import os
import csv
import random
from fake_useragent import UserAgent
import time


# http://top.news.sina.com.cn/ws/GetTopDataList.php?top_type=day&top_cat=gnxwpl&top_time=20190601&top_show_num=10&top_order=DESC
def get_source():
    # 爬取数量预设
    # headers = {'User-Agent': 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Mobile Safari/537.36'}
    if not os.path.exists("./news_source"):
        os.makedirs("./news_source")
    news_time = 20190000
    news_num = 60
    failed_request = 0
    failed_extract = 0
    # 设置Proxy与UserAgent
    checked_proxies = list()
    fr = open('ip_proxy_original.txt', 'r')
    ips = fr.readlines()
    fr.close()
    for p in ips:
        ip = p.strip('\n').split(',')
        proxy = {ip[2]: ip[2] + '://' + ip[0] + ':' + ip[1]}
        checked_proxies.append(proxy)
    ua = UserAgent()
    # 开始爬取
    for i in range(0, 6):
        news_time = news_time + 100
        for k in range(0, 28):
            # 请求地址
            news_time = news_time + 1
            url = "http://top.news.sina.com.cn/ws/GetTopDataList.php?\
                   top_type=day&top_cat=gnxwpl&top_time=" + str(news_time) \
                  + "&top_show_num=" + str(news_num) + \
                  "&top_order=DESC"
            # 发送get请求
            headers = {'User-Agent': ua.random}
            try:
                res_text = requests.get(url, headers=headers, proxies=random.choice(checked_proxies)).text.strip()
            except Exception as e:
                failed_request = failed_request + 1
                if failed_request % 3 == 0:
                    time.sleep(5)
                print("TopNewsInfoCollector:UrlRequest:" + str(e))
            else:
                res_text = res_text.lstrip('var data=')
                res_text = res_text.rstrip(';')
                try:
                    news_json = js.loads(res_text)['data']
                except Exception as e:
                    if failed_extract % 3 == 0:
                        time.sleep(5)
                    print("TopNewsInfoCollector:InfoExtraction:" + str(e))
                else:
                    path = "./news_source/" + str(news_time) + ".csv"
                    f = csv.writer(open(path, "w", encoding='UTF-8', newline=''))
                    f.writerow(["news_type", "news_id", "top_id", "title", "comment_url", "url", "create_date", "top_num",
                                "cat_name"])
                    for news in news_json:
                        if isinstance(news['ext5'], str):
                            news_info = news['ext5'].split(':')
                            if len(news_info) > 1:
                                f.writerow([
                                    news_info[0],
                                    news_info[1],
                                    news['id'],
                                    news['title'],
                                    news['comment_url'],
                                    news['url'],
                                    news['create_date'],
                                    int(news['top_num'].replace(',', '')),
                                    news['cat_name']
                                ])
                    print("TopNewsInfoCollector:CsvWriter:Today's News Got!")
        news_time = news_time - 28
    print("news json collected!")
