FROM bitnami/minideb as build

ENV HUGO_VERSION 0.67.1

WORKDIR /app

ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz /tmp/hugo.tar.gz
ADD https://firebase.tools/bin/linux/latest /app/firebase

RUN install_packages binutils && \
  chmod +x /app/firebase && \
  strip /app/firebase && \
  tar xvzf /tmp/hugo.tar.gz -C /tmp/ && \
  mv /tmp/hugo /app && \
  rm -rf /tmp/


FROM bitnami/minideb

LABEL maintainer="me@sdvcrx.com"

COPY --from=build /app/firebase /usr/bin/
COPY --from=build /app/hugo /usr/bin/

RUN install_packages ca-certificates