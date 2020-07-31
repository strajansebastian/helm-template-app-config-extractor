FROM ubuntu:20.04

RUN apt update && \
    apt install -y wget python3-pip && \
    rm -rf /var/cache/apt/*

# /helm folder can be used to mount the helm chart code + values that are used by the script
# /helm/output can be mounted to get the output on the local VM
RUN mkdir -p /app /config /helm/charts /helm/values /helm/output
WORKDIR /helm/output

RUN wget -q -O /tmp/helm-v3.2.3-linux-amd64.tar.gz https://get.helm.sh/helm-v3.2.3-linux-amd64.tar.gz && \
    cd /tmp && \
    tar xvf /tmp/helm-v3.2.3-linux-amd64.tar.gz && \
    mv /tmp/linux-amd64/helm /usr/local/bin/helm && \
    rm -rf /tmp/linux-amd64 /tmp/helm-v3.2.3-linux-amd64.tar.gz

COPY requirements.txt /app

RUN pip3 install -r /app/requirements.txt

COPY helm-template-get-app-configs.py /app
