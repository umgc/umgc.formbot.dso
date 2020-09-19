##############################################################
# Makefile for Advance Development Factory (ADF)
##############################################################

# Build vars
BUILD_ENV_NAME=advance-development-factory
BUILD_ENV_TAG=latest
BUILD_IMG=$(BUILD_ENV_NAME):$(BUILD_ENV_TAG)
DOCKER_IMG=$(REPO_NAME):$(VERSION)
REMOTE_IMG:=docker.io/umgccaps/$(DOCKER_IMG)
UUID:=$(shell cat user.uuid 2> /dev/null || (uuidgen | sed s/'-'/''/g | head -c 10 \
		| tr A-Z a-z > user.uuid && cat user.uuid))


# PHONY
.PHONY: build-env start-env push clean


####################################################################
#	make build-env:
#		This builds 
#
####################################################################
build-env:
	docker build -f ./Docker/Dockerfile -t $(BUILD_IMG) .


####################################################################
#	make build-env:
#		This builds 
#
####################################################################
start-env:
	docker run -it -v $(PWD)/:/repo -v /var/run/docker.sock:/var/run/docker.sock \
		-v /sys/fs/cgroup:/sys/fs/cgroup --privileged $(BUILD_IMG) bash


####################################################################
#	make build-env:
#		This builds 
#
####################################################################
push:
	docker tag $(BUILD_IMG) $(REMOTE_IMG)
	docker push $(REMOTE_IMG)


####################################################################
#	make build-env:
#		This builds 
#
####################################################################
clean:
	@mvn $(MAVEN_OPTS) clean -f pom.xml


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
