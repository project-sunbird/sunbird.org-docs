---
title: Prerequisites
page_title: Prerequisites
description: Prerequisites to set up Sunbird on a server
keywords: prerequisites, set up, setup, server installation, cloud hosting, hosting
allowSearch: true
---

## Overview

Sunbird is a complex system and the installation is not a simple task. There is no one click button. We are actively working on making the sunbird setup easier and simpler. If you have a query / issue / feedback, connect with us at [Sunbird Community](https://github.com/project-sunbird/sunbird-community/discussions).

### Recommended Permissions and Experience

To successfully complete Sunbird installation, you need to have:

- System administrator permissions on and all servers
- Hands-on experience in administering and debugging Linux systems
- Hands-on experience using Docker and Kubernetes to run containerized services

> **Note:** Sunbird is tested only on cloud hosted Ubuntu servers in Azure. We do not provide any support for installing Sunbird on other operating systems. Sunbird might work on other cloud providers, feel free to try it out and let us know. We are actively working on achieving cloud neutrality.

### Provisioning Servers

Before you start the installation process, ensure that you have the required infrastructure mentioned below. It is the bare minimum for a full fledged Sunbird setup. Every component in Sunbird can scale horizontally / vertically by adding additional resources.

|Application|  Server           |Count|
|-----------|-------------------|-----|  
|Jenkins    | 4core 16G 250G HDD | 1 |
| KP        | 4core 16G 60G HDD | 1 |
| DP        | 4core 16G 60G HDD | 1 |
| DB        | 4core 16G 60G HDD   | 1 |
| Yarn      | 4core 16G 60G HDD | 1 |
| Other Services | 4core 16G 60G HDD | 1 |
| Basic Load Balancers | - | 2 (Optional) |

### Infra Requirements

- Kubernetes Cluster with 4 worker nodes
- Private GitHub repository to store ansible inventory
- Fully Qualified Domain Name (FQDN) with SSL
- Azure Storage account
- Docker hub account
- Public IP
- Google Oauth Credentials
- Google V3 Recaptcha Credentials
- Maxmind city database (free or paid)
- A SMTP account (any email provider works, except Gmail for now)
- All ports must be open for internal communication (Azure Virtual Network or AWS VPC) between the VMs
- Internet and outbound access from VMs
- A sms service provider API Token (optional)
- YouTube API Token (optional)
- Slack account and slack bot with API Token (optional)

### Creating the AKS cluster

> **Note**  Follow the steps given below to create the Kubernetes cluster in Azure. For other clouds, please visit the respective cloud provider website
The AKS cluster and VM's should be in same vnet. If they are in different vnet, you have to peer the vnets. To successfully peer, the IP address of the vnets should not overlap.

- Create a service principal and assign contributor role to service principal
- Get the secrets and client id of service principal
- Click [here](https://docs.microsoft.com/en-us/cli/azure/create-an-azure-service-principal-azure-cli) for more details
- Create the AKS cluster either via Azure portal or using `az aks` command line
- Refer to Azure documentation for all the available options
- Below is a sample command which you can use -

 ```bash
az aks create --resource-group <resouse-group-name> --node-resource-group <k8s-resource-group-name> --name <cluster name>  --node-count 4 --admin-username deployer --kubernetes-version 1.19.9 --service-principal "<service principal id>" --node-vm-size Standard_D4s_v3 --client-secret "<client id>" --network-plugin azure --ssh-key-value @deployer.pub -l <region> --vm-set-type VirtualMachineScaleSets --vnet-subnet-id /subscriptions/<subscription id>/resourceGroups/<resouse-group-name>/providers/Microsoft.Network/virtualNetworks/<vnet-name>/subnets/<subnet name>
```

> Note: Ensure you have allocated at least 1024 IP's for your Kubernetes subnet (CIDR notation as x.x.x.x/22)

Get the kubeconfig file for your cluster with the below command -

```bash
az aks get-credentials --resource-group <resource group name> --name <cluster name> --file  k8s.yaml
```

### Configuring the Azure storage account

- Update the CORS rule for the storage account as follows:

 ```bash
    Allowed Origins: *
    Allowed Methods: GET,HEAD,OPTIONS, PUT
    Allowed Headers: Access-Control-Allow-Origin,Access-Control-Allow-Method,Origin,x-ms-meta-qq,x-ms-blob-type,x-ms-blob-content-type,Content-Type
    Exposed Headers: Access-Control-Allow-Origin,Access-Control-Allow-Methods
    Max Age: 200

 ```
 
- Disable **Secure transfer required** in storage account configuration
