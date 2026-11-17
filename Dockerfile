FROM bitnami/minideb AS hugo

ENV HUGO_VERSION=0.170.1
ARG TARGETARCH

ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_linux-${TARGETARCH}.tar.gz /tmp/hugo.tar.gz

RUN tar xvzf /tmp/hugo.tar.gz -C /tmp/ && \
  mv /tmp/hugo /usr/bin

# Map Docker architecture names to Dart Sass release names before ADD.
FROM bitnami/minideb AS sass-amd64
ARG SASS_ARCH=x64

FROM bitnami/minideb AS sass-arm64
ARG SASS_ARCH=arm64

FROM sass-${TARGETARCH} AS sass
ARG DART_SASS_VERSION=1.108.2

ADD https://github.com/sass/dart-sass/releases/download/${DART_SASS_VERSION}/dart-sass-${DART_SASS_VERSION}-linux-${SASS_ARCH}.tar.gz /tmp/dart-sass.tar.gz

RUN tar xzf /tmp/dart-sass.tar.gz -C /usr/lib

# ---
FROM node:lts-slim
LABEL maintainer="me@sdvcrx.com"

WORKDIR /app
RUN apt-get update \
      && apt-get install -y ca-certificates curl \
      && rm -rf /var/lib/apt/lists/* \
      && npm install -g firebase-tools \
      && ln -s /usr/lib/dart-sass/sass /usr/bin/sass

COPY --from=hugo /usr/bin/hugo /usr/bin/hugo
COPY --from=sass /usr/lib/dart-sass /usr/lib/dart-sass

CMD ["hugo"]
