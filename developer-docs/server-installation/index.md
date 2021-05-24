title: Server Installation
page_title: Server Installation
description: Server Installation
keywords: installation, server installation
allowSearch: true
---

## Introduction

Sunbird is an open source repository of learning management microservices architected for scale and designed to support diverse teaching and learning solutions. Sunbird is the open source contribution of the EkStep Foundation and is licensed under the MIT licence.

Sunbird software is containerized. The installation script uses the Kubernetes orchestration engine to run the Sunbird docker images.

Most of the services on Sunbird run on Kubernetes. Databases and a few other services run on standalone Virtual Machines (VMs). We are in the process of moving all the services to Kubernetes except databases.

This document explains the procedure to set up Sunbird on your cloud infra. This installation has been tested with:

* AKS (Azure Kubernetes Service)
* Ubuntu 18 VM's

## Infrastructure Components

Sunbird consists of 3 major subsystems

* Knowledge Platform also knows as Learning Platform (Taxonomy and Content)
* Data Pipeline (Data enrichment and Visualizations)
* Core Services (User, Organization, Courses, Certificates, UI and Frontend)
