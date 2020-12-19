FROM ubuntu:xenial

LABEL maintainer="Rob Smith <kormoc@gmail.com>"

ARG pigen_tag=2020-12-02-raspbian-buster

RUN apt-get --quiet --quiet update
RUN apt-get --quiet --quiet install --assume-yes git
RUN mkdir /pi-gen /deploy /work
RUN git clone https://github.com/RPi-Distro/pi-gen.git /pi-gen
RUN cd /pi-gen && git checkout tags/${pigen_tag}

RUN awk -F: '{ print $NF }' /pi-gen/depends > /tmp/requirements
# In Ubuntu 16.04, xxd is provided in the vim-common package
RUN sed -i'' 's/xxd/vim-common/g' /tmp/requirements
RUN sed -i'' 's/\n/ /g' /tmp/requirements
RUN apt-get --quiet --quiet install --assume-yes $(cat /tmp/requirements)

# Fix requiring binfmt_misc on native arm
COPY dependencies_check.patch /pi-gen/scripts
RUN cd /pi-gen/scripts && patch -p0 < dependencies_check.patch

COPY config /pi-gen/config
RUN touch /config

CMD cd /pi-gen/ && ./build.sh -c /config
