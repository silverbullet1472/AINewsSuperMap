import pandas as pd
import os
import requests
import math


def add_time(path=r"C:\PersonalFiles\AINews\NewsAnalysis\data\news_comment"):
    files = os.listdir(path)
    os.chdir(path)
    for file in files:
        df = pd.read_csv(file, header=0, encoding="utf-8")
        df['time'] = os.path.splitext(file)[0]
        df.to_csv(file, encoding="utf-8")


def merge(output, path=r"C:\PersonalFiles\AINews\NewsAnalysis\data\comment_processed"):
    files = os.listdir(path)
    os.chdir(path)
    for file in files:
        df = pd.read_csv(file, header=0, encoding="utf-8")
        df.to_csv(output, mode='a', encoding="utf-8")


def drop_columns(input, output):
    df = pd.read_csv(input, header=0,
                     names=['a', 'b', 'c', 'd', 'id', 'comment', 'location', 'time', 'confidence', 'positive',
                            'negative', 'type'], encoding='utf-8')
    print(df)
    df = df[['id', 'comment', 'location', 'time', 'confidence', 'positive', 'negative', 'type']]
    df.to_csv(output, index=False, encoding="utf-8")
    print(df)


def geocoder(address):
    url = 'http://api.map.baidu.com/geocoding/v3/'
    params = {
        'address': address,
        'ak': 'r7hfQnBXT2gxsVFGlZ14PZiNwk7gTs4G',
        'ret_coordtype': 'gcj02ll',
        "output": 'json'
    }
    try:
        res = requests.get(url, params)
        lng = res.json()['result']['location']['lng']
        lat = res.json()['result']['location']['lat']
    except Exception:
        return 0, 0
    return (lng, lat)


def addlocation(input, output):
    df = pd.read_csv(input, header=0, encoding="utf-8")
    for index, row in df.iterrows():
        location = row['location']
        lnglat = geocoder(location)
        df.loc[index, 'lnglat'] = str(lnglat[0]) + ',' + str(lnglat[1])
        print(index)
    df.to_csv(output, encoding="utf-8")


def addlog(input, output):
    df = pd.read_csv(input, header=0, encoding="utf-8")
    for index, row in df.iterrows():
        count = row['count']
        df.loc[index, 'logcount'] = math.log(count) * 8
        print(index)
    print(df)
    df.to_csv(output, encoding="utf-8")


def addmean(input, output):
    df = pd.read_csv(input, header=0, encoding="utf-8")
    for index, row in df.iterrows():
        mean = row['mean']
        df.loc[index, 'absmean'] = mean * mean * 10
        print(index)
    print(df)
    df.to_csv(output, encoding="utf-8")


def filter(input, output):
    df_data = pd.read_csv(input, header=0, encoding="utf-8")
    print(df_data)
    df_data = df_data.dropna()
    print(df_data)
    print(df_data['confidence'].dtype)
    df_data['confidence'] = pd.to_numeric(df_data['confidence'], errors='coerce')
    df_data['positive'] = pd.to_numeric(df_data['positive'], errors='coerce')
    df_data['negative'] = pd.to_numeric(df_data['negative'], errors='coerce')
    df_data['type'] = pd.to_numeric(df_data['type'], errors='coerce')
    df_data['time'] = pd.to_numeric(df_data['time'], errors='coerce')
    print(df_data['confidence'].dtype)
    df_data = df_data.dropna()
    print(df_data)
    df_filtered = df_data[df_data['confidence'] > 0.9]
    df_filtered.loc[df_filtered['type'] == 0, 'type'] = -1
    df_filtered.loc[df_filtered['type'] == 1, 'type'] = 0
    df_filtered.loc[df_filtered['type'] == 2, 'type'] = 1
    print(df_filtered)
    df_filtered.to_csv(output, encoding="utf-8", index=False)


def stats_byloc(input,output):
    df_filtered = pd.read_csv(input, header=0, encoding="utf-8")
    print(df_filtered)
    df_byloc = df_filtered.groupby('location').agg({'location': ['count'],
                                                                    'type': ['mean']})
    df_byloc.to_csv(output, encoding="utf-8", index=True)



def stats_byid(input):
    df_filtered = pd.read_csv(input, header=0, encoding="utf-8")
    print(df_filtered)
    df_byid = df_filtered.groupby('id').agg({'id': ['count'],
                                             'type': ['mean']})
    df_byid = df_byid[df_byid['id']['count'] > 12]
    print(df_byid)


def stats_bytype(input):
    df_filtered = pd.read_csv(input, header=0, encoding="utf-8")
    print(df_filtered)
    df_bytype = df_filtered.groupby('type').agg({'id': ['count']})
    print(df_bytype)


if __name__ == "__main__":
    # merge(path=r"C:\PersonalFiles\AINews\NewsAnalysis\data\comment_processed", output=r"C:\PersonalFiles\AINews\NewsAnalysis\merged.csv")
    # drop_columns('merged.csv', 'merged.csv')
    # filter("merged.csv", "filtered_0.8.csv")
    # stats_bytype("merged.csv")
    # stats_byloc("filtered_0.8.csv")
    # stats_byloc("filtered_0.8.csv","loc.csv")
    #df_byloc = pd.read_csv('loc.csv', header=0, encoding="utf-8")
    #print(df_byloc.sort_values(by='count'))
    #df_byloc  = df_byloc[df_byloc['count'] > 40]
    #print(df_byloc.sort_values(by='mean'))
    df = pd.read_csv("merged.csv", encoding='utf-8')
    for index, row in df.iterrows():
        print(row)
'''


df = pd.read_csv("df_3.csv",encoding='utf-8')
df = df[df['count']>20]
print(df)

print(df_filtered)
df_byid_2 = df_filtered.groupby('id').agg({'id':['count'],'type': ['mean']})
print(df_byid_2)
'''
# stats()
