FROM python:3.8-bullseye

LABEL authors="tigattack" 

ENV PATH="/home/reddash/.local:/home/reddash/.local/bin:${PATH}"
ENV RPC_PORT=6133
ENV WEB_PORT=42356

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
   apt-get --no-install-recommends -y install wget curl python3-openssl git openjdk-11-jre-headless build-essential && \
   apt-get upgrade -y && \
   apt-get autoremove -y && \
   rm -rf /var/lib/apt/lists/* && \
   python -m pip install --upgrade pip && \
   groupadd -r reddash -g 1025 && \
   useradd  -r -m -g reddash reddash

USER reddash

COPY requirements.txt /tmp/requirements.txt

RUN python -m pip install --no-cache -U --user -r /tmp/requirements.txt

ENTRYPOINT reddash --port $WEB_PORT --rpc-port $RPC_PORT
