#!/usr/bin/make -f

DOCKER := podman
IMAGE  := mkosi:1.0.0
OUTPUT := images
DOCKER_FLAGS  := --rm --name mkosi_1.0.0 --privileged --init --pid=host --net=host -v ${PWD}/images:/images -w /images
PODMAN_FLAGS  := --rm --name mkosi_1.0.0 --privileged --systemd=true --pid=host --net=host -v ${PWD}/images:/images -w /images
NAME   := mkosi_1.0.0


.PHONY: image builder clean all

$(OUTPUT):
	@echo "Directory $(OUTPUT) does not exist"
	mkdir -p $(CURDIR)/$(OUTPUT)
	
builder:
	$(DOCKER) build -t $(IMAGE) .

image:
ifeq (docker, $(DOCKER))
	$(DOCKER) run $(DOCKER_FLAGS) --name $(NAME) $(IMAGE)
else

	$(DOCKER) run $(PODMAN_FLAGS) --name $(NAME) $(IMAGE)
endif

all: require builder image

require:
ifeq (, $(shell which $(DOCKER)))
	$(error "No $(DOCKER) in $(PATH), consider doing apt-get install $(DOCKER)")
endif

clean:
	rm -fv $(OUTPUT)/*
