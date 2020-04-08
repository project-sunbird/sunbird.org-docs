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
| Analytics      | Generates the artefacts for analytics API server|
| ApiModule      |     |
| DataPipeline   | Generates the samza jobs artifects|
| ETLJobs        |     |
| Secor          | Generates the artefacts for the secore service|

## DevOps Administration

| Operation Name | Function              |
| -------------- | --------------------- |
| Bootstrap      | Creates Deployer User |

## Provision

Switch to `Provision/<env>/DataPipeline` and run the jobs in the following sequence: 


| Operation Name | Function              | Description|
| -------------- | --------------------- |-------------|
| AnalyticsApi   | Provision the server to run the analytics-apiserver| Creates the analytics user required folders and installs the dependencies|
| AnalyticsSecor | Provision the server to run the secor jobs | Creates the analytics user required folders and installs the dependencies to run secorjobs|
| AnalyticsSpark | Provision the server to run the data products jobs| Creates the analyticsuser required folders and installs the dependencies to run spark|
| Postgres       | Provision the Postgres database| Installs the dependencies like java and install the Postgres database|
| Yarn           | Provision the Yarn cluster | Install the dependencies required to create the yarn cluster and creates the yarn cluster to run samza jobs|
| Influxdb       | Provision the influxdb database| Install the dependencies like java and install the influxdb database|
| Zookeeper      | Provision the zookeeper| Installs the dependencies and creates the zookeeper cluster
| Kafka          | Provision the kafka| Installs the dependencies and creates the kafka broker cluster
| Redis          | Provision the redis database | Installs the dependencies like java and install the redis database

## Deploy

Switch to `Deploy/<env>/DataPipeline` and run the jobs in the following sequence:


| Operation Name | Function              | Description |
| -------------- | --------------------- |-------------- |
| CassandraDbUpdate| Updates the cassandra DB |Updates the required Cassandra table schema|
| KafkaSetup       | Creates Kafka topics |The created topics being used by various applications| Handles all the data pipeline api requests and writes it to redis/filesystem/kafka
| AnalyticsApi     | Deploys the analytics api service | Handles all the data pipeline api requests and writes it to redis/filesystem/kafka
| DataProducts     | Deploys the data products jars | Computes the summary using batch jobs from raw telemetry
| Secor            | Deploys the secor jobs | Takes the backup of kafka topics and stores them in storage
| KafkaIndexer     | Installs the logstash | Reads the Kafka topic and sends the pipeline metrics to influxdb |
| SamzaTelemertySchemas|Copies the telemetry samza jobs related schemas to yarn slaves| Copies the schema files- which will be used for validating telemetry-data, to all the nodes in yarn |
| Yarn             | Deploys the samza jobs in yarn cluster| Reads the messages from various kafka topics and does the logical transformation and update the event to Kafka/redis/postgres|