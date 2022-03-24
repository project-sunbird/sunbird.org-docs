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


#### Automation on Azure infrastructure creation

You can run the following steps to create azure infrastructure using ansible.

Easiest way to use the script will be to use azure cloud shell, as the cloud shell comes with all prerequisites bundled.
- login to portal.azure.com
- click on the cloudshell -> select bash ( if you're using it for the first time )

If you want to run this on your local machine, Follow this [guide](https://docs.microsoft.com/en-us/azure/developer/ansible/install-on-linux-vm?tabs=azure-cli#install-ansible-on-the-virtual-machine).


#### Create service principal for kubernetes cluster

Command to create SP:
```
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<your_subscription_id>" --name NameOfSP

# Note down the output of above command, we will need those to fill-up some variables in the ansible playbook
```


#### Clone the repo and go to deploy directory

```
git clone https://github.com/project-sunbird/sunbird-devops -b release-4.7.0

cd sunbird-devops/deploy
```


####  Update variables in azure-provision.yaml file

```
version: "ChangeThis"  # sunbird version Ex: 4.7.0
sp_client_id: "ChangeThis"  # substitute the value of `appId` from the output of the create SP command
sp_client_secret: "ChangeThis"  # substitute the value of `password` from the output of the create SP command
ssh_public_key_file_location: "ChangeThis"  # path to your ssh public key Ex: /home/sunbird/.ssh/my_pub.key
```

#### Run the playbook
```
ansible-playbook -c local azure-provision.yaml

# Resulting infrastructure infromation will be stored in sunbird-devops/deploy/azure-resources.txt file.
```
