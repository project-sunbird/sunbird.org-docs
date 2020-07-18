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


| Operation Name | Function              |Description | CURRENT RELEASE TAG |
| -------------- | --------------------- |------------|---------------------|
| AnalyticsCore  | Builds the analytics framework|Creates analytics framework artifact|release-2.8.0
| Analytics Service| Builds the analytics API service|Creates analytics API service artifact|release-2.8.0
| Core Data Product| Builds analytics core data products| Creates analytics core data products artifact| release-2.8.0
 Data pipeline| Builds all pipeline samza jobs| Creates tar ball for each pipeline samza jobs| release-2.8.0|
 DataReplay | Builds replay scripts| Creates zip file for replay python scripts| release-2.8.0|
ETLJobs | Builds adhoc scripts which includes content snapshot druid indexer, dialcode redis indexer| Creates jar out of adhoc scripts| release-2.8.0|
Secor | Generates the artefacts for the secore service| Artifects for secore service| secor-0.25|


## DevOps Administration

| Operation Name | Function              |
| -------------- | --------------------- |
| Bootstrap      | Creates Deployer User |

## Provision

Switch to `Provision/<env>/DataPipeline` and run the jobs in the following sequence: 


| Operation Name | Function              | Description| CURRENT RELEASE TAG|	
| -------------- | --------------------- |-------------|------------------|
| AnalyticsApi   | Provision the server to run the analytics-apiserver| Creates the analytics user required folders and installs the dependencies| release-2.8.0
| AnalyticsSecor | Provision the server to run the secor jobs | Creates the analytics user required folders and installs the dependencies to run secorjobs| release-2.8.0
| AnalyticsSpark | Provision the server to run the data products jobs| Creates the analyticsuser required folders and installs the dependencies to run spark| release-2.8.0
| Postgres       | Provision the Postgres database| Installs the dependencies like java and install the Postgres database| release-2.8.0
| Yarn           | Provision the Yarn cluster | Install the dependencies required to create the yarn cluster and creates the yarn cluster to run samza jobs| release-2.8.0
| Influxdb       | Provision the influxdb database| Install the dependencies like java and install the influxdb database| release-2.8.0
| Zookeeper      | Provision the zookeeper| Installs the dependencies and creates the zookeeper cluster | release-2.8.0
| Kafka          | Provision the kafka| Installs the dependencies and creates the kafka broker cluster | release-2.8.0
| Redis          | Provision the redis database | Installs the dependencies like java and install the redis database | release-2.8.0

## Deploy

Switch to `Deploy/<env>/DataPipeline` and run the jobs in the following sequence:


| Operation Name | Function              | Description | CURRENT RELEASE TAG|
| -------------- | --------------------- |-------------- |------------------|
| AnalyticsCore | Deploys Analytics framework jars |Copies analytics framework artifact to spark server| release-2.8.0|
| AnalyticsPopulatePSQLConsumerChannelMapping | Deploying AnalyticsPopulatePSQLConsumerChannelMapping |Registers consumer against channel which is used to get telemetry data via data exhaust APIs| release-2.8.0|
| AnalyticsReplayJobs | To trigger data products execution on demand |Based on given parameter triggers data product execution| release-2.8.0|
| AnalyticsService | Deploy Analytics API service |Deploys latest artifact and starts API service| release-2.8.0|
| AnalyticsStartJobManager | To start job manager for data products execution on demand |Starts job manager process| release-2.8.0|
| AnalyticsSubmitJobs | To submit data products for execution via job manager |Submits job to a kafka topic which is consumed by job manager | release-2.8.0|
| ApiModule | Deploys Druid proxy API |Used to setup proxy for druid APIs to restrict huge queries | release-2.8.0|
| CassandraDbUpdate| Updates the cassandra DB |Updates the required Cassandra table schema| release-2.8.0|
| CoreDataProducts | Deploys core data products  |Copies core data products artifact to spark server| release-2.8.0|
| KafkaIndexer | Deploys logstash configurations and starts process  |Used for pushing pipeline metrics to influxDB| release-2.8.0|
| KafkaSetup | Setup kafka for pipeline  |Creates kafka topic and updates topic configurations| release-2.8.0|
| SamzaTelemetrySchemas | Deploys telemetry validation schema to yarn cluster  |This schema is used in pipeline jobs for validating telemetry events| release-2.8.0|
| Secor | Deploys secor configurations and starts process  |Secor processes are used to backup telemetry events from kafka topic to blob store | release-2.8.0|
| Yarn | Deploys all pipeline samza jobs to yarn cluster  |Copies artifact and starts specified pipeline jobs on yarn cluster| release-2.8.0|



