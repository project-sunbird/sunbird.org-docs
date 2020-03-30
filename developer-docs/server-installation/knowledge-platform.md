---
title: Knowledge Platform
page_title: Knowledge Platform
description: Knowledge Platform
keywords: Knowledge Platform
allowSearch: true
--- 

## Overview
This page explains the jobs to be run to bring up the Knowledge Platform services. In order to do so, log into Jenkins and execute the instructions as per the sequence provided on this page.

## Build

Switch to the `Build` folder and run all jobs in the below sequence. For the value of the **github_release_tag**, refer to [Current Release Tags and Jenkins Jobs Reference](developer-docs/server-installation/current_release_tags_n_jenkins_jobs){:target="_blank"}

 Operation Name    | Function              | Description |
| --------------   | --------------------- | -----------------
| CassandraTrigger | It generates the jar file for cassandraTrigger |
| KnowledgePlatform| It generates the artifacts for knowledge Platform |
| Neo4j            | It generates the Neo4j jar file|
| SyncTool         | It generates the SyncTool zip file |
| Yarn             | It generates the artifects for Samza job |




For KnowledgePlatform build, use the default profile_id which is "platform_services".

## DevOps Administration

| Operation Name | Function              |
| -------------- | --------------------- |
| Bootstrap      | Creates Deployer User |

## Provision

*   Download **neo4j enterprise** version 3.3.x. The file should be uploaded to your azure storage account under root path. The file name should be **neo4j*.tar.gz**. This file should be uploaded to the container named in the variable {{artifacts_container}} of KnowledgePlatform's common.yml.

The URL for this path will look like this - https://{{storage_account_name}}.blob.core.windows.net/{{container_name}}/neo4j-enterprise-3.3.0-unix.tar.gz

*   Switch to `Provision/<env>/KnowledgePlatform` and run the jobs in the following sequence:   
    
| Operation Name | Function              | Description |
| -------------- | --------------------- |------------------
| Cassandra      | It create the provision to install Cassandra| installs depencies like java and install cassandra 
| CompositeSearch| It install the ElasticSearch | install dependencies for elasticsearch and start elasticsearch service |
| Neo4j          | It install the Neo4j and Logstash| install neo4j and its dependencies
| Zookeeper      | It install the Zookeeper |
| Kafka          | It install the Kafka |
| Learning       | It install the dependency to run the learning application | creates learning user and install dependencies(java, tomcat, logstash, ffmpeg,imagemagick) |
| Redis          | It install the Redis database | download and install redis |
| Search         | It install the dependecy to run the search service and install the logstash | install dependencies (jdk, logstash) and configure search service 
| Yarn           | It set up the Yarn cluster | 

## Deploy

*   Switch to `Deploy/dev/KnowledgePlatform` and run the jobs in the following sequence:
 
| Operation Name      | Function              | Description |
| --------------      | --------------------- |--------------|
| CassandraTrigger    | It deploy the CassandraTrigger jar file and install the logstash |
| CassandraDbUpdate   | It create the Cassandra keyspace and do the Db update| Update cassandra table Schema
| Neo4j               | It deploy the Neo4j artifects |confogures logstash and neo4j, and start logstash process
| StartNeo4jCluster   | It start the Neo4j | starts neo4j process
| Learning            | It deploy the learning service artifects and start the learning service |
| Search              | It deploy the search service artifects and start the search service |
| Neo4DefinitionUpdate| It does the Neo4j defination update|
| Neo4jElasticSearchSyncTool|It deploy the sync tool artifects and sync the content from Neo4j to ElasticSearch  |
| KafkaSetup          | It create the Kafka Topics| create kafka topics for LP |
| Yarn                | It deploy the Samza jobs


Refer [How to Create Framework](developer-docs/how-to-guide/how_to_create_framework_in_sunbird){:target="_blank"}, [How to Create Schemas for Knowledge Platform Objects](developer-docs/server-installation/knowledge-platform-object-schema){:target="_blank"}
