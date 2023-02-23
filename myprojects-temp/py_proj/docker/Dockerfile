FROM python:3.9

RUN apt-get update -y && \
    apt-get install -y python3-pip

RUN pip3 install pip --upgrade
RUN pip3 install --no-cache-dir fire tqdm requests
