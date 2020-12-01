---
title: Server Installation
page_title: Server Installation
description: Server Installation
keywords: installation, server installation 
allowSearch: true
---
 
## Introduction

Sunbird is an open source repository of learning management microservices architected for scale and designed to support diverse teaching and learning solutions. Sunbird is the open source contribution of the EkStep Foundation and is licensed under the MIT licence.

Sunbird software is containerized. The installation script uses the Kubernetes orchestration engine to run the Sunbird docker images. The Kubernetes consists of manager and agent nodes. The pods run on the agent nodes and the manager nodes manage the pods lifecycle. 

Services like Portal, LMS Backend, API Gateway and Proxies etc., are run as Kubernetes pods. Services like learning, Search, Keycloak, Cassandra, PostgreSql, Elasticsearch etc., are run on Virtual Machines (VMs) directly.

This document explains the procedure to set up Sunbird on your cloud infra. This installation has been tested with:

* AKS(azure kubernetes service) cluster
* 6 VMs running the vanilla Ubuntu 16 image;
* a Public IP
* key based ssh possible to the machines

## Infrastructure Components

Sunbird consists of 3 major subsystems

  - Knowledge Platform also knows as Learning Platform (Taxonomy, Content and Content Management)
  - Data-pipeline (Creating insights from telemetry)
  - Core (User, Organization, Courses, Badges, Content Studio)
