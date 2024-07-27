FROM alpine
COPY config.json /usr/bin/
COPY idle /usr/bin/
ENTRYPOINT idle
