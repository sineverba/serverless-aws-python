IMAGE_NAME=sineverba/serverless-aws-python
CONTAINER_NAME=serverless-aws-python
PYTHON_VERSION=3.12.3
NODE_VERSION=20.13.1
NPM_VERSION=10.7.0
SERVERLESS_VERSION=3.38.0
SERVERLESS_OFFLINE_VERSION=13.5.0
SERVERLESS_PYTHON_REQUIREMENTS_VERSION=6.1.0
APP_VERSION=0.6.0-dev

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

upgrade:
	npm i npm-check-updates
	npx ncu
	
destroy:
	# Remove all images with no current tag
	docker rmi $$(docker images $(IMAGE_NAME):* --format "{{.Repository}}:{{.Tag}}" | grep -v '$(APP_VERSION)') || exit 0;
	# Remove all python images
	docker rmi $$(docker images python --format "{{.Repository}}:{{.Tag}}") || exit 0;
	# Remove all dangling images
	docker rmi $$(docker images -f "dangling=true" -q) || exit 0;
	# Remove cached builder
	docker builder prune -f