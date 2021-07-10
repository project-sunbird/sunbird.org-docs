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
git checkout tags/release-3.9.0_RC18 -b release-3.9.0_RC18
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

### Updating ansible inventory

- cd in to the private inventory folder 
  ```
  cd /path/to/private-repo/
  cd ansible/inventory/dev
  ```
- Change the inventory ips. We use sed command to replace the placeholder strings.

  For example,
  ```
  sed -i 's/placeholder/your value to be replaced/g' path/to/file
  # If your DP machine ip is 172.16.5.10
  sed -i 's/10.1.4.4/172.16.5.10/g' ./{Core,KnowledgePlatform,DataPipeline}/{common.yml,hosts} # DP
  ```
  
  ```
  # If you used auzre-provision.yaml for creating the infra, you'll have the information in 
  # sunbird-devops/deploy/azure-resources.txt
  
  sed -i 's/10.1.4.4/DP     vm IP/g' ./{Core,KnowledgePlatform,DataPipeline}/{common.yml,hosts} # DP
  sed -i 's/10.1.4.5/DB     vm IP/g' ./{Core,KnowledgePlatform,DataPipeline}/{common.yml,hosts} # DB
  sed -i 's/10.1.4.6/KP     vm IP/g' ./{Core,KnowledgePlatform,DataPipeline}/{common.yml,hosts} # KP
  sed -i 's/10.1.4.7/Yarn   vm IP/g' ./{Core,KnowledgePlatform,DataPipeline}/{common.yml,hosts} # YARN
  sed -i 's/10.1.4.8/Others vm IP/g' ./{Core,KnowledgePlatform,DataPipeline}/{common.yml,hosts} # OTHERS
  ```
- Change common variables used in all environment. 
  Note: Keep in mind that this will only update subset of variables. So please go through the files prior starting installation.
  ```
  sed -i 's/change.azure.storage.account.key/Storage account key for azure blob/g' ./{Core,KnowledgePlatform,DataPipeline}/{common.yml,secrets.yml}
  sed -i 's/change.azure.storage.account.sas/Storage account sas for azure blob/g' ./{Core,KnowledgePlatform,DataPipeline}/{common.yml,secrets.yml}
  sed -i 's/change.docker.url/docker registry url/g' ./{Core,KnowledgePlatform,DataPipeline}/{common.yml,secrets.yml}
  sed -i 's/change.docker.username/docker registry username/g' ./{Core,KnowledgePlatform,DataPipeline}/{common.yml,secrets.yml}
  sed -i 's/change.docker.password/docker registry password/g' ./{Core,KnowledgePlatform,DataPipeline}/{common.yml,secrets.yml}
  # run `openssl rand -hex 10` to generate a pssword
  sed -i 's/change.sunbird.encryption.key/output of the above command/g' ./{Core,KnowledgePlatform,DataPipeline}/{common.yml,secrets.yml}
  # run `openssl rand -hex 10` to generate a pssword
  sed -i 's/change.postgres.password/output of the above command/g' ./{Core,KnowledgePlatform,DataPipeline}/{common.yml,secrets.yml}
  ```
