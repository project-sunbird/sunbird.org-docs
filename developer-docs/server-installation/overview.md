---
title: Overview
page_title: Overview
description: Setting up Sunbird server
allowSearch: true
---
 
## Infrastructure Design

Sunbird software is containerized. The installation script uses the Docker swarm orchestration engine to run the Sunbird docker images. The Docker swarm consists of manager and agent nodes. The containers run on the agent nodes and the manager nodes manage the container lifecycle.

All the stateless services in Sunbird - Portal, LMS Backend, API Gateway and Proxies - are run as docker containers inside the swarm. All stateful services consisting of Cassandra, PostgreSql, Elasticsearch and the OAuth service(Keycloak) are run on Virtual Machines (VMs) directly. The installation is automated using shell scripts and Ansible.

## Infrastructure Components

* The following table lists the services that are set up and run as part of installation. The table also lists the optimal server count for a typical staging or production environment with thousands of users.

| Server Type <td colspan=2>Basic Requirement</td> <td colspan=3> Suggested Servers per Environment </td> |Services |
|-----|--------|--------------------------------|---------|--------|-------| 
||  CPU |Memory | Development  | Production |Maximum | |
|<tr><td rowspan=4> Application </td> <td rowspan=4>2 core</td><td rowspan=4>7GB</td> <td rowspan=4>1  </td> </td>  <td rowspan=4>3</td><td rowspan=4>Any</td>| Docker Swarn Manager
|Docker Swarn Agent
| Keycloak
| Badgr
|<tr><td rowspan=4>  Database</td><td rowspan=4>2 core</td><td rowspan=4>1</td><td rowspan=4>3</td><td rowspan=4>7 GB</td><td rowspan=4>Any</td>  | Elastic Search 
| Postgre Master 
| Postgre Slave<sup>[1]</sup>
| Cassandra

[1] Recommended that Postgre slave is run on a seperate server when in production

### Supported application versions

  | Application |Version|
  |:-----      |:--------|
  |Docker | 17.06, 18.03|
  |Elasticsearch        | 5.4 |
  |Postgres | 9.5 |
  |Cassandra            | 3.9 |
