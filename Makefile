##############################################################
# Makefile for Advance Development Factory (ADF)
##############################################################

# Build vars
DOCKER_NAME=advance-development-factory-formbot-dialogflow
DOCKER_TAG=latest
DOCKER_IMG=$(DOCKER_NAME):$(DOCKER_TAG)
REMOTE_IMG:=docker.io/umgccaps/$(DOCKER_IMG)

# PHONY
.PHONY: build-env start-env push help


####################################################################
#	make build-env:
#		This builds the ADF Docker image.
#
####################################################################
build-env:
	docker build -f ./docker/Dockerfile -t $(DOCKER_IMG) .


####################################################################
#	make start-env:
#		This starts the ADF docker image. 
#
####################################################################
start-env:
	docker run -it -v $(PWD)/:/repo -v /var/run/docker.sock:/var/run/docker.sock \
		-v /sys/fs/cgroup:/sys/fs/cgroup --privileged $(DOCKER_IMG) bash


####################################################################
#	make push:
#		This pushes the Docker image to $(REMOTE_IMG)
#
####################################################################
push:
	docker tag $(DOCKER_IMG) $(REMOTE_IMG)
	docker push $(REMOTE_IMG)


# This prints make commands and usage
help:
	@$(info ADF)
	@$(info Prerequisites: )
	@$(info 1. GNU BASH version 4.2.46+)
	@$(info 2. GNU Make version 3.82+)
	@$(info 3. Docker version 19.03.12+)
	@$(info -----------------------------------------------------------------------------------------------------------)
	@$(info 1. make build-env:    Creates a Docker image used for building application.)
	@$(info 2. make start-env:    Creates the ADF Docker build environment)
	@$(info -----------------------------------------------------------------------------------------------------------)
	@cat Makefile | sed -n -e '/####/,/#####/ p' | grep -v '###' | sed -e 's/#//g' | grep -v Makefile|grep -v help
