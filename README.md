# Advance Development Factory
---
As part of a diverse ecosystem of applications and technologies within software development, a need has been identified that standardizes the building, testing, and deployment of an organization's application suite. The Advance Development Factory sets the standard for developers to build, test, and deploy a diverse set of applications under a common framework that mitigates client operating environment dependencies.

Update:
Extension for JavaScript, Spring 2021

#### Capabilities
---
The ADF could be thought of as three separate working components:
- Dockerfile
	- Configures the container, including all the dependencies required by other students.
	- If development teams have a dependency not covered by ADF, that dependency could be installed here using yum 
- azure-pipelines.yml
	- Used by Azure. Defines the pipeline, which runs our make recipes.
	- ADF only needs three steps:
		- make build-env
		- Log in to docker.io
		- make push
- Makefile
	- We use make to define recipes for every step in the build process.

#### How to use
---
Required:
- git – Source control (Note: every developer is required to use git)
- Linux – Our Operating system (OSX will also suffice)
- Bash [version 4.2 or greater]  – Our shell 
- Make [version 3.82 or greater] – Build automation tool
- Docker [version 19.03 or greater] – Containerization

This builds the ADF Docker image:  
**~$ make build-env**  
Expected Output:  
**#	Successfully built d540a0f3160f**  
**# Successfully tagged advance-development-factory:latest**

This starts the ADF docker image:  
**~$ make start-env**  
You will now be in the docker container  
**[root@ba85cf5a7a50 repo]#**  
You can type "exit" to exit the docker container

