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

*   Download **neo4j enterprise** version 3.3.x. Place it in the artifacts directory of your private repository. The file name should be **neo4j*.tar.gz**.
*   Since the neo4j file size is greater than 100 MB, use the Git large file storage function to store it in your private repository. For details, refer to  [Git Large File Storage](https://git-lfs.github.com/){:target="_blank"}

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
    2.Neo4j   
    3.StartNeo4jCluster   
    4.Learning   
    5.Search   
    6.Neo4DefinitionUpdate  
    7.Neo4jElasticSearchSyncTool   
    8.KafkaSetup   
    9.Yarn 
 
*   Now you should be able to delete contents from workspace, drafts, contents which are published etc.
                    
Refer [How to Create Framework](developer-docs/how-to-guide/how_to_create_framework_in_sunbird){:target="_blank"}, [How to Create Schemas for Knowledge Platform Objects](developer-docs/server-installation/knowledge-platform-object-schema){:target="_blank"}
