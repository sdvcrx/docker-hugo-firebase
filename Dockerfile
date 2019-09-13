FROM node:lts-alpine

MAINTAINER me@sdvcrx.com

ENV HUGO_VERSION 0.58.2

ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz /tmp/hugo.tar.gz

WORKDIR /app

RUN npm i -g firebase-tools && \
  tar xvzf /tmp/hugo.tar.gz -C /tmp/ && \
  mv /tmp/hugo /usr/bin && \
  rm -rf /tmp/