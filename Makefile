##############################################################
# Makefile for building and testing
##############################################################

# Run make SKIP_TEST=y
SKIP_TESTS:=

REPO_NAME=$(shell basename $(shell git rev-parse --show-toplevel))

# Application/Docker Vars
VERSION:=1.0.$(shell git rev-list HEAD | wc -l)
APPLICATION_JAR=$(REPO_NAME)-1.0.0.jar
DOCKER_IMG=$(REPO_NAME):$(VERSION)
REMOTE_IMG:=docker.io/umgccaps/$(DOCKER_IMG)

# Maven options
MAVEN_OPTS:=-Dversion=$(VERSION)


# Skip test flag
# make all SKIP_TESTS=y <- doest not run unit tests
ifdef SKIP_TESTS
	MAVEN_OPTS:=$(MAVEN_OPTS) -Dmaven.test.skip=true
endif  

export $(REMOTE_IMG)

# PHONY 
.PHONY: 
	
target/$(APPLICATION_JAR):	
	mvn $(MAVEN_OPTS) package -f pom.xml

build-app: target/$(APPLICATION_JAR)
	cp target/$(APPLICATION_JAR) ./$(APPLICATION_JAR)
	docker build -f ./docker/Dockerfile --build-arg VERSION=$(VERSION) \
		--build-arg APPLICATION_JAR=$(APPLICATION_JAR) -t $(APP_IMG) .
	rm -rf ./$(APPLICATION_JAR)

start-app:
	docker run --rm --name $(APP_NAME) -p 5000:5000 --mount source=h2data,target=/data $(APP_IMG)

push:
	docker tag $(APP_IMG) $(REMOTE_IMG)
	docker push $(REMOTE_IMG)

clean:
	@mvn $(MAVEN_OPTS) clean -f pom.xml


# This prints make commands and usage
help:
	@$(info For new environment setup follow the below steps)
	@$(info Prerequisites: )
	@$(info 1. GNU Make version 3.82)
	@$(info 1. Docker version 19.03.12)
	@$(info -----------------------------------------------------------------------------------------------------------)
	@$(info 1. make build-env:    Creates a Docker image used for building the VLOL application.)
	@$(info                       Note: This only needs to be done once takes ~3m)
	@$(info 2. make all:          Creates the VLOL application using the Docker image created in the previous step.)
	@$(info 2. make build-vlol:   Creates a VLOL Docker image from the artifact created in the previous step.)
	@$(info 3. make start-vlol:   Starts the VLOL Docker image.)
	@$(info -----------------------------------------------------------------------------------------------------------)
	@$(info )
	@$(info Azure development deployment steps)
	@$(info 1. make build-env:     Only needed if user has not previously done so)
	@$(info 2. make start-env:     Starts the build-env Docker context)
	@$(info 1. az login            Navigate to the url and enter the code from the CLI output)
	@$(info 2. make dev-deploy     This creates a container instances with the VLOL application deployed)
	@$(info )
	@$(info Optional CLI)
	@$(info SKIP_TESTS=y/n        Skips running unit tests)
	@$(info REMOTE_IMG=y/n        Overrides Docker image to deploy to Azure container instances)
	@$(info )
	@$(info Available Make commands)
	@cat Makefile | sed -n -e '/####/,/#####/ p' | grep -v '###' | sed -e 's/#//g' | grep -v Makefile|grep -v help
