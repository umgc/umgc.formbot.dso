

BUILD_ENV_NAME=advance-development-factory
BUILD_ENV_TAG=latest
BUILD_IMG=$(BUILD_ENV_NAME):$(BUILD_ENV_TAG)

##############################################################
#	make build-env:
#
##############################################################
build-env:
	docker build -f ./docker/Dockerfile.build -t $(BUILD_IMG) .


##############################################################
#	make start-env:
#		This recipe starts the Docker build env image 
#
##############################################################
start-env:
	docker run -it -v $(PWD)/:/repo -v /var/run/docker.sock:/var/run/docker.sock \
		-v /sys/fs/cgroup:/sys/fs/cgroup --privileged $(BUILD_IMG) bash
