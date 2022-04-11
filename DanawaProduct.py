from urllib.request import urlopen
from urllib.request import Request
from urllib import parse
from bs4 import BeautifulSoup
import ssl
import sys

args = sys.argv

if len(args) <= 1 :
    print('pcode is null')
    exit(1);

pcode = args[1]

ssl._create_default_https_context = ssl._create_unverified_context


url = 'http://prod.danawa.com/info/?pcode=' + pcode
headers = {'Content-Type': 'text/plain', 'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.75 Safari/537.36'}
req = Request(url, None, headers)
html = urlopen(req)

bs = BeautifulSoup(html, "html.parser") 
prdNm = bs.find(class_="top_summary").find(class_="prod_tit").string
lowestPrice = bs.find(class_="lowest_price").find(class_="prc_c").string + ' 원'

print(parse.quote('상품명 : ' + prdNm + '\n최저가 : ' + lowestPrice + '\nURL : ' + url))
