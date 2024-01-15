FROM python:3.10-slim

LABEL maintainer="lihao haoliplus@gmail.com"
ENV APT_SOURCE "mirrors.tuna.tsinghua.edu.cn"
ENV DEBIAN_FRONTEND noninteractive
ENV TZ Asia/Shanghai

RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' \
  /etc/apt/sources.list.d/debian.sources \
	&& apt update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
  --no-install-recommends curl

RUN python -m pip config set \
  global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

ADD . /app
WORKDIR /app

RUN python -m pip install --upgrade pip \
  && python -m pip install --no-cache-dir .

ENTRYPOINT ["bash", "/app/entrypoint.sh"]
