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

Switch to the `Build` folder and run all jobs. For the value of the **github_release_tag**, refer to [Current Release Tags and Jenkins Jobs Reference](developer-docs/server-installation/current_release_tags_n_jenkins_jobs){:target="_blank"}

## DevOps Administration

| Operation Name | Function              |
| -------------- | --------------------- |
| Bootstrap      | Creates Deployer User |

## Provision

*   Download **neo4j enterprise** version 3.3.x. The file should be uploaded to your azure storage account under root path. The file name should be **neo4j*.tar.gz**.

The URL for this path will look like this - https://{{storage_account_name}}.blob.core.windows.net/{{container_name}}/neo4j-enterprise-3.3.9-unix.tar.gz

*   Switch to `Provision/<env>/KnowledgePlatform` and run the jobs in the following sequence:   
    1.Cassandra   
    2.CompositeSearch   
    3.Neo4j   
    4.Zookeeper   
    5.Kafka   
    6.Learning   
    7.Redis   
    8.Search   

## Deploy

*   Switch to `Deploy/dev/KnowledgePlatform` and run the jobs in the following sequence:

    1.CassandraDbUpdate  
    2.CassandraTrigger
    3.Neo4j   
    4.StartNeo4jCluster   
    5.Learning   
    6.Search   
    7.Neo4DefinitionUpdate  
    8.Neo4jElasticSearchSyncTool   
    9.KafkaSetup   
    10.Yarn  


Refer [How to Create Framework](developer-docs/how-to-guide/how_to_create_framework_in_sunbird){:target="_blank"}, [How to Create Schemas for Knowledge Platform Objects](developer-docs/server-installation/knowledge-platform-object-schema){:target="_blank"}
