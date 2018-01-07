FROM golang:alpine as golang

RUN apk add --update --no-cache git

RUN go get github.com/jessfraz/apk-file
RUN go get github.com/motemen/ghq

FROM alpine:edge

ENV EDITOR /usr/bin/nvim

RUN echo 'http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories

RUN apk update
RUN apk upgrade

RUN apk add --no-cache ca-certificates \
  alpine-sdk

RUN apk add --no-cache tzdata
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN apk add --no-cache \
  coreutils \
  findutils \
  file \
  docker \
  bash

# add user app
RUN adduser -D -s /bin/bash app
RUN addgroup app abuild
RUN addgroup app wheel
RUN addgroup app docker

RUN apk add --no-cache \
  sudo \
  git
RUN sed --in-place 's/^#\s*\(%wheel\s\+ALL=(ALL)\s\+NOPASSWD:\s\+ALL\)/\1/' /etc/sudoers

# golang
COPY --from=golang /go/bin/apk-file /usr/bin/
COPY --from=golang /go/bin/ghq /usr/bin/

RUN apk add --no-cache \
  neovim \
  vimdiff

RUN apk add --no-cache \
  openssh \
  libressl-dev

RUN apk add --no-cache \
  the_silver_searcher \
  tmux \
  rcm

# require to build ruby, python, nodejs
RUN apk add --no-cache \
  linux-headers \
  jpeg-dev \
  zlib-dev \
  readline-dev \
  bzip2-dev \
  sqlite-dev \
  gnupg \
  perl-utils

RUN apk add --no-cache \
  ctags \
  less \
  jq
