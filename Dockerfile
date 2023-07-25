FROM ubuntu:mantic

COPY ./linux-server.x86_64 .
COPY ./linux-server.pck .
COPY ./linux-server.sh .


RUN chmod a+x ./linux-server.sh
RUN apt update
RUN apt-get install libfontconfig1 fontconfig libfontconfig1-dev -y

EXPOSE 8080
CMD [ "./linux-server.x86_64", "--main-pack", "./linux-server.pck", "--headless" ]

