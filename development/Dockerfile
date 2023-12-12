# Pull official base image
FROM python:3.12.1-slim-bullseye

ENV NODE_VERSION=20.10.0
ENV NPM_VERSION=10.2.5
ENV SERVERLESS_VERSION=3.38.0
ENV SERVERLESS_OFFLINE_VERSION=13.3.1
ENV SERVERLESS_PYTHON_REQUIREMENTS_VERSION=6.0.1

# Update, upgrade and install
RUN apt-get update -y && apt-get upgrade -y && apt-get install curl xz-utils -y

# Setup node / npm
RUN curl https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz -O

# Extract & install
RUN tar -xf node-v${NODE_VERSION}-linux-x64.tar.xz
RUN ln -s /node-v${NODE_VERSION}-linux-x64/bin/node /usr/local/bin/node && \
    ln -s /node-v${NODE_VERSION}-linux-x64/bin/npm /usr/local/bin/npm && \
    ln -s /node-v${NODE_VERSION}-linux-x64/bin/npx /usr/local/bin/npx && \
    npm install -g npm@${NPM_VERSION}

# Check against right version
RUN node -v | grep ${NODE_VERSION}
RUN npm -v | grep ${NPM_VERSION}

# Install globally SLS
RUN npm install -g serverless@${SERVERLESS_VERSION} \
    serverless-offline@${SERVERLESS_OFFLINE_VERSION} \
    serverless-python-requirements@${SERVERLESS_PYTHON_REQUIREMENTS_VERSION}

# set working directory
WORKDIR /usr/src/app

CMD npx serverless offline start --host 0.0.0.0 --httpPort 3000