FROM bitnami/minideb:bullseye AS build

ENV HUGO_VERSION 0.103.0

ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz /tmp/hugo.tar.gz
ADD https://firebase.tools/bin/linux/latest /usr/bin/firebase

WORKDIR /app

RUN tar xvzf /tmp/hugo.tar.gz -C /tmp/ && \
  chmod +x /usr/bin/firebase && \
  mv /tmp/hugo /usr/bin

# ---
FROM bitnami/minideb:bullseye
LABEL maintainer="me@sdvcrx.com"

COPY --from=build /usr/bin/firebase /usr/bin/firebase
COPY --from=build /usr/bin/hugo /usr/bin/hugo

WORKDIR /app
RUN install_packages ca-certificates curl
