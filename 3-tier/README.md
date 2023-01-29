
A 3-tier environment is a common setup. Use a tool of your choosing/familiarity create these resources. Please remember we will not be judged on the outcome but more focusing on the approach, style and reproducibility

SOLUTION

I have created 3-tier application in Azure using Terraform. Three modules are created for each tier. We can seperate resource based on resource type like network.tf for vnet,subnet, NSG and lb.tf for loadbalancer etc.  but for time being I have kept all in one tf files.

3 Tier Architecture Diagram 

### Tier-1
Tier-1 (web tier) consist of following Azure resources -
- Subnet for web tier
- Public Load Balancer
- 2 VM's in Availability set for HA
- NSG to allow inbound traffic to VM's

### Tier-2
Tier-2 (app tier) consist of following Azure resources
- Subnet for app tier
- Private Load Balancer
- 2 VM's in Availability set for HA
- NSG to allow inbound traffic to VM's

### Tier-3
Tier-3 (DB tier) consist of following Azure resources -
- Subnet for Database
- NSG to allow traffic from application tier
- Azure SQL Server
- Azure SQL Database
- Private Endpoint to connect DB server with app-tier without going to internet
