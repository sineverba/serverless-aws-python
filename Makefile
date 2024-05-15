IMAGE_NAME=sineverba/serverless-aws-python
CONTAINER_NAME=serverless-aws-python
PYTHON_VERSION=3.12.1
NODE_VERSION=20.10.0
NPM_VERSION=10.2.5
SERVERLESS_VERSION=3.38.0
SERVERLESS_OFFLINE_VERSION=13.3.1
SERVERLESS_PYTHON_REQUIREMENTS_VERSION=6.0.1
APP_VERSION=0.5.0-dev

all: install spin
.PHONY: all

build:
	docker \
		build \
		--tag $(IMAGE_NAME):$(APP_VERSION) \
		--file .devcontainer/Dockerfile \
		"."

install:
	npm install serverless@${SERVERLESS_VERSION} \
    serverless-offline@${SERVERLESS_OFFLINE_VERSION} \
    serverless-python-requirements@${SERVERLESS_PYTHON_REQUIREMENTS_VERSION}

spin:
	npx serverless offline start --host 0.0.0.0 --httpPort 3000

test:
	docker run --rm -it $(IMAGE_NAME):$(APP_VERSION) cat /etc/os-release | grep "Debian GNU/Linux 11 (bullseye)"
	docker run --rm -it $(IMAGE_NAME):$(APP_VERSION) python -V | grep $(PYTHON_VERSION)
	docker run --rm -it $(IMAGE_NAME):$(APP_VERSION) node -v | grep $(NODE_VERSION)
	docker run --rm -it $(IMAGE_NAME):$(APP_VERSION) npm -v | grep $(NPM_VERSION)
	
destroy:
	docker image rm python:3.12.1-slim-bullseye
	docker image rm $(IMAGE_NAME):$(APP_VERSION)