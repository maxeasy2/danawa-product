FROM python:latest

RUN apt update -y
RUN apt install -y cron vim locales

RUN localedef -f UTF-8 -i ko_KR ko_KR.utf8
ENV LANG=ko_KR.utf8
ENV LC_ALL=ko_KR.utf8

RUN ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime

RUN mkdir -p /python/danawa/product
RUN pip install BeautifulSoup4 urlopen

WORKDIR /python/danawa
COPY DanawaProduct.py /python/danawa
COPY danawa.sh /python/danawa
COPY loop.sh /python/danawa
RUN chmod -R +x /python/danawa

CMD ["bash", "/python/danawa/loop.sh"]
