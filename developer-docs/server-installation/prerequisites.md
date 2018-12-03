---
title: Prerequisites
page_title: Server Installation Prerequisites
description: Prerequisites to set up Sunbird on a server
keywords: prerequisites, set up, setup, server installation, cloud hosting, hosting, 
allowSearch: true

---

## Overview

To install Sunbird in a server environment, you will require system admninisrtation rights and should have hands-on experience administering Linux systems and using Docker to run containerized services.

Sunbird is tested on cloud hosted Linux servers (Azure & AWS) and hence we recommend use of Linux servers. Sunbird and its functionality is not tested on Microsoft® operating systems, or on in-premise infrastructure, like rack mounted servers. The Sunbird installer has a known issue on virtual machines such as those created by VirtualBox or VMWare. 

Before starting the installation process, complete these pre-requisites. 

## API Key

* Sunbird requires EkStep API keys to access the EkStep content repository. For details on how to get access the keys, refer [Ekstep API Keys](developer-docs/server-installation/ekstep_keys). If you are creating a test environment, get the QA API keys

Use the key and secret to generate JWT.  For example; a [web based tool](http://jwtbuilder.jamiekurtz.com/). 
> Note: that when using the tool, the key in the EkStep Developer credentials should be set as the Issuer field and the secret in the Key field>

## Domain Name

* It is recommended that you have a registered domain name through which you can access your Sunbird instance
* If you do not have a domain name, you can configure Sunbird such that it can be accessed over an IP address. If you are accessing your Sunbird installation over an IP address, use http rather than https during the installation configuration.

## SSL Certificate

* In order to run Sunbird over HTTPS, you will require an SSL certificate. You can obtain one for free from [Let's Encrypt](https://letsencrypt.org/). The free certificate needs to be renewed every 3 months and there are ways to setup auto renewal.

## Hosting Requirements
This section gives you information on the minimum hardware, software and space requirements to host Sunbird.

### Cloud Servers

* Supported Providers: Sunbird has been tested for AWS and Azure. You may be able to use Google Compute Platform or similar cloud infrastructure
  * On Azure, general purpose servers with 7 GB RAM, running Ubuntu server 16.04 LTS
  * On AWS, general purpose servers with 8 GB RAM, running Ubuntu server 16.04 LTS
* You can scale out your infrastructure by adding servers to the Docker swarm. Sunbird is designed to scale horizontally.
* You can also scale up your infrastructure and deploy the docker containers to a swarm running on a larger host.
* There are known issues when the installation scripts are run on virtual machines created using VMware or VirtualBox 

### Operating System

Ubuntu 16.04 LTS (64 bit)

### Disk Space

* Minimum 20 GB of free disk space

### Cloud Blob Storage
* Sunbird requires an Azure Blob storage account. For details on creating an account, refer <a href="https://docs.microsoft.com/en-us/azure/storage/common/storage-create-storage-account" target="_blank">Azure storage account</a> 
* Create a container named dial in the storage account
* This account is used to store QR code images and achievement badges

## System Setup
This section provides information on the user accounts, ports and utilities required to install Sunbird.

### Setting up user accounts on the servers

* Create a user account on all servers with passwordless sudo access. The account name should be the same on all servers. 
* Setup SSH keys for the user account such that the user can do passwordless ssh between servers.

This user account and the ssh key will be used during the installation process by Ansible to login to the servers to install and configure the required software.

Given below is an example of how to create a user with name, Sunbird, and generate public & private keys and assign sudo rights. This example has been verified on an Azure VM running Ubuntu 16.04.

##### Setup the user with password less ssh & sudo access on the designated app server VM 
 
- SSH to the cloud VM designated as the application server using the SSH keys setup during VM creation
- Create a user. Instructions on creating a user is explained in the later part of this section  
- `su - sunbird`. Switch to the user that was just created. You are prompted for the password that was setup while creating the linux user
- `ssh-keygen`. This command creates a private & public key (default folder is /home/sunbird/.ssh/). Leave the passphrase empty when prompted. The public key is called id_rsa.pub and the other file(id_rsa) contains the private key
- Copy the output of running the following command `cat /home/sunbird/.ssh/id_rsa.pub`. This is the public key. PAste this key in the consecutive command
- `echo COPIED_PUBLIC_KEY_STRING >> /home/sunbird/.ssh/authorized_keys`. COPIED_PUBLIC_KEY_STRING must be replaced by the public key generated by running the preceding command
> **Note**: The installation script is later executed from this machine 

##### Setup the user with password less ssh & sudo access on the other VMs
- SSH to the other cloud VMs using the SSH key setup during VM creation. This user has sudo access and can create other users
- Create a user. Instructions on creating a user is explained in the later part of this section 
- `su - sunbird`. You are prompted for the password that was setup while creating the linux user
- mkdir -p /home/sunbird/.ssh
- `echo COPIED_PUBLIC_KEY_STRING >> /home/sunbird/.ssh/authorized_keys`. COPIED_PUBLIC_KEY_STRING must be replaced by the public key copied after the ssh-key generation step

##### Create user 
These commands create a user and provides passwordless sudo access for this user. Username here is assumed as sunbird

- `sudo adduser sunbird` //This adds a linux user with a password
- `sudo usermod` -aG sudo sunbird //Providing the newly created user with sudo access
- `sudo visudo` //This opens the sudoers file in nano editor. Hands-on familiarity with Nano would aid in the process
- Add the following entry as the last line in the sudoers file //This step is to allow the user to sudo without a  password 
sunbird     ALL=(ALL) NOPASSWD: ALL
- Click Ctrl + O to save
- Click Ctrl + X to exit nano editor

### Ports
The servers communicate with each other using TCP on the following ports. Ensure that the ports are mapped and open as per the table provided to avoid communication errors between the servers.   

**Mapping Ports**

|From server |To server|port| protocol|
|:-----      |:-------|:--------|:------|
|Administration server|All servers|22|TCP|
|ELB/Internet|0.0.0.0|80,443|TCP|
|swarm managers subnet|swarm nodes subnet|All|TCP & UDP|
|swarm nodes|Cassandra servers|9042|TCP|
|swarm nodes|Elasticsearch servers| 9200 |TCP|
|swarm nodes|Postgres servers| 5432|TCP|
|swarm nodes|Keycloak| 8080|TCP|

> **Note:** If you set up more than one swarm agent node, configure a load balancer to spray the incoming requests to all the agent nodes. The domain name you setup earlier should route to the load balancer as well. All agent nodes in a swarm can route the request to the right service.

### Utilities
Ensure that the following package(s) are available on the machine from which you install Sunbird:

* git
* curl or any application which can invoke REST APIs
