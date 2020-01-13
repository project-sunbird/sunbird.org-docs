---
title: Ansible Variables Setup
page_title: Ansible Variables Setup
description: Setting up the Ansible variables in the private GitHub repository
keywords: ansible variables, variables, private GitHub repository, private repo
allowSearch: true
---
## Overview

Sunbird uses Ansible playbooks to manage its three major sub-systems (Knowledge Platform, Data Pipeline and Core Services), to ensure scalability, consistency and reliability of its IT environment. The Ansible variables help server setup, configuration management and automate deployment.   

    
## Updating the Private Repository with Hosts and Variables

Use the following Git commands sequentially to clone and update your private GitHub repository: 

1. `git clone` <a href="https://project-sunbird/sunbird-devops">https://github.com/project-sunbird/sunbird-devops</a>

2. `cd sunbird-devops; git checkout tags/release-2.6.0 -b release-2.6.0`

3. Copy the directory `sunbird-devops/private_repo/ansible` to your private repo location

4. Update the files `common.yml`, `hosts`, `secrets.yml` under `Core`, `KnowledgePlatform` and `DataPipeline`. After updating, push them to your private repo branch. The structure under `ansible` directory is shown below.


> **Note** The following depicts the folder structure required in the private GitHub repository that contains Ansible hosts, secrets and variables.
  
```
ansible
└── inventory
    └── dev
        ├── Core
        │   ├── common.yml
        │   ├── hosts
        │   └── secrets.yml
        ├── DataPipeline
        │   ├── common.yml
        │   ├── hosts
        │   └── secrets.yml
        └── KnowledgePlatform
            ├── common.yml
            ├── hosts
            └── secrets.yml
```

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
    <td>swarm-manager-1, swarm-agent-for-prometheus-1, swarm-agent-for-alertmanager-1, swarm-dashboard-1, swarm-bootstrap-manager, swarm-node-1</td>
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
    <td>processing-cluster-kafka, processing-cluster-zookeepers, kafka-ps kafka-1</td>
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



