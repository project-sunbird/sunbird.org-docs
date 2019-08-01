---
title: Manual Configuration
page_title:  Manual Configuration
description:  Manual Configuration
published: true
allowSearch: true
keywords: Upgrade, Sunbird 2.0.0
---

## Overview
With every new release of sunbird you will be able to experience new features, improved performance and bug squashes.
In this document, we will cover detailed steps on how to upgrade Sunbird 1.14.0 to 2.0.0. A lot has changed from 1.14.0 to 2.0.0 with respect to backend configurations. Below are the highlights of the changes:

## Upgrade Highlights

* Core Elasticsearch upgraded
* Core Elasticsearch 6.x creation of indices with mapping
* Migration of core elasticsearch data from old indices to new indices
* Keycloak configuration
* Run maskEmailPhoneMigration ETL Job for Core Cassandra
* Run UserSync ETL Job for Core Cassandra
* Run ETL job to delete user from Keycloak postgres DB
* Run course batch sync job


You can click on the links which will take you to the respective pages. This page will have details on how to run the respective step

* Core Elasticsearch upgrade
* Keycloak Configuration
* ETL jobs to run for upgrading to release-2.0.0