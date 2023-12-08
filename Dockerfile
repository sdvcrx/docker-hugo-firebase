FROM bitnami/minideb AS build

ENV HUGO_VERSION 0.121.1
ARG TARGETARCH

ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_Linux-${TARGETARCH}.tar.gz /tmp/hugo.tar.gz

RUN tar xvzf /tmp/hugo.tar.gz -C /tmp/ && \
  mv /tmp/hugo /usr/bin

# ---
FROM node:lts-slim
LABEL maintainer="me@sdvcrx.com"

COPY --from=build /usr/bin/hugo /usr/bin/hugo

WORKDIR /app
RUN apt-get update \
      && apt-get install -y ca-certificates curl \
      && rm -rf /var/lib/apt/lists/* \
      && npm install -g firebase-tools

CMD ["hugo"]
