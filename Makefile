IMAGE_NAME=sineverba/serverless-aws-python
CONTAINER_NAME=serverless-aws-python
APP_VERSION=0.5.0-dev

build:
	docker build --tag $(IMAGE_NAME):$(APP_VERSION) --file development/Dockerfile "."

test:
	docker run --rm -it $(IMAGE_NAME):$(APP_VERSION) cat /etc/os-release | grep "Debian GNU/Linux 11 (bullseye)"
	docker run --rm -it $(IMAGE_NAME):$(APP_VERSION) python -V | grep "3.12.1"
	docker run --rm -it $(IMAGE_NAME):$(APP_VERSION) node -v | grep "20.10.0"
	docker run --rm -it $(IMAGE_NAME):$(APP_VERSION) npm -v | grep "10.2.5"
	
destroy:
	docker image rm python:3.12.1-slim-bullseye
	docker image rm $(IMAGE_NAME):$(APP_VERSION)