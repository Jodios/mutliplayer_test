FROM alpine:3.18.2

COPY ./linux-server.x86_64 ./server
COPY ./linux-server.pck ./server.pck
RUN apk add gcompat

CMD [ "sleep", "200" ] 

