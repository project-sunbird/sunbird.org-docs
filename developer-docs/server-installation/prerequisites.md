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
| LP        | 4core 16G 60G HDD  | 1   |
| DP        | 4core 16G 60G HDD  | 1   |
| Core      | 4core 16G 60G HDD  | 1   |
| DB      | 4core 16G 60G HDD  | 1   |
| Yarn      | 4core 16G 60G HDD  | 2   |
| Load Balancers         |  -   | 5 (Optional)   |

## List of Servers with their Ansible Group Name
<table>
  <tr>
    <th style="width:25%">Module</th>
    <th style="width:25%">Servers</th>
    <th style="width:25%">Service</th>
    <th style="width:25%">Ansible Group Name</th>
  </tr>
  <tr>
    <td>Build and Deploy</td>
    <td>Server-1 (Jenkins)</td>
    <td>Jenkins Master</td>
    <td></td>
  </tr>
  <tr>
    <td rowspan="3">Core</td>
    <td rowspan="3">Server-2 (Docker)</td>
    <td>Docker Manager and Worker</td>
    <td>swarm-manager-1, swarm-agent-for-prometheus-1, swarm-agent-for-alertmanager-1, swarm-bootstrap-manager, swarm-node-1 , swarm-agent-dashboard-1, swarm-dashboard-1</td>
  </tr>
  <tr>
    <td>Logs Elasticsearch</td>
    <td>log-es-1</td>
  </tr>
  <tr>
    <td>Keycloak</td>
    <td>keycloak-1</td>
  </tr>
  <tr>
    <td rowspan="4">Databases</td>
    <td rowspan="4">Server-3 (DB's)</td>
    <td>Cassandra</td>
    <td>cassandra-1, lp-cassandra, dp-cassandra, core-cassandra, cassandra-node-1, cassandra-ps, cassandra</td>
  </tr>
  <tr>
    <td>Postgres</td>
    <td>postgresql-master-1, postgresql-slave-1, postgres</td>
  </tr>
  <tr>
    <td>Application Elasticsearch</td>
    <td>es-1, composite-search-cluster, es-ps, core-es-1</td>
  </tr>
  <tr>
    <td>Neo4j</td>
    <td>learning-neo4j-node1</td>
  </tr>
  <tr>
    <td rowspan="4">Knowledge Platform</td>
    <td rowspan="4">Server-4 (KP Services and Kafka)</td>
    <td>Learning</td>
    <td>learning1, logstash-ps, learning</td>
  </tr>
  <tr>
    <td>Redis</td>
    <td>redis1, lp-redis, redis</td>
  </tr>
  <tr>
    <td>Search</td>
    <td>search1, search</td>
  </tr>
  <tr>
    <td>Kafka</td>
    <td>processing-cluster-kafka, processing-cluster-zookeepers, kafka-ps, kafka-1</td>
  </tr>
  <tr>
    <td rowspan="5">Data Pipeline</td>
    <td rowspan="5">Server-5 (DP Services)</td>
    <td>Spark</td>
    <td>spark</td>
  </tr>
  <tr>
    <td>Analytics</td>
    <td>analytics-api, analytics-ps</td>
  </tr>
  <tr>
    <td>Kafka Indexer</td>
    <td>kafka-indexer</td>
  </tr>
  <tr>
    <td>InfluxDB</td>
    <td>influxdb</td>
  </tr>
  <tr>
    <td>Secor</td>
    <td>secor, secor-ps</td>
  </tr>
  <tr>
    <td rowspan="2">Yarn</td>
    <td>Server-6 (Yarn Master)</td>
    <td>Yarn Master Slave 1</td>
    <td>yarn-master, yarn-slave, yarn-ps</td>
  </tr>
  <tr>
    <td>Server-7 (Yarn Slave)</td>
    <td>Yarn Master Slave 2</td>
    <td>yarn-master, yarn-slave, yarn-ps</td>
  </tr>
</table>


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

