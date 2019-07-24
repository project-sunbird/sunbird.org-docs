---
title: Prerequisites
page_title: Prerequisites
description: Prerequisites to set up Sunbird on a server
keywords: prerequisites, set up, setup, server installation, cloud hosting, hosting, 
allowSearch: true
---

## Overview

Before you install Sunbird in a server environment, make sure that you have the required permissions, servers, hardware, software, accounts and so on. Without these aspects in place, you may face delays that can best be avoided.

### Recommended Permissions and Experience

To efficiently handle Sunbird installation, you need to have:
- System admninistrator permissions on Sunbird and all servers
- Hands-on experience in administering Linux systems
- Hands-on experience using Docker to run containerized services

> **Note:** Sunbird is tested on cloud hosted Linux servers (Azure & AWS). Hence, it is recommended that you use Linux servers. Sunbird and its functionality is not tested on Microsoft® operating systems, or on in-premise infrastructure, like rack mounted servers. The Sunbird installer has a known issue on virtual machines such as those created by VirtualBox or VMWare. 

## Provisioning for Servers 
Before you start the installation process, ensure that you provision for servers to host applications and set up required accounts and repositories as per details provided.

|Application |  Server      |Count|
|------------|--------------|-----| 
| Jenkins |4core 16G 250G HDD| 1|
|LP       | 2core 8G 60G HDD | 2 |
|DP       |2core 8G 60G HDD  | 5 |
| Core    |2core 8G 60G HDD  |2 |
|   |   Load Balancers   |  4 |

2. Private GitHub repository to store Ansible hosts and secrets  
3. Fully Qualified Domain Name(FQDN) with SSL  
4. Azure Storage account   
5. Docker hub account 

## Load Balancer

Load Balancers are required to scale your applications and create a high availability for your services. Balancing the load provides
low latency and high throughput, and scales up to millions of flows for all TCP and UDP applications.

The Load Balancer distributes new inbound flows that arrive on its frontend to backend pool instances, as per rules and health probes that are set.

## Agent Swarm

Do the following Agent-swarm setup: 
- Frontend ip configuration - attach public ip
- Backend pools - attach agent vm's or availability set of agent group
- Health Probes/check - Configure path and port - 80 and 443 (both)
- EX: name: http 
- Protocol: TCP 
- Port: 80 
- Interval: 5 
- Unhealthy threshold: 2
- Load Balancing rules - Frontend-ip-config,Frontend-port,backend-port, Backend-pool and health-probe
- Ex: Frontend-port: 80
- backend-port: 80
> **Note:** Follow similar steps for port 443


## Keycloak Swarm

Do the following Keycloak-swarm setup:
- Frontend ip configuration - Internal ip by default
- Backend pools - attach keycloak vm or availability set of keycloak group
- Health Probes/check - Configure path and port - 8080
- EX: name: keycloakhealth 
- Protocol: TCP 
- Port: 8080 
- Interval: 5 
- Unhealthy threshold: 2
- Load Balancing rules - Frontend-ip-config,Frontend-port, backend-port, Backend-pool and health-probe
- Ex: Frontend-port: 80
- backend-port: 8080


## KP-LB Services

Do the following KP-LB services setup:
- Frontend ip configuration - Internal ip by default
- Backend pools - attach vm's of learning and search or availability set for learning and search
- Health Probes/check - Configure path and port - 8080 (for learning) and 9000 (for search)
- EX: name: learninghealth 
- Protocol: http 
- Port: 8080 
- Path: /learning-service/health
- Interval: 5 
- Unhealthy threshold: 2
- Frontend-port: 8080
- Backend-port: 8080

- Name: searchhealth 
- Protocol: http 
- Port: 9000 
- Path: /health 
- Interval: 5 
- Unhealthy threshold: 2
- Load Balancing rules - Frontend-ip-config,Frontend-port, backend-port, Backend-pool and health-probe
- Ex: Frontend-port: 9000
- backend-port: 9000

## DP-LB Services (Analytics Api)

Do the following DP-LB services setup:
- Frontend ip configuration - Internal ip by default
- Backend pools - attach vm's of analytics-api or availability set for analytics-api group
- Health Probes/check - Configure path and port - 9000
- EX: name: analyticshealth 
- Protocol: tcp 
- Port: 9000 
- Interval: 5 
- Unhealthy threshold: 2
- Load Balancing rules - Frontend-ip-config,Frontend-port, backend-port, Backend-pool and health-probe
- Ex: Frontend-port: 9000
- Backend-port: 9000

## API Key

* Sunbird requires EkStep API keys to access the EkStep content repository. For details on how to get access the keys, refer [Ekstep API Keys](server_installation/ekstep_keys). If you are creating a test environment, get the QA API keys
Use the key and secret to generate JWT.  For example; a [web based tool](http://jwtbuilder.jamiekurtz.com/). 

> **Note:** When using the tool, set the key in the EkStep Developer credentials as the Issuer field and the secret in the Key field

## Domain Name

* It is recommended that you have a registered domain name through which you can access your Sunbird instance
* If you do not have a domain name, you can configure Sunbird such that it can be accessed over an IP address

## SSL Certificate

* In order to run Sunbird over HTTPS, you will require an SSL certificate. You can obtain one for free from [Let's Encrypt](https://letsencrypt.org/)

## Hosting Requirements
This section gives you information on the minimum hardware, software and space requirements to host Sunbird.

### Cloud Servers

* Supported Providers: Sunbird has been tested for AWS and Azure. You may be able to use the Google Compute Platform or similar cloud infrastructure.
  * On Azure, general purpose servers with 7 GB RAM, running Ubuntu server 16.04 LTS
  * On AWS, general purpose servers with 8 GB RAM, running Ubuntu server 16.04 LTS
* You can scale out your infrastructure by adding servers. Sunbird is designed to scale horizontally.
* You can also scale up your infrastructure and deploy the docker containers to a swarm running on a larger host.
* The scripts timeout and do not complete when they are run on virtual machines created using VMware or VirtualBox 

### Operating System

Ubuntu 16.04 LTS (64 bit)

### Disk Space

* Minimum 20 GB of free disk space

### Cloud Blob Storage
If you require to store QR code images or badges or any other such information, Sunbird requires an Azure Blob storage account.
> **Note** For details on creating an account, refer <a href="https://docs.microsoft.com/en-us/azure/storage/common/storage-create-storage-account" target="_blank">Azure storage account</a> 

## System Setup

This section provides information on the user accounts, ports and utilities required to install Sunbird.

### User Accounts

* Create a non-root user account on all servers. The account name should be the same on all servers.
* Setup SSH keys for the user account such that the user can do SSH without a password on all servers
  * Users should be able to SSH without password from app server(s) to db server(s) and vice-versa
  * Use an empty passphrase when generating the SSH key to avoid password prompts during installation
* Configure the user to have full sudo rights across all servers

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

> **Note:** If you set up more than one swarm agent node, you will need to configure a load balancer to spray the incoming requests to all the agent nodes. All agent nodes in a swarm route the request to the right service.


### Utilities
Ensure that the following package(s) are available on the machine from which you install Sunbird:

* git
* curl or any application which can invoke REST APIs
