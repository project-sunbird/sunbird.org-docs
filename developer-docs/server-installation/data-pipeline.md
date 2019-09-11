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

## DevOps Administration

| Operation Name | Function              |
| -------------- | --------------------- |
| Bootstrap      | Creates Deployer User |

## Provision

Switch to `Provision/<env>/DataPipeline` and run the jobs in the following sequence: 

1.AnalyticsApi  
2.AnalyticsSecor  
3.AnalyticsSpark   
4.Postgres 
5.Yarn  
6.Influxdb

7.Zookeeper

8.Kafka

9.Redis

## Deploy

Switch to `Deploy/<env>/DataPipeline` and run the jobs in the following sequence:

1.CassandraDbUpdate  
2.KafkaSetup  
3.AnalyticsApi  
4.DataProducts  
5.Secor  
6.KafkaIndexer  
7.SamzaTelemertySchemas  
8.Yarn  
