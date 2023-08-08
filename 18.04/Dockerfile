FROM ubuntu:18.04
WORKDIR /root
ENV LC_CTYPE C.UTF-8
ARG DEBIAN_FRONTEND=noninteractive

RUN dpkg --add-architecture i386
RUN apt update -y
RUN apt install socat net-tools libc6:i386 -y

ADD start_chal.sh .
RUN chmod +x start_chal.sh

RUN mkdir /root/pwn
WORKDIR /root/pwn