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
- System administrator permissions on Sunbird and all servers
- Hands-on experience in administering Linux systems
- Hands-on experience using Docker to run containerized services

> **Note:** Sunbird is tested on cloud hosted Linux servers (Azure & AWS). Hence, it is recommended that you use Linux servers. Sunbird and its functionality is not tested on Microsoft® operating systems, or on in-premise infrastructure, like rack mounted servers. The Sunbird installer has a known issue on virtual machines such as those created by VirtualBox or VMWare. 

## Provisioning Servers 
Before you start the installation process, ensure that you provision for servers to host applications and set up required accounts and repositories as per details provided.

|Application|  Server           |Count|
|-----------|-------------------|-----| 
| Jenkins   | 4core 16G 250G HDD| 1   |
| LP        | 2core 8G 60G HDD  | 1   |
| DP        | 2core 8G 60G HDD  | 1   |
| Core      | 2core 8G 60G HDD  | 1   |
| Database  | 2Core 8G 50G HDD  | 1   |
|           | Load Balancers    | 4   |

## Other Requirements

1.Private GitHub repository to store Ansible hosts and secrets  
2.Fully Qualified Domain Name (FQDN) with SSL  
3.Azure Storage account   
5.Docker hub account   
6.A Public IP  
7.Security:  
- All ports must be open in internal networks (Azure-Vnet or AWS-VPC) for internal comumnication between the VMs
- External ports must be open from the Proxy or load balancer, following ports should open to public
   - 80 (0.0.0.0) inbound
   - 443 (0.0.0.0) inbound
- By default, all the outbound ports are allowed for public access from the VM. 

