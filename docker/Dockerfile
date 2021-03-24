FROM golang

# Spring 2021
# Vincent Leung, vleung1@student.umgc.edu
# Ivy Pham, ipham@student.umgc.edu

# git, make, which, wget are pre-installed in the golang image

# Install Docker repository to install from (Debian based)
RUN apt-get update
RUN apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
RUN echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null


# Install Docker engine
RUN apt-get update
RUN apt-get install -y docker-ce docker-ce-cli containerd.io


# Install Azure CLI repository to install from
RUN apt-get update
RUN apt-get install ca-certificates curl apt-transport-https lsb-release gnupg
RUN curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null
RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ buster main" | tee /etc/apt/sources.list.d/azure-cli.list


# Install Azure CLI
RUN apt-get update
RUN apt-get install azure-cli


# Install helm repository to install from
RUN curl https://baltocdn.com/helm/signing.asc | apt-key add -
RUN apt-get install apt-transport-https --yes
RUN echo "deb https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list


# Install helm 
RUN apt-get update
RUN apt-get install helm


# Install kubectl repository to install from
RUN apt-get update && apt-get install -y apt-transport-https gnupg2
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list


# Install kubectl
RUN apt-get update
RUN apt-get install -y kubectl


# Create and set working directory
RUN mkdir repo
WORKDIR /repo