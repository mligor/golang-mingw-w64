NS = mligor
VERSION = 1.17

IMAGE_NAME = golang-mingw-w64
CONTAINER_NAME = golang-mingw-w64
CONTAINER_INSTANCE = test

.PHONY: build push shell clean release

build: Dockerfile
	docker build -t $(NS)/$(IMAGE_NAME):$(VERSION) -t $(NS)/$(IMAGE_NAME):latest -f Dockerfile .

push:
	docker push $(NS)/$(IMAGE_NAME):$(VERSION)
	docker push $(NS)/$(IMAGE_NAME):latest

shell:
	docker run --rm --name $(CONTAINER_NAME)-$(CONTAINER_INSTANCE) -i -t $(NS)/$(IMAGE_NAME):$(VERSION) /bin/bash

clean:
	docker image rm $(NS)/$(IMAGE_NAME):$(VERSION)

release: build
	make push -e VERSION=$(VERSION)

default: build
