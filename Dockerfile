FROM bitnami/minideb

LABEL maintainer="me@sdvcrx.com"

ENV HUGO_VERSION 0.75.1

ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz /tmp/hugo.tar.gz
ADD https://firebase.tools/bin/linux/latest /usr/bin/firebase

WORKDIR /app

RUN install_packages ca-certificates && \
  chmod +x /usr/bin/firebase && \
  tar xvzf /tmp/hugo.tar.gz -C /tmp/ && \
  mv /tmp/hugo /usr/bin && \
  rm -rf /tmp/