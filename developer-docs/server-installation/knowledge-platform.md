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

|Operation Name    | Function              |
| --------------   | --------------------- | 
| CassandraTrigger | Generate the jar file for cassandraTrigger |
| KnowledgePlatform| Generate the artefacts for knowledge Platform |
| Neo4j            | Generate the Neo4j jar file|
| SyncTool         | Generate the SyncTool zip file |
| Yarn             | Generate the artefacts for Samza job |




For KnowledgePlatform build, use the default profile_id which is "platform_services".

## DevOps Administration

| Operation Name | Function              |
| -------------- | --------------------- |
| Bootstrap      | Creates Deployer User |

## Provision

*   Download **neo4j enterprise** version 3.3.x. The file should be uploaded to your azure storage account under the root path. The file name should be **neo4j*.tar.gz**. This file should be uploaded to the container named in the variable {{artifacts_container}} of KnowledgePlatform's common.yml.

The URL for this path will look like this - https://{{storage_account_name}}.blob.core.windows.net/{{container_name}}/neo4j-enterprise-3.3.0-unix.tar.gz

*   Switch to `Provision/<env>/KnowledgePlatform` and run the jobs in the following sequence:   
    
| Operation Name | Function              | Description |
| -------------- | --------------------- |------------------
| Cassandra      | Provisions to install Cassandra| Installs dependencies like java and installs Cassandra |
| CompositeSearch| Installs the ElasticSearch | Installs dependencies for elastic search and starts elastic search service |
| Neo4j          | Installs the Neo4j and Logstash | Installs Neo4j and its dependencies |
| Zookeeper      | Installs the Zookeeper | Zookeeper installation |
| Kafka          | Installs the Kafka | Kafka installation |
| Learning       | Installs the dependency to run the learning application | Creates learning user and installs dependencies(java, tomcat, logstash, ffmpeg,imagemagick) |
| Redis          | Installs the Redis database | Download and installs Redis |
| Search         | Installs the dependency to run the search service and install the logstash | Install dependencies (JDK, logstash) and configure search service 
| Yarn           | Sets up the Yarn cluster | Setting up the yarn cluster   |

## Deploy

*   Switch to `Deploy/dev/KnowledgePlatform` and run the jobs in the following sequence:
 
| Operation Name      | Function              |
| --------------      | --------------------- |
| CassandraTrigger    | Deploys the CassandraTrigger jar file and installs the logstash |
| CassandraDbUpdate   | Creates the Cassandra keyspace and update|
| Neo4j               | Deploys the Neo4j artefacts |
| StartNeo4jCluster   | Starts the Neo4j process| 
| Learning            | Deploys the learning service artefacts and starts the learning service |
| Search              | Deploys the search service artefacts and starts the search service |
| Neo4DefinitionUpdate| Updates Neo4j definition |
| Neo4jElasticSearchSyncTool| Deploys the sync tool artefacts and syncs the content from Neo4j to ElasticSearch  |
| KafkaSetup          | Creates the Kafka Topics| 
| Yarn                | Deploys the Samza jobs |


Refer [How to Create Framework](developer-docs/how-to-guide/how_to_create_framework_in_sunbird){:target="_blank"}, [How to Create Schemas for Knowledge Platform Objects](developer-docs/server-installation/knowledge-platform-object-schema){:target="_blank"}
