---
title: Sunbird Infra Requirements
page_title: Sunbird Infra Requirements
description: Sunbird Infra Requirements
keywords: sunbird infra, infrastructure, requirements
allowSearch: true
---

## Introduction

Sunbird is an open source repository of learning management microservices designed for scale and to support diverse teaching and learning solutions. Sunbird is the open source contribution of the EkStep Foundation and is licensed under the MIT licence.

Sunbird software is containerized. The installation script uses the Kubernetes orchestration engine to run the Sunbird docker images.

Most of the services on Sunbird run on Kubernetes. Databases and a few other services run on standalone Virtual Machines (VMs). We are in the process of moving all the services to Kubernetes except databases.

This document explains the procedure to set up Sunbird on your cloud infra. This installation has been tested with:

* AKS (Azure Kubernetes Service)
* Ubuntu 18.04 VM's

### Building Blocks

Sunbird consists of these major building blocks

* Sunbird Anuvaad
* Sunbird coKreat
* Sunbird COMET
* Sunbird cQube
* Sunbird ED
* Sunbird inQuiry
* Sunbird Knowlg
* Sunbird Lern
* Sunbird Obsrv
* Sunbird RC
* Sunbird Saral
* Sunbird UCI
* Sunbird Vakyansh
