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
|AdhocScript  | --- | ---|release-3.1.0 |
| AnalyticsCore  | Builds the analytics framework|Creates analytics framework artifact|release-3.1.0
| Analytics Service| Builds the analytics API service|Creates analytics API service artifact|release-3.0.0
| Api module| ---|---|release-3.1.0
| Core Data Product| Builds analytics core data products| Creates analytics core data products artifact| release-3.1.0
|Data pipeline| Builds all pipeline samza jobs| Creates tar ball for each pipeline samza jobs| release-3.1.0|
|EdDataProducts| ---|---| release-3.1.0|
|ETLJobs | Builds adhoc scripts which includes content snapshot druid indexer, dialcode redis indexer| Creates jar out of adhoc scripts| release-3.1.0|


## DevOps Administration

| Operation Name | Function              |
| -------------- | --------------------- |
| Bootstrap      | Creates Deployer User |

## Provision

Switch to `Provision/<env>/DataPipeline` and run the jobs in the following sequence: 


| Operation Name | Function              | Description| CURRENT RELEASE TAG|	
| -------------- | --------------------- |-------------|------------------|
| AnalyticsApi   | Provision the server to run the analytics-apiserver| Creates the analytics user required folders and installs the dependencies| release-3.1.0
| AnalyticsSpark | Provision the server to run the data products jobs| Creates the analyticsuser required folders and installs the dependencies to run spark| release-3.1.0
| Cassandra       | xxx| xxx| release-3.1.0|
| Postgres       | Provision the Postgres database| Installs the dependencies like java and install the Postgres database| release-3.1.0
| Yarn           | Provision the Yarn cluster | Install the dependencies required to create the yarn cluster and creates the yarn cluster to run samza jobs| release-3.1.0
| Influxdb       | Provision the influxdb database| Install the dependencies like java and install the influxdb database| release-3.1.0
| Zookeeper      | Provision the zookeeper| Installs the dependencies and creates the zookeeper cluster | release-3.1.0
| Kafka          | Provision the kafka| Installs the dependencies and creates the kafka broker cluster | release-3.1.0
| Redis          | Provision the redis database | Installs the dependencies like java and install the redis database | release-3.1.0
| Kibana          | --- | ---| release-3.1.0
| postgres-managed          | --- | ---| release-3.1.0|
| TelemetrySearch          | --- | --- | release-3.1.0|




## Deploy

Switch to `Deploy/<env>/DataPipeline` and run the jobs in the following sequence:


| Operation Name | Function              | Description | CURRENT RELEASE TAG|
| -------------- | --------------------- |-------------- |------------------|
|AdhocScripts | --- |---| release-3.1.0|
|AnalyticsAPI | Deploys the analytics api service |Handles all the data pipeline api requests and writes it to redis/filesystem/kafka| release-3.1.0|
| AnalyticsCore | Deploys Analytics framework jars |Copies analytics framework artifact to spark server| release-3.1.0|
| AnalyticsGeoLocationDBSetup | Deploys Analytics framework jars |Copies analytics framework artifact to spark server| release-3.1.0|
| AnalyticsPopulatePSQLConsumerChannelMapping | Deploying AnalyticsPopulatePSQLConsumerChannelMapping |Registers consumer against channel which is used to get telemetry data via data exhaust APIs| release-3.1.0|
| AnalyticsService | Deploy Analytics API service |Deploys latest artifact and starts API service| release-3.1.0|
| ApiModule | Deploys Druid proxy API |Used to setup proxy for druid APIs to restrict huge queries | release-3.1.0|
| CoreDataProducts | Deploys core data products  |Copies core data products artifact to spark server| release-3.1.0|
| DataProducts | --- |---| release-3.1.0|
| EdDataProducts | ---  |---| release-3.1.0|
| ETLUserCacheIndexer | ---  |---| release-3.1.0|
| KafkaIndexer | Deploys logstash configurations and starts process  |Used for pushing pipeline metrics to influxDB| release-3.1.0|
| KafkaSetup | Setup kafka for pipeline  |Creates kafka topic and updates topic configurations| release-3.1.0|
| Yarn | Deploys all pipeline samza jobs to yarn cluster  |Copies artifact and starts specified pipeline jobs on yarn cluster| release-3.1.0|



