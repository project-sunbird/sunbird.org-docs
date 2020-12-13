---
title: Data Pipeline
page_title: Data Pipeline
description: Explains how to create schemas for Data Pipeline objects
keywords: data, data pipeline, data sequence 
allowSearch: true

---

## Overview

This page explains the jobs to be run to bring up the Data Pipeline services. In order to do so, log into Jenkins and execute the instructions as per the sequence provided on this page.

## Build

Switch to the `Build` folder and run all jobs. For the value of the **github_release_tag**, refer to [Current Release Tags and Jenkins Jobs Reference](developer-docs/server-installation/current_release_tags_n_jenkins_jobs){:target="_blank"}


| Operation Name | Function  |Description | CURRENT RELEASE TAG |
| -------------- | --------- |------------|---------------------|
| AnalyticsCore  | Builds the analytics framework|Creates analytics framework artifact|release-3.4.0
| Core Data Product| Builds analytics core data products| Creates analytics core data products artifact| release-3.4.0
|EdDataProducts| ---|---| release-3.4.0|
|FlinkPipelineJobs| ---|---| release-3.4.0|
|ETLJobs | Builds adhoc scripts which includes content snapshot druid indexer, dialcode redis indexer| Creates jar out of adhoc scripts| release-3.4.0|


## DevOps Administration

| Operation Name | Function              |
| -------------- | --------------------- |
| Bootstrap      | Creates Deployer User |

## Provision

Switch to `Provision/<env>/DataPipeline` and run the jobs in the following sequence: 


| Operation Name | Function              | Description| CURRENT RELEASE TAG|	
| -------------- | --------------------- |-------------|------------------|
| AnalyticsSpark | Provision the server to run the data products jobs| Creates the analyticsuser required folders and installs the dependencies to run spark| release-3.4.0
| Postgres       | Provision the Postgres database| Installs the dependencies like java and install the Postgres database| release-3.4.0
| postgres-managed          | --- | ---| release-3.4.0|
| Yarn           | Provision the Yarn cluster | Install the dependencies required to create the yarn cluster and creates the yarn cluster to run samza jobs| release-3.4.0
| Influxdb       | Provision the influxdb database| Install the dependencies like java and install the influxdb database| release-3.4.0
| Druid          | deploy and start druid services


## Deploy

Switch to `Deploy/<env>/DataPipeline` and run the jobs in the following sequence:


| Operation Name | Function              | Description | CURRENT RELEASE TAG|
| -------------- | --------------------- |-------------- |------------------|
| AnalyticsCore | Deploys Analytics framework jars |Copies analytics framework artifact to spark server| release-3.4.0|
| CoreDataProducts | Deploys core data products  |Copies core data products artifact to spark server| release-3.4.0|
| EdDataProducts | ---  |---| release-3.4.0|
| KafkaIndexer | Deploys logstash configurations and starts process  |Used for pushing pipeline metrics to influxDB| release-3.4.0|
| KafkaSetup | Setup kafka for pipeline  |Creates kafka topic and updates topic configurations| release-3.4.0|
| FlinkPipelineJobs | --- | --- | release-3.4.0 |
| DruidIngestion | --- | --- | release-3.4.0 |
| ETLJobs | --- | --- | release-3.4.0 |
| ETLUserCacheIndexer | ---  |---| release-3.4.0|




