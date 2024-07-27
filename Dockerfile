FROM ubuntu:noble
USER 0
COPY config.json /usr/bin/
COPY idle /usr/bin/
WORKDIR /usr/bin
CMD bash -c "cd /usr/bin; ./idle"