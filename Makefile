NS = mligor
VERSION = 1.17
TAG_SUFIX = -arm64 #TODO set correct sufix before building

IMAGE_NAME = golang-mingw-w64
CONTAINER_NAME = golang-mingw-w64
CONTAINER_INSTANCE = test

.PHONY: build push shell clean manifest push_manifest

build: Dockerfile
	docker build -t $(NS)/$(IMAGE_NAME):$(VERSION)$(TAG_SUFIX) -t $(NS)/$(IMAGE_NAME):latest$(TAG_SUFIX) -f Dockerfile .

push:
	docker push $(NS)/$(IMAGE_NAME):$(VERSION)$(TAG_SUFIX)
	docker push $(NS)/$(IMAGE_NAME):latest$(TAG_SUFIX)

shell:
	docker run --rm --name $(CONTAINER_NAME)-$(CONTAINER_INSTANCE) -i -t $(NS)/$(IMAGE_NAME):$(VERSION)$(TAG_SUFIX) /bin/bash

clean:
	docker image rm $(NS)/$(IMAGE_NAME):$(VERSION)$(TAG_SUFIX)

manifest:
	DOCKER_CLI_EXPERIMENTAL=enabled docker manifest create --amend $(NS)/$(IMAGE_NAME):$(VERSION) $(NS)/$(IMAGE_NAME):$(VERSION)-amd64 $(NS)/$(IMAGE_NAME):$(VERSION)-arm64
	DOCKER_CLI_EXPERIMENTAL=enabled docker manifest create --amend $(NS)/$(IMAGE_NAME):latest $(NS)/$(IMAGE_NAME):latest-amd64 $(NS)/$(IMAGE_NAME):latest-arm64

push_manifest:
	DOCKER_CLI_EXPERIMENTAL=enabled docker manifest push $(NS)/$(IMAGE_NAME):$(VERSION)
	DOCKER_CLI_EXPERIMENTAL=enabled docker manifest push $(NS)/$(IMAGE_NAME):latest

default: build

