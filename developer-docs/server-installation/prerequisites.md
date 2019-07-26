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

## Provisioning Servers 
Before you start the installation process, ensure that you provision for servers to host applications and set up required accounts and repositories as per details provided.

|Application |  Server      |Count|
|------------|--------------|-----| 
| Jenkins |4core 16G 250G HDD| 1|
|LP       | 2core 8G 60G HDD | 2 |
|DP       |2core 8G 60G HDD  | 5 |
| Core    |2core 8G 60G HDD  |2 |
|   |   Load Balancers   |  4 |

## Other Requirements
1. Private GitHub repository to store Ansible hosts and secrets  
2. Fully Qualified Domain Name(FQDN) with SSL  
3. Azure Storage account   
5. Docker hub account 

