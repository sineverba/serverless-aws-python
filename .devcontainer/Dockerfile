# Pull official base image
FROM python:3.12.1-slim-bullseye
ENV NODE_VERSION=20.10.0
ENV NPM_VERSION=10.2.5
# Update and install
RUN apt-get update -y && apt-get install \
        build-essential \
        curl \
        git \
        xz-utils \
        -y
# Setup node / npm
RUN curl https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz -O
# Extract & install
RUN tar -xf node-v$NODE_VERSION-linux-x64.tar.xz
RUN ln -s /node-v$NODE_VERSION-linux-x64/bin/node /usr/local/bin/node && \
    ln -s /node-v$NODE_VERSION-linux-x64/bin/npm /usr/local/bin/npm && \
    ln -s /node-v$NODE_VERSION-linux-x64/bin/npx /usr/local/bin/npx && \
    npm install -g npm@$NPM_VERSION
# Add non-root user
ARG USERNAME=nonroot
RUN useradd -ms /bin/bash $USERNAME
## Make sure to reflect new user in PATH
ENV PATH="/home/${USERNAME}/.local/bin:${PATH}"
USER $USERNAME