FROM ubuntu:15.10
MAINTAINER Guoqiang Chen <subchen@gmail.com>

RUN apt-get update \
 && apt-get install -y curl wget zip unzip tree python-software-properties software-properties-common \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

