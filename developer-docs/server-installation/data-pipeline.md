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


| Operation Name | Function              | Description|
| -------------- | --------------------- |-------------|
| AnalyticsApi   | Provision the server to run the analytics-apiserver|Creates the analytics user,required folders and installs the dependencies|
| AnalyticsSecor | Provision the server to run the secor jobs.|Creates the analytics user,required folders and installs the dependencies to run secorjobs|
| AnalyticsSpark | Provision the server to run the dataproducts jobs| Creates the analyticsuser, required folders and installs the dependencies to run spark|
| Postgres       | Provision the postgres database.|Installs the dependencies like java and install the postgres database|
| Yarn           | Provision the Yarn cluster |Install the dependencies required to create the yarn cluster and creates the yarn cluster to run samza jobs|
| Influxdb       | Provision the influxdb database| Install the dependencies like java and install the influxdb database|
| Zookeeper      | Provision the zookeeper|Installs the dependencies and creates the zookeeper cluster.
| Kafka          | Provision the kafka|Installs the dependencies and creates the kafka broker cluster.
| Redis          | Provision the redis database. |Installs the dependencies like  java and install the redis database.

## Deploy

Switch to `Deploy/<env>/DataPipeline` and run the jobs in the following sequence:


| Operation Name | Function              | Description |
| -------------- | --------------------- |-------------- |
| CassandraDbUpdate| Updates the cassandra db.|It updates the required cassandra table schema|
| KafkaSetup       | Creates the kafka topics. |The created topics being used by various applications| It handles all the datapipeline api requests and writes it to redis/filesystem/kafka
| AnalyticsApi     | Deploy the anaytics api service.|It handles all the datapipeline api requests and writes it to redis/filesystem/kafka
| DataProducts     | Depoys the dataproducts jars.|It computes the summary using batch jobs from raw telemetry.
| Secor            | Depoys the secor jobs. | It takes the backup of kafka topics and store them in storage.
| KafkaIndexer     | Installs the logstash. | It reads the kafka topic and send the pipeline metrics to influxdb. |
| SamzaTelemertySchemas|Copies the telemetry samza jobs related schemas to yarn slaves| It copies the schema files- which will used for validating telemetry-data , to all the nodes in yarn |
| Yarn             | Depoys the samza jobs in yarn cluster| It reads the messages from various kafka topics and does the logical transformation and update the event to kafka/redis/postgres|