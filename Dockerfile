FROM ubuntu:mantic

COPY ./linux-server.x86_64 ./server
COPY ./linux-server.pck ./server.pck

ENTRYPOINT [ "tail", "-f", "/dev/null" ]

