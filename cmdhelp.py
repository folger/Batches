import os
import webbrowser
import traceback

import requests
import bs4


r = requests.get('https://technet.microsoft.com/en-us/library/cc772390(v=ws.11).aspx')
soup = bs4.BeautifulSoup(r.text, 'html.parser')


cmd_links = {}
for li in soup(class_='unordered')[0]:
    a = li.p.a
    cmd_links[a.text.lower()] = a['href']

os.system('title Command-Line Reference')
while True:
    cmd = input('Display help for: ')
    if not cmd:
        break
    try:
        webbrowser.open_new(cmd_links[cmd])
    except KeyError:
        print('Help for "{}" cannot be displayed'.format(cmd))
    except:
        traceback.print_exc()
