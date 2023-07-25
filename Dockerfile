FROM ubuntu:mantic

COPY ./linux-server.x86_64 ./server
COPY ./linux-server.pck ./server.pck
RUN apk add gcompat

ENTRYPOINT [ "tail", "-f", "/dev/null" ]

