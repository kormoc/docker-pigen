FROM ubuntu:xenial

LABEL maintainer="Rob Smith <kormoc@gmail.com>"

ARG pigen_tag=2020-12-02-raspbian-buster

RUN apt-get update
RUN apt-get install -y git
RUN mkdir /pi-gen /deploy /work
RUN git clone https://github.com/RPi-Distro/pi-gen.git /pi-gen
RUN cd /pi-gen && git checkout tags/${pigen_tag}
RUN for PKG in $(awk -F: '{ print $NF }' /pi-gen/depends); do apt-get install -y "${PKG}" || true; done

# provides xxd in 16.04
RUN apt-get install -y vim-common

# Fix requiring binfmt_misc on native arm
COPY dependencies_check.patch /pi-gen/scripts
RUN cd /pi-gen/scripts && patch -p0 < dependencies_check.patch

COPY config /pi-gen/config
RUN touch /config

CMD cd /pi-gen/ && ./build.sh -c /config
