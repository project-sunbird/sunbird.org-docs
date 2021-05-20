---
title: Prerequisites
page_title: Prerequisites
description: Prerequisites to set up Sunbird on a server
keywords: prerequisites, set up, setup, server installation, cloud hosting, hosting, 
allowSearch: true
---

## Overview

Before you install Sunbird in a server environment, make sure that you have the required permissions, servers, hardware, software, accounts and so on. Without these aspects in place, you may face delays that can best be avoided.

Sunbird is a complex system and the installtion is not a simple task. There is no one click button. We are actively working on making the sunbird setup easier and simpler. If you have a query / issue / feedback, connect with us at [Sunbird Community](https://github.com/project-sunbird/sunbird-community/discussions) and let us know by opening a discussion.

### Recommended Permissions and Experience

To successfully complete Sunbird installation, you need to have:

- System administrator permissions on and all servers
- Hands-on experience in administering and debugging Linux systems
- Hands-on experience using Docker and Kubernetes to run containerized services

> **Note:** Sunbird is tested only on cloud hosted Ubuntu servers in Azure. We do not provide any support for installing Sunbird on other operating systems. Sunbird might work on other cloud providers, feel free to try it out and let us know. We are actively working on achieving cloud neutrality.

## Provisioning Servers

Before you start the installation process, ensure that you have all of the below required infrastructure. This below infrastructure is the bare minimum for a full fledged Sunbird setup. Every component in Sunbird can scale horizontally / vertically by adding more resources.

|Application|  Server           |Count|
|-----------|-------------------|-----|  
|Jenkins    | 4core 16G 250G HDD | 1   |
| KP        | 4core 16G 60G HDD | 1   |
| DP        | 4core 16G 60G HDD | 1   |
| DB        | 4core 16G 60G HDD   | 1   |
| Yarn      | 4core 16G 60G HDD | 1   |
| Other Services     | 4core 16G 60G HDD | 1  |
| Basic Load Balancers         |  -   | 2 (Optional)   |

## List of Servers with their Ansible Group Names

<table>
  <tr>
    <th style="width:25%">Module</th>
    <th style="width:25%">Servers</th>
    <th style="width:25%">Service</th>
    <th style="width:25%">Ansible Group Names</th>
  </tr>
  <tr>
    <td>Build and Deploy</td>
    <td>Server-1</td>
    <td>Jenkins Master</td>
    <td></td>
  </tr>
  <tr>
    <td rowspan="5">Databases</td>
    <td rowspan="5">Server-2</td>
    <td>Cassandra</td>
    <td>cassandra-1, lp-cassandra, dp-cassandra, core-cassandra, report-cassandra, cassandra-node-1, cassandra</td>
  </tr>
  <tr>
    <td>Postgres</td>
    <td>postgresql-master-1, postgresql-master, postgres</td>
  </tr>
  <tr>
    <td>Application Elasticsearch</td>
    <td>es-1, composite-search-cluster, core-es-1, core-es, es-backup, es</td>
  </tr>
  <tr>
    <td>Neo4j</td>
    <td>learning-neo4j-node1, learning-neo4j-cluster</td>
  </tr>
  <tr>
    <td>Mongo</td>
    <td>mongo_master, mongo</td>
  </tr>
  <tr>
    <td rowspan="4">Knowledge Platform</td>
    <td rowspan="4">Server-3</td>
    <td>Learning</td>
    <td>learning1, learning, learningall</td>
  </tr>
  <tr>
    <td>Redis</td>
    <td>redis1, redis, redis-ps,  redisall, lp-redis, lp-redis-ps, dp-redis, lms-redis, redis-exporter-targets</td>
  </tr>
  <tr>
    <td>Zookeeper</td>
    <td>processing-cluster-zookeepers, ingestion-cluster-zookeeper, raw-zookeeper, zookeeper</td>
  </tr>
  <tr>
    <td>Kafka</td>
    <td>processing-cluster-kafka, ingestion-cluster-kafka, kafka-1, kafka</td>
  </tr>
  <tr>
    <td rowspan="5">Data Pipeline</td>
    <td rowspan="5">Server-4</td>
    <td>Spark</td>
    <td>spark</td>
  </tr>
  <tr>
    <td>Kafka Indexer (Logstash)</td>
    <td>kafka-indexer</td>
  </tr>
  <tr>
    <td>InfluxDB</td>
    <td>influxdb</td>
  </tr>
  <tr>
  <tr>
    <td>Keycloak</td>
    <td>keycloak-1, keycloak</td>
  </tr>
    <td rowspan="1">Yarn</td>
    <td>Server-5</td>
    <td>Yarn Master and Slave</td>
    <td>yarn-master, yarn-slave, yarn</td>
  </tr>
  <tr>
    <td rowspan="2">Other Services</td>
    <td rowspan="2">Server-6</td>
    <td>Druid</td>
    <td> druid-postgres, raw-coordinator, raw-overlord, raw-broker, raw-historical, raw-middlemanager, raw-graphite, rollup-coordinator, dp-druid-broker, broker, coordinator, druid-raw
    </td>
  </tr>
  <tr>
    <td>Logs Elasticsearch</td>
    <td>log-es-1, log-es-backup, log-es</td>
  </tr>
</table>



## Infra Requirements

- Kubernetes Cluster with 4 worker nodes
- Private GitHub repository to store ansible inventory
- Fully Qualified Domain Name (FQDN) with SSL
- Azure Storage account
- Docker hub account
- Public IP(s) (one or two depending on your use case)
- Google Oauth Credentials
- Google V3 Recaptcha Credentials
- A SMTP account (any email provider works, except Gmail)
- All ports must be open in internal networks (Azure-Vnet or AWS-VPC) for internal comumnication between the VMs
- Internet and Outbound access from VMs
- A sms service provider API Token (optional)
- Youtube API Token (optional)
- Slack account and slack bot with API Token (optional)

## Creating the AKS cluster

> **Note**  Follow the steps given below to create the Kubernetes cluster in Azure. Refer to the documents provided by respective cloud providers to create the Kubernetes cluster on any other cloud.
The AKS cluster and VM's should be in same vnet. If they are in diffrent vnet, you have to peer the vnets. To peer the vnets the IP address of the two vnets should not overlap. 

1. Create service principal and assign contributor role to service principal, get the secrets and client id of service principal. Click [here]((https://docs.microsoft.com/en-us/cli/azure/create-an-azure-service-principal-azure-cli)) for more details
2. Create the AKS cluster either via Azure portal or using az aks command line

Refer to Azure documentation to all the available options. Here is a command which you can use -
 ```
az aks create --resource-group <resouse-group-name> --node-resource-group <k8s-resource-group-name> --name <cluster name>  --node-count 4 --admin-username deployer --kubernetes-version 1.19.9 --service-principal "<service principal id>" --node-vm-size Standard_D4s_v3 --client-secret "<client id>" --network-plugin azure --ssh-key-value @deployer.pub -l <region> --vm-set-type VirtualMachineScaleSets --vnet-subnet-id /subscriptions/<subscription id>/resourceGroups/<resouse-group-name>/providers/Microsoft.Network/virtualNetworks/<vnet-name>/subnets/<subnet name>
```
> Note: Ensure you have allocated at least 1024 IP's for your Kubernetes subnet (CIDR notation as x.x.x.x/22)


Get the kubeconfig file for your cluster with the below command -
```
az aks get-credentials --resource-group <resource group name> --name <cluster name> --file  k8s.yaml
```

 ## Configuring the Azure storage account

 1.Update the CORS rule for the storage account as follows:

 ```
    Allowed Origins: *
    Allowed Methods: GET,HEAD,OPTIONS, PUT
    Allowed Headers: Access-Control-Allow-Origin,Access-Control-Allow-Method,Origin,x-ms-meta-qq,x-ms-blob-type,x-ms-blob-content-type,Content-Type
    Exposed Headers: Access-Control-Allow-Origin,Access-Control-Allow-Methods
    Max Age: 200

 ``` 

 2.Disable **Secure transfer required** in storage account configuration