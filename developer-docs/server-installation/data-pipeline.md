---
title: Data Pipeline
page_title: Data Pipeline
description: Explains how to create schemas for knowledge platform objects
keywords: data, data pippeline, data sequence 
allowSearch: true

---

Log into Jenkins and perform the following:

## Build

Switch to <code>Build</code><span> </span>folder and run all jobs. Provide the value for <strong>github_release_tag</strong><span> </span>as per the details mentioned on: <a style="text-decoration: none;" href="https://project-sunbird.atlassian.net/wiki/spaces/DevOps/pages/1025376293/Current+Release+Tags+and+Jenkins+Jobs+Reference" rel="nofollow">Current Release Tags and Jenkins Jobs Reference</a>

## DevOps Administration

| Operation Name | Function              |
| -------------- | --------------------- |
| Bootstrap      | Creates Deployer User |

## Provision

Switch to <code>Provision/&lt;env&gt;/DataPipeline</code> and run all jobs

1. AnalyticsApi
2. AnalyticsSecor
3. AnalyticsSpark
4. Influxdb
5. Kibana
6. Postgress
7. Yarn

## Deploy

Switch to <code>Deploy/dev/DataPipeline</code> and run all jobs in the following order:

1. CassandraDbUpdate
2. KafkaSetup
3. AnalyticsApi
4. DataProducts
5. Secor
6. KafkaIndexer
7. SamzaTelemertySchemas
8. Yarn

