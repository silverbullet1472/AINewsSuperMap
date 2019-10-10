from aip import AipNlp
import os
import pandas as pd

""" 你的 APPID AK SK """
APP_ID = '17081433'
API_KEY = 'ZDMmw88yjmeYVTeVLjH45Iuw'
SECRET_KEY = 'NwwaVlu6HPnShA5rRnkj8Ib2zQ1Vs2iQ'
client = AipNlp(APP_ID, API_KEY, SECRET_KEY)


def get_sentiment(content):
    try:
        json_data = client.sentimentClassify(content)
        items = json_data['items']
        items = items[0]
        confidence = items['confidence']
        positive_prob = items['positive_prob']
        negative_prob = items['negative_prob']
        sentiment = items['sentiment']
        return confidence, positive_prob, negative_prob, sentiment
    except:
        return 0, 0, 0, 0


path = r"C:\PersonalFiles\AINews\NewsAnalysis\data\news_comment"
files = os.listdir(path)
os.chdir(path)
for file in files:
    df = pd.read_csv(file, header=0, encoding="utf-8")
    for i, row in df.iterrows():
        result = get_sentiment(row['comment'].encode('gbk', 'ignore').decode('gbk', 'ignore'))
        print(result)
        df.loc[i, 'conf'] = result[0]
        df.loc[i, 'positive'] = result[1]
        df.loc[i, 'negative'] = result[2]
        df.loc[i, 'sentiment'] = result[3]
    df.to_csv(file, encoding="utf-8")
