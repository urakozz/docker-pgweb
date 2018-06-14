FROM alpine
MAINTAINER Yury Kozyrev <urakozz@gmail.com>

RUN \
  apk update && \
  apk add curl unzip && \
  rm -rf /var/cache/apk/* && \
  cd /tmp && \
  curl -L https://github.com/sosedoff/pgweb/releases/download/$(curl --silent "https://api.github.com/repos/sosedoff/pgweb/releases/latest" | grep '"tag_name":' |sed -E 's/.*"([^"]+)".*/\1/')/pgweb_linux_amd64.zip > pgweb.zip && \
  adduser -S pgweb && \
  unzip pgweb.zip -d /app && \
  rm -f pgweb.zip && apk del curl && rm -rf /var/cache/apk/*

USER pgweb
WORKDIR /app

EXPOSE 8080
ENTRYPOINT ["/app/pgweb_linux_amd64"]
CMD ["-s", "--bind=0.0.0.0", "--listen=8080"]
