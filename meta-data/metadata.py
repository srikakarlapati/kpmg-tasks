#Before running the script you will need to install azure.identity and azure.mgmt.compute
#pip install azure.identity
#pip install azure.mgmt.compute

from azure.identity import ClientSecretCredential
from azure.mgmt.compute import ComputeManagementClient
from operator import attrgetter
import json

#User inputs

subscription_id = input("What is the subscription id : ")
tenant_id = input("What is the tenant id : ")
client_id = input("What is the client id : ")
client_secret = input("What is the client secret : ")
rg_name = input("What is the RG name? :")
vm_name = input("What is the vm name? :")
data_choice = input("What do you want to fetch? :")

#Creating credential object

credential_object = ClientSecretCredential(
    tenant_id=tenant_id,
    client_id=client_id,
    client_secret=client_secret
)

#Creating compute client object

compute_client_object = ComputeManagementClient(
    credential=credential_object,
    subscription_id=subscription_id
)

#Fetching the VM details using compute client object by passing resource group name and vm name

vm_list = compute_client_object.virtual_machines.get(rg_name, vm_name)

#Converting the data in vm_list object to dictionary
 
vm_metadata = vm_list.as_dict() #as_dict() is specific to Azure SDK

#Converting data in vm_metadata object into json 

vm_metadata_json = json.dumps(vm_metadata)

#Writing the json data in vm_metadata_json object to s json file in path C:\Python\data.json
 
with open(r"C:\Python\data.json", "w") as f:
    f.write(vm_metadata_json)

#Printing all the details of VM

print(vm_list.as_dict())

#Printing the specific detail which user asked for

print(f"\nValue for {data_choice} is : " + attrgetter(data_choice)(vm_list))