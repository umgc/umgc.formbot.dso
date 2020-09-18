	
# Unique ID used for devel Azure deployments
UUID_FILENAME:=user.uuid
UUID:=$(shell cat $(UUID_FILENAME) 2> /dev/null || (uuidgen | sed s/'-'/''/g | head -c 10 \
         | tr A-Z a-z > $(UUID_FILENAME) && cat $(UUID_FILENAME)))


dev-deploy: 
	@az group create --name devTestGroup --location eastus
	@az deployment group create --resource-group devTestGroup \
			--template-file azure/deploy-template.json \
			--parameter azure/deploy-parameters.json \
			--parameter imageName=$(REMOTE_IMG) \
			--parameter dnsNameLabel=$(UUID) 
	@$(info $(REMOTE_IMG) deployed to $(UUID).eastus.azurecontainer.io)
	@$(info This may take a few minutes to respond)


##############################################################
#	make stop-deploy:
#		This stops the Azure container instances.
#
##############################################################
stop-deploy:
	@az group delete --name devTestGroup