FROM --platform=linux/amd64 ubuntu:20.04 as builder

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y imagemagick ttyrec gcc x11-apps make git

ADD . /repo
WORKDIR /repo
RUN make -j8
ENV WINDOWID=23068679

RUN mkdir -p /deps
RUN ldd /repo/ttygif | tr -s '[:blank:]' '\n' | grep '^/' | xargs -I % sh -c 'cp % /deps;'

FROM ubuntu:20.04 as package

COPY --from=builder /deps /deps
COPY --from=builder /repo/ttygif /repo/ttygif
ENV LD_LIBRARY_PATH=/deps
