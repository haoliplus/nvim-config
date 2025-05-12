;; dockerfile
FROM python:3.7-alphine AS prod
FROM ubuntu:20.04
RUN rm -rf /var/lib/apt/lists/* && sed -i s@/archive.ubuntu.com/@/mirrors.tuna.tsinghua.edu.cn/@g /etc/apt/sources.list
ENV DEBIAN_FRONTEND noninteractive
ENV TZ Asia/Shanghai
RUN apt-get update && apt-get install -y --no-install-recommends \
         build-essential zlib1g-dev libreadline-dev libssl-dev \
         libbz2-dev sqlite3 tk-dev libsqlite3-dev libncurses-dev \
         ca-certificates liblzma-dev libffi-dev cmake tzdata

FROM prod AS dev

RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN apt-get install -y --no-install-recommends \
         curl wget sudo zip unzip \
         sshfs git zsh tree ctags htop xterm gdb bc man \
         less debconf-utils gosu tmux ssh rsync 

ENV TASK demo
EXPOSE 5000

ENTRYPOINT ["/bin/tail", "-f"]

CMD ["/dev/null"]
