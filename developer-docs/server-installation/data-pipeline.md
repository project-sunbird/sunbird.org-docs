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


| Operation Name | Function              |
| -------------- | --------------------- |
| Analytics      | It generate the artifects for analytics api server|
| ApiModule      |     |
| DataPipeline   | It generate the samza jobs artifects|
| ETLJobs        | |
| Secor          | It generate the artifects for the secore service|

## DevOps Administration

| Operation Name | Function              |
| -------------- | --------------------- |
| Bootstrap      | Creates Deployer User |

## Provision

Switch to `Provision/<env>/DataPipeline` and run the jobs in the following sequence: 


| Operation Name | Function              |
| -------------- | --------------------- |
| AnalyticsApi   | It install the dependecy to run the analytics API |
| AnalyticsSecor | It install the dependecy to run the analytics Secor|
| AnalyticsSpark | It install the dependecy to run the analytics Spark|
| Postgres       | It install the Posgres Database|
| Yarn           | It create the Yarn cluster |
| Influxdb       | It install the Influxdb |
| Zookeeper      | It install the Zookeeper |
| Kafka          | It install the Kafka |
| Redis          | It install the Redis database |

## Deploy

Switch to `Deploy/<env>/DataPipeline` and run the jobs in the following sequence:


| Operation Name | Function              |
| -------------- | --------------------- |
| CassandraDbUpdate| It creates the Cassandra keyspace and do the db update|
| KafkaSetup       | It create the Kafka topic |
| AnalyticsApi     | It deploy the analytics service api|
| DataProducts     | It deploy the jar files relatd to the data product|
| Secor            | It deploy and start the secor jobs to take the kafka topic backup |
| KafkaIndexer     | It install the logstsh          |  |
| SamzaTelemertySchemas|It copy the telemetry schema which requires for samza jobs  |
| Yarn             | It deploy the Samza Jobs |