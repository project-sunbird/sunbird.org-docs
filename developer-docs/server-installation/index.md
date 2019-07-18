---
title: Server Installation
page_title: Server Installation
description: Server Installation
keywords: installation, server installation 
allowSearch: true
---
 
## Introduction
Sunbird is an open source repository of learning management microservices architected for scale and designed to support diverse teaching and learning solutions. Sunbird is the open source contribution of the EkStep Foundation and is licensed under the MIT licence. 

## Infrastructure Design
Sunbird software is containerized. The installation script uses the Docker swarm orchestration engine to run the Sunbird docker images. The Docker swarm consists of manager and agent nodes. The containers run on the agent nodes and the manager nodes manage the container lifecycle. 

All the stateless services in Sunbird - Portal, LMS Backend, API Gateway and Proxies - are run as docker containers inside the swarm. All stateful services consisting of Cassandra, PostgreSql, Elasticsearch and the OAuth service(Keycloak) are run on Virtual Machines (VMs) directly. 

This document explains the steps to set up an instance of Sunbird on your cloud infra.

This installation has been tested with 10 VMs running the vanilla Ubuntu 16 image;

  - a Public IP
  - with all ports opened
  - key based ssh possible to the machines

## Infrastructure Components

Sunbird consists of 3 major subsystems

  - Knowledge platform aka Learning platform ( Taxonomy, Content and Content Management )
  - Data-pipeline ( Creating insights from telemetry)
  - Core ( User/Org, Courses, Badges, Content Studio)

The following table lists the services that are set up and run as part of installation. The table also lists the optimal server count for a typical staging or production environment with thousands of users.

<table>
  <tr>
    <th style="width:20%">Server Type</th>
    <th style="width:25%" colspan="2">Basic Requirements</th>
    <th style="width:35%" colspan="3">Suggested Servers per Environment</th>
    <th style="width:20%">Services</th>
  </tr>
  <tr>
    <td></td>
    <td>CPU</td>
    <td>Memory</td>
    <td>Development</td>
    <td>Production</td>
    <td>Maximum</td>
    <td></td>
  </tr>
  <tr>
    <td rowspan="4">Application</td>
    <td rowspan="4">2 core</td>
    <td rowspan="4">7 GB</td>
    <td rowspan="4">1</td>
    <td rowspan="4">3</td>
    <td rowspan="4">Any</td>
    <td>Docker Swarm Manager</td>
  </tr>
  <tr>
    <td>Docker Swarm Agent</td>
  </tr>
  <tr>
    <td>Keycloak</td>
  </tr>
  <tr>
    <td>Badgr</td>
  </tr>
  <tr>
    <td rowspan="4">Database</td>
    <td rowspan="4">2 core</td>
    <td rowspan="4">7 GB</td>
    <td rowspan="4">1</td>
    <td rowspan="4">3</td>
    <td rowspan="4">Any</td>
    <td>Elastic Search
</td>
  </tr>
  <tr>
    <td>Postgres Master
</td>
  </tr>
  <tr>
    <td>Postgres Slave<sup>[1]</sup></td>
  </tr>
  <tr>
    <td>Cassandra</td>
  </tr>
</table>

> [1] Recommended that Postgres slave runs on a separate server when in production

### Supported application versions

Application |Version
:----- |:--------
Docker | 17.06, 18.03
Elasticsearch | 5.4 
Postgres | 9.5 
Cassandra | 3.9 
