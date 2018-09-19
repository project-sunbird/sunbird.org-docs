---
title: Prerequisites
page_title: Server Installation Prerequisites
description: Setting up Sunbird on a server
allowSearch: true

---

## Overview

To install Sunbird you require system admninisrtation rights and must have hands on experience with Linux systems administration and Docker for running containerized services.

Sunbird has been tested on cloud hosted Linux servers (Azure & AWS). Sunbird recommends use of Linux servers and is not tested for its functionalities on any Microsoft® operating systems or virtual machines or in-premise infrastructure, like rack mounted servers or blades. 

This section explains the minimum prerequisites that must be ensured before installing Sunbird on your server

## API Key

* Sunbird requires EkStep API keys to access the EkStep content repository. For details on how to get access the keys, refer [Ekstep API Keys](server_installation/ekstep_keys) to get the keys. If you are creating a test environment, get the QA API keys
<Use the key and secret to generate JWT.  For example: a [web based tool](http://jwtbuilder.jamiekurtz.com/). 
> Note: that when using the tool, the key in the EkStep Developer credentials should be set as the Issuer field and the secret in the Key field>

## Domain Name

* It is recommended that you have a registered domain name 
* If you do not have a domain name, you can configure Sunbird such that it can be accessed over an IP address

## SSL Certificate

* In order to run Sunbird over HTTPS, you will require an SSL certificate. You can obtain one for free from [Let's Encrypt](https://letsencrypt.org/)

## Hosting Requirements

### Cloud Servers

* Supported Providers: Sunbird has been tested for AWS and Azure, You may be able to use Google Compute Platform or similar cloud infrastructure
* A general purpose server with 7 GB RAM on Azure, running Ubuntu server 16.04 LTS
* A general purpose server with 8 GB RAM on AWS, running Ubuntu server 16.04 LTS
* You can scale the infrastructure by adding servers. Sunbird is designed to scale horizontally
* The scripts do not work on virtual machines created using VMware or VirtualBox 

### Cloud Blob Storage
* Sunbird requires an Azure BLOB storage account, for details on creating an account, refer <a href="https://docs.microsoft.com/en-us/azure/storage/common/storage-create-storage-account" target="_blank">Azure storage account</a> 
* This account is used to store QR code images and achievement badges

### Operating System

Ubuntu 16.04 LTS (64 bit)

### Disk Space

* Minimum 20 GB of free disk space

## System Setup

### User Accounts

* Create a regular user account (non-root). The account name should be the same on all the servers
* Configure this user to be able to do passwordless ssh login into all the servers
* Use an empty passphrase while generating the ssh key to avoid password prompts during installation
* Configure that user to have full sudo rights across all servers.

### Ports
The servers communicate with each other using TCP on the following ports

**Mapping Ports**

The following is a list of ports that must be open:

|From server |To server|port| protocol|
|:-----      |:-------|:--------|:------|
|Administration server|All servers|22|TCP|
|ELB/Internet|0.0.0.0|80,443|TCP|
|swarm managers subnet|swarm nodes subnet|All|TCP & UDP|
|swarm nodes|Cassandra servers|9042|TCP|
|swarm nodes|Elasticsearch servers| 9200 |TCP|
|swarm nodes|Postgres servers| 5432|TCP|
|swarm nodes|Keycloak| 8080|TCP|

**Note:** If you setup more than one swarm agent node, you will need to configure a load balancer to spray the incoming requests to all the agent nodes. All agent nodes in a swarm route the request to the right service.


### Utilities
The following package(s) must be available on the machine from which Sunbird installation is to be preformed:

* git

* curl or any application that can invoke REST API