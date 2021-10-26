---
title: Ansible Variables
page_title: Ansible Variables
description: Setting up the Ansible variables in the private GitHub repository
keywords: ansible, variables, private github repository, private repo
allowSearch: true
---
## Overview

Ansible is the configuration management system used in Sunbird. The infrastructure setup, deployment of services and other configurations is handled primarily through ansible.

### Updating the Private Repository with Hosts and Variables

Use the following git commands sequentially to clone and update your private GitHub repository -

```bash
git clone https://github.com/project-sunbird/sunbird-devops
cd sunbird-devops
git checkout tags/release-4.2.0 -b release-4.2.0
```

- Copy the directory `sunbird-devops/private_repo/ansible` to your private repo

- Update the files **common.yml**, **hosts**, and **secrets.yml** under **Core**, **KnowledgePlatform** and **DataPipeline** directories. After updating, push them to your private repo branch
- Your private repo structure starting from the root path should be exactly as shown below
  
```bash
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

> Note:
>
>- The ansible inventory setup is a must before we can start to run jobs from the **Provision**, **ArtifactUpload** and **Deploy** directory in Jenkins. The **Build** directory on Jenkins does not depend on the ansible variables
>- It is highly recommended that you complete the ansible inventory updates before proceeding further

### List of Servers with their Ansible Group Names

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
    <td rowspan="4">Data Pipeline</td>
    <td rowspan="4">Server-4</td>
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
    <td>Keycloak</td>
    <td>keycloak-1, keycloak</td>
  </tr>
  <tr>
    <td rowspan="1">Yarn</td>
    <td>Server-5</td>
    <td>Yarn Master and Slave</td>
    <td>yarn-master, yarn-slave, yarn</td>
  </tr>
  <tr>
    <td rowspan="3">Other Services</td>
    <td rowspan="3">Server-6</td>
    <td>Druid</td>
    <td>druid-postgres, raw-coordinator, raw-overlord, raw-broker, raw-historical, raw-middlemanager, raw-graphite, rollup-coordinator, dp-druid-broker, broker, coordinator, druid-raw</td>
  </tr>
  <tr>
    <td>Logs Elasticsearch</td>
    <td>log-es-1, log-es-backup, log-es</td>
  </tr>
  <tr></tr>
</table>