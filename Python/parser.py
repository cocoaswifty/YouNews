import requests
from bs4 import BeautifulSoup

def requests_list(event, context):
    res = requests.get('https://www.youtube.com/playlist?list=PLiJ85EtvVCzNLUY0vMsYjrjSRzujE_FDk')
    soup = BeautifulSoup(res.text, 'html.parser')

    list = []
    max_count = 49
    table = soup.find('table', attrs={'class':'pl-video-table'})
    table_body = table.find('tbody')
    rows = table_body.find_all('tr')

    for row in rows:
        str = row.prettify('utf-8').decode('utf-8')
        title = str.split('"')[5].strip()
        id = str.split('"')[7].strip()
        owner = str.split('pl-video-owner')[1].strip().split('"')[7].split('\n')[1].strip()
        time = str.split('pl-video-time')[1].split('>')[4].split('\n')[1].strip()

        list.append({'id': id, 'title': title, 'owner': owner, 'time': time})

        # 顯示最大筆數
        if len(rows) > 49:      
            if row == rows[49]:
                break

    return max_count

