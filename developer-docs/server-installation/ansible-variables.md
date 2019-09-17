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

2. `cd sunbird-devops; git checkout tags/release-2.0.0 -b release-2.0.0`

3. `cp -rf sunbird-devops/private_repo /tmp/`

4. `cd /tmp/private_repo`


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

5. `git init`
   
6. `git add .`
   
7. `git commit -m "Creating private files"`
   
8. `git remote add origin ~private repo url~`

9. `git branch --set-upstream-to=origin/master master && git push --set-upstream origin master`
    
10. Update the variables and push them to upstream

## Updating the Variables and Hosts

1.`cd private_repo/ansible/inventory/dev/<module>/`

2.update hosts **common.yml** and **secrets.yml**

<table>
  <tr>
    <th style="width:25%">Module</th>
    <th style="width:25%">Servers</th>
    <th style="width:25%">Service</th>
    <th style="width:25%">Ansible Group Name</th>
  </tr>
  <tr>
    <td rowspan="7">Core</td>
    <td></td>
    <td>jenkins-master</td>
    <td></td>
  </tr>
  <tr>
    <td rowspan="2">Server-1 (swarm)</td>
    <td>Manager</td>
    <td>swarm-manager-1, swarm-agent-for-prometheus-1 swarm-agent-for-grafana-1, swarm-agent-for-alertmanager-1</td>
  </tr>
  <tr>
    <td>log-es</td>
    <td>log-es-1</td>
  </tr>   
  <tr>
    <td rowspan="4">Server-2 (core-db)</td>
    <td>Keycloak</td>
    <td>keycloak-1</td>
  </tr>  
  <tr>
    <td>cassandra-lms (core)</td>
    <td>cassandra-1</td>
  </tr>   
  <tr>
    <td>Postgress</td>
    <td>postgresql-master-1, postgresql-slave-1</td>
  </tr>   
  <tr>
    <td>es-lms-1</td>
    <td>es-1</td>
  </tr> 
  <tr>
    <td rowspan="7">Knowledge Platform</td>
    <td rowspan="4">Server-3 (lp-db)</td>
    <td>cassandra-lp-dp</td>
    <td>lp-cassandra, dp-cassandra</td>
  </tr>
  <tr>
    <td>kp-dp-es-1</td>
    <td>composite-search-cluster,es-ps</td>
  </tr>
  <tr>
    <td>Postgress</td>
    <td></td>
  </tr>
  <tr>
    <td>neo4j</td>
    <td>learning-neo4j-node1</td>
  </tr>
  <tr>
    <td rowspan="3">Server-4 (lp-db)</td>
    <td>learning-1</td>
    <td>learning1,logstash-ps</td>
  </tr>
  <tr>
    <td>redis</td>
    <td>redis1</td>
  </tr><tr>
    <td>search</td>
    <td>search1</td>
  </tr>
  <tr>
    <td rowspan="7">Data Pipeline</td>
    <td>Server 5 (spark)</td>
    <td>spark</td>
    <td>spark</td>
  </tr>
  <tr>
    <td>Server 6 (yarn-RM)</td>
    <td>yarn-rm </td>
    <td>yarn-master,yarn-ps</td>
  </tr>
  <tr>
    <td>Server 7 (yarn-slave)</td>
    <td>yarn-slave</td>
    <td>yarn-slave,yarn-ps</td>
  </tr>
  <tr>
    <td rowspan="4">Server 8 (dp-services)</td>
    <td>analytics-api</td>
    <td>analytics-api, analytics-ps</td>
  </tr>
  <tr>
    <td>kafka-indexer</td>
    <td>kafka-indexer</td>
  </tr>
  <tr>
    <td>secor</td>
    <td>secor, secor-ps</td>
  </tr>
  <tr>
    <td>InfluxDB</td>
    <td></td>
  </tr>
  <tr>
    <td>Common</td>
    <td>Server 9 (kafka)</td>
    <td>kafka (Kp, Dp. Core)</td>
    <td>processing-cluster-kafka, processing-cluster-zookeepers, kafka-ps
kafka-1</td>
  </tr>
</table>
