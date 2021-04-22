APP_NAME ?= haskell-io-example
VERS = 1.0
DOCKER_ORG = mhuirich

default: build

build:
	docker build -t  $(DOCKER_ORG)/$(APP_NAME) --build-arg APP=$(APP_NAME) .

strip:
	~/Dropbox/bin/strip-docker-image \
	-i $(DOCKER_ORG)/$(APP_NAME) \
	-t $(DOCKER_ORG)/$(APP_NAME)-stripped \
	-f /app/entrypoint.sh \
	-f /app/$(APP_NAME) \
	-f /bin/sh \
	-f /lib/*musl* \
	-f /usr/lib/*curs* \
	-f /usr/lib/*gmp*

sh:
	docker run --entrypoint sh -it $(DOCKER_ORG)/$(APP_NAME)

run:
	docker run -it $(DOCKER_ORG)/$(APP_NAME)-stripped

all: build strip run

push:
	docker tag $(DOCKER_ORG)/$(APP_NAME)-stripped \
		$(DOCKER_ORG)/$(APP_NAME)-stripped:$(VERS)
	docker push $(DOCKER_ORG)/$(APP_NAME)-stripped:latest
	docker push $(DOCKER_ORG)/$(APP_NAME)-stripped:$(VERS)

PHONY: default strip sh run all push
