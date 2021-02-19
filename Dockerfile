# Uniform Multi-Stage Dockerfile for Lendup/Ahead Services
# (c) 2021 Lendup Global, Inc.  All Rights Reserved.
#
# This is a multi-stage Dockerfile which defines a base Linux
# image (ubuntu) and images for various language implementations
# including JAVA, PYTHON, and NODE.
#
FROM ubuntu:latest as ubuntu_latest
ENV USER_HOME=/opt/
ENV DEBIAN_FRONTEND=noninteractive
#
# Set the working directory
#
WORKDIR ${USER_HOME}
#
# Update the operating system.
#
RUN apt-get update -y --fix-missing && \
    apt-get upgrade -y
#
# Add Service user:group (service:service).
#
RUN addgroup --gid 1000 service && \
    adduser --uid 1000 \
            --gid 1000 \
            --home ${USER_HOME} \
            --shell /bin/false \
            --disabled-password \
            --disabled-login \
            --gecos '' service && \
    userdel games && \
    userdel news && \
    userdel irc && \
    userdel mail && \
    userdel uucp && \
    userdel proxy && \
    apt-get autoremove -y && \
    apt-get autoclean -y && \
    chown -R service:service ${USER_HOME}
USER service
#
# Python latest
#
FROM ubuntu_latest as python_latest
USER root
RUN apt-get install -y \
                    --no-install-recommends \
                    ca-certificates \
                    python3 \
                    python3-pip
USER service
#
# Python 3.9.1
#
FROM ubuntu_latest as python_latest
USER root
RUN apt-get install -y \
                    --no-install-recommends \
                    ca-certificates \
                    python3 \
                    python3-pip
USER service
#
# Python latest
#
FROM python_3_11_1 as python3
#
# Java 1.11
#
FROM ubuntu_latest as java_1_11
USER root
RUN apt-get install -y \
                    --no-install-recommends \
                    ca-certificates \
                    openjdk-11-jre
USER service
#
# Java 1.13
#
FROM ubuntu_latest as java_1_13
USER root
RUN apt-get install -y \
                    --no-install-recommends \
                    ca-certificates \
                    openjdk-13-jre
USER service
#
# Java 1.14
#
FROM ubuntu_latest as java_1_14
USER root
RUN apt-get install -y \
                    --no-install-recommends \
                    ca-certificates \
                    openjdk-14-jre
USER service
#
#
#
FROM java_1_11 as java
#
# Node 14.15.4
#
FROM ubuntu_latest as node_14_15_4
USER root
RUN apt-get install -y --no-install-recommends ca-certificates nodejs npm && \
    npm install node@14.15.4
USER service

#
# Node 15.1.0
#
FROM ubuntu_latest as node_15_1_0
USER root
RUN apt-get install -y --no-install-recommends ca-certificates nodejs npm && \
    npm install node@15.1.0
USER service

FROM node_15_8_0 as node_latest
#
# Node 15.8.1
#
FROM ubuntu_latest as node_15_8_1
USER root
RUN apt-get install -y --no-install-recommends ca-certificates nodejs npm && \
    npm install node@15.8.1
USER service

FROM node_15_8_1 as node_latest