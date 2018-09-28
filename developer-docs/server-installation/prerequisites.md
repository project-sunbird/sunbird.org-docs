---
title: Prerequisites
page_title: Server Installation Prerequisites
description: Prerequisites to set up Sunbird on a server
keywords: prerequisites, set up, setup, server installation, cloud hosting, hosting, 
allowSearch: true

---

## Overview

To install Sunbird, you require system admninisrtation rights and must have hands on experience with Linux system administration and Docker to run containerized services.

Sunbird is tested on cloud hosted Linux servers (Azure & AWS) and hence we recommend use of Linux servers. Sunbird and its functionality is not tested on any Microsoft® operating system, virtual machines or in-premise infrastructure, like rack mounted servers or blades. 

This section explains the minimum prerequisites required to install Sunbird on your server

## API Key

* Sunbird requires EkStep API keys to access the EkStep content repository. For details on how to get access the keys, refer [Ekstep API Keys](server_installation/ekstep_keys). If you are creating a test environment, get the QA API keys
<Use the key and secret to generate JWT.  For example; a [web based tool](http://jwtbuilder.jamiekurtz.com/). 
> Note: that when using the tool, the key in the EkStep Developer credentials should be set as the Issuer field and the secret in the Key field>

## Domain Name

* It is recommended that you have a registered domain name 
* If you do not have a domain name, you can configure Sunbird such that it can be accessed over an IP address

## SSL Certificate

* In order to run Sunbird over HTTPS, you will require an SSL certificate. You can obtain one for free from [Let's Encrypt](https://letsencrypt.org/)

## Hosting Requirements
This section gives you information on the minimum hardware, software and space requirements to host Sunbird.

### Cloud Servers

* Supported Providers: Sunbird has been tested for AWS and Azure. You may be able to use Google Compute Platform or similar cloud infrastructure
  * On Azure, a general purpose server with 7 GB RAM, running Ubuntu server 16.04 LTS
  * On AWS, a general purpose server with 8 GB RAM, running Ubuntu server 16.04 LTS
* You can scale out your infrastructure by adding servers. Sunbird is designed to scale horizontally.
* You can also scale up your infrastructure and deploy the docker containers to a swarm running on a larger host.
* The scripts do not work on virtual machines created using VMware or VirtualBox 

### Cloud Blob Storage
* Sunbird requires an Azure Blob storage account. For details on creating an account, refer <a href="https://docs.microsoft.com/en-us/azure/storage/common/storage-create-storage-account" target="_blank">Azure storage account</a> 
* This account is used to store QR code images and achievement badges

### Operating System

Ubuntu 16.04 LTS (64 bit)

### Disk Space

* Minimum 20 GB of free disk space

## System Setup

This section provides information on the user accounts, ports and utilities required to install Sunbird.

### User Accounts

* Create a regular user account (non-root). The account name should be the same on all servers
* Configure the regular user such that the user can do passwordless ssh login on all servers
* Use an empty passphrase to generate the ssh key to avoid password prompts during installation
* Configure that user to have full sudo rights across all servers.

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

**Note:** If you set up more than one swarm agent node, you will need to configure a load balancer to spray the incoming requests to all the agent nodes. All agent nodes in a swarm route the request to the right service.


### Utilities
Ensure that the following package(s) are available on the machine from which you install Sunbird:

* git

* curl or any application that can invoke REST APIs
