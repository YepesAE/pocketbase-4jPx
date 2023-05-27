FROM botwayorg/pb-core:latest AS download
FROM alpine:latest

ENV PKGS="git git-lfs npm build-base ca-certificates"
ENV CMD="/usr/local/bin/pocketbase serve --http=0.0.0.0:8080 --dir=/root/pocketbase"
ENV SG_DIR="/root/pocketbase"

ARG GITHUB_TOKEN

RUN apk update && apk add --update $PKGS && rm -rf /var/cache/apk/* && npm i -g npm@latest @botway/strg@latest

COPY --from=download /pocketbase /usr/local/bin/pocketbase

EXPOSE 8080

ENTRYPOINT strg --check && strg --sync
