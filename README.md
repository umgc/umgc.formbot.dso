# Advance Development Factory - Golang version
---
As part of a diverse ecosystem of applications and technologies within software development, a need has been identified that standardizes the building, testing, and deployment of an organization's application suite. The Advance Development Factory provides a framework for developers to build, test, and deploy applications under a common environment that mitigates needs for dependencies configuration.

https://github.com/umgc/umgc.advance.development.factory

UPDATED:

Version for Golang, Spring 2021

Vincent Leung, vleung1@student.umgc.edu

Ivy Pham, ipham@student.umgc.edu


#### Capabilities
---
The ADF has a few components:
- Dockerfile
	- Configures the container, including all the dependencies required by other students.
	- If development teams have a dependency not covered by ADF, that dependency could be installed here using the Docker image's package manager 
- azure-pipelines.yml
	- Defines the Azure build pipeline, which automates the Docker image build and push process via Azure DevOps tasks
- deployment.azure.yaml
	- Defines the Azure release pipeline, which automates the ADF deployment to an Azure Kubernetes cluster
- Makefile
	- Carryover from original version- can be used for manual execution of build and deployment
	- Defines recipes for every step in the build/deploy process
	- ADF only needs three steps:
		- 'make build-env' (creates the ADF Docker image)
		- Log in to docker.io
		- 'make push' (pushes the created Docker image to Docker Hub repository)


#### How to use
---
Required:
- git – Source control (Note: every developer is required to use git)
- Linux – Our operating system (MacOS will also suffice)
- Bash [version 4.2 or greater]  – Our shell 
- Docker [version 19.03 or greater] – Containerization
- Azure CLI (recommended)
- Accompanied configured Azure DevOps build and release pipelines
- Make [version 3.82 or greater] – Build tool, which can run the below:

This builds the ADF Docker image:  
**~$ make build-env**  

Expected Output:  
**#=> => naming to docker.io/library/advance-development-factory-formbot-dialogflow:latest**

This starts the ADF Docker image:  
**~$ make start-env**  

You will now be in the docker container  
**[root@ba85cf5a7a50 repo]#**  

You can type "exit" to exit the docker container

This pushes the ADF Docker image to docker.io:  
**~$ make push**  

