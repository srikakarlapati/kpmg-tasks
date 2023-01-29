for getting metadata of resources in azure we have some SDKs in python
by using these SDKs we can create resources in azure, update resources and retrieve the data from azure portal.
pre-requisites to use these sdks:
	Python 3.7+ is required to use this package.
	Azure subscription
Use the Azure libraries (SDK) for Python:
The open-source Azure libraries for Python simplify provisioning, managing, and using Azure resources from Python application code.
azure.identity
azure-mgmt-compute
we need to install these libraries using pip
pip install azure-mgmt-compute
pip install azure-identity

here we are using ClientSecretCredential and ComputeManagementClient classes for getting metadata from the resources that are deployed on azure.
ClientSecretCredential: used to authenticate Python to allow for retrieving Azure resources
ComputeManagementClient: used to work with azure compute resources with python.
We follow below seeps to get data:
1)	Creating credentials object from ClientSecretCredential
2)	Creating compute client object from ComputeManagementClient
3)	Fetching vm details by passing resource group name and vm name to compute client object and storing those values in a dictionary
4)	After that we convert those dct values to json form by using json.dump function.
5)	We can parse that json file and print those values 
