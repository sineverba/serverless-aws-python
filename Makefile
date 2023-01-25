IMAGE_NAME=sineverba/serverless-aws-python
CONTAINER_NAME=serverless-aws-python
VERSION=0.3.0-dev

build:
	docker-compose build

test:
	docker run --rm -it $(IMAGE_NAME):$(VERSION) cat /etc/os-release | grep "Debian GNU/Linux 11 (bullseye)"
	docker run --rm -it $(IMAGE_NAME):$(VERSION) python -V | grep "3.9.16"
	docker run --rm -it $(IMAGE_NAME):$(VERSION) node -v | grep "18.13.0"
	docker run --rm -it $(IMAGE_NAME):$(VERSION) npm -v | grep "9.3.1"
	
destroy:
	docker image rm $(IMAGE_NAME):$(VERSION)