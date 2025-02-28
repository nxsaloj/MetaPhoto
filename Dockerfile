FROM ubuntu:latest

RUN apt update && \
    apt install -y curl \
    unzip \
    g++ \
    make \
    cmake \
    groff \
    less \
    && curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm -rf aws awscliv2.zip  