FROM ubuntu:mantic

COPY ./linux-server.x86_64 ./server
COPY ./linux-server.pck ./server.pck

RUN apt update
RUN apt-get install libfontconfig1 fontconfig libfontconfig1-dev -y

CMD [ "./server", "--main-pack", "./server.pck" ]

