FROM --platform=linux/amd64 ubuntu:20.04

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y imagemagick ttyrec gcc x11-apps make git

ADD . /repo
WORKDIR /repo
RUN make -j8
ENV WINDOWID=23068679
