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

This document explains the steps to set up Sunbird on your cloud infra.

This installation has been tested with 10 VMs running the vanilla Ubuntu 16 image;

  - a Public IP
  - with all ports opened
  - key based ssh possible to the machines

## Infrastructure Components

Sunbird consists of 3 major subsystems

  - Knowledge platform aka Learning platform ( Taxonomy, Content and Content Management )
  - Data-pipeline ( Creating insights from telemetry)
  - Core ( User/Org, Courses, Badges, Content Studio)
