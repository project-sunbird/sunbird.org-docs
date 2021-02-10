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

|Operation Name    | Function              | CURRENT RELEASE TAG |
| --------------   | --------------------- | -------------------
| CassandraTrigger | Generate the jar file for cassandraTrigger | release-3.5.0
| KnowledgePlatform| Generate the artefacts for knowledge Platform | release-3.5.0
| Neo4j            | Generate the Neo4j jar file| release-3.5.0
| Yarn             | Generate the artefacts for Samza job | release-3.5.0
| Dial             | Generate the artifacts for dial service | release-3.3.0
| FlinkJobs        | Generate the artifacts for flink jobs   | relelase-3.5.0




For KnowledgePlatform build, use the default profile_id which is "platform_services".

## DevOps Administration

| Operation Name | Function              |
| -------------- | --------------------- |
| Bootstrap      | Creates Deployer User |

## Provision

*   Download **neo4j enterprise** version 3.3.x. The file should be uploaded to your azure storage account under the root path. The file name should be **neo4j*.tar.gz**. This file should be uploaded to the container named in the variable {{artifacts_container}} of KnowledgePlatform's common.yml.

The URL for this path will look like this - https://{{storage_account_name}}.blob.core.windows.net/{{container_name}}/neo4j-enterprise-3.3.9-unix.tar.gz

*   Switch to `Provision/<env>/KnowledgePlatform` and run the jobs in the following sequence:   
    
| Operation Name | Function              | Description | CURRENT RELEASE TAG |
| -------------- | --------------------- |-------------|  -----------------
| CompositeSearch| Installs the ElasticSearch | Installs dependencies for elastic search and starts elastic search service | release-3.5.0
| Neo4j          | Installs the Neo4j and Logstash | Installs Neo4j and its dependencies | relesae-3.5.0|
|zookeeper          | Installs the zookeper | zookeeper installation | release-3.5.0
| Kafka          | Installs the Kafka | Kafka installation | release-3.5.0
| Learning       | Installs the dependency to run the learning application | Creates learning user and installs dependencies(java, tomcat, logstash, ffmpeg,imagemagick) | release-3.5.0
| Redis          | Installs the Redis database | Download and installs Redis | release-3.5.0
| Dial           | Installs the dependency to run the dial service | install logstash and other dependencies | release-3.5.0

## Deploy

*   Switch to `Deploy/dev/KnowledgePlatform` and run the jobs in the following sequence (start deploy jobs after all DB provision is done from core folder):
 
| Operation Name      | Function              | CURRENT RELEASE TAG |
| --------------      | --------------------- | -------------------
| CassandraTrigger    | Deploys the CassandraTrigger jar file and installs the logstash | release-3.5.0
| CassandraDbUpdate   | Creates the Cassandra keyspace and update| release-3.5.0
| Neo4j               | Deploys the Neo4j artefacts | release-3.5.0
| StartNeo4jCluster   | Starts the Neo4j process| release-3.5.0
| Learning            | Deploys the learning service artefacts and starts the learning service | release-3.5.0
| Neo4DefinitionUpdate| Updates Neo4j definition | release-3.5.0
| KafkaSetup          | Creates the Kafka Topics| release-3.5.0
| Yarn                | Deploys the Samza jobs | release-3.5.0
| Dial                | Deploys and starts dial service | release-3.5.0
| FlinkJobs           | Deploys flink jobs | release-3.5.0


## Create master framework category
        
1.Make sure learning services is running and healthy, command to check learning service health **http://localhost:8080/learning-service/health**

2.Run the below curl command from learning vm:

 ```
   curl --location --request POST 'http://localhost:8080/learning-service/framework/v3/category/master/create' \
                  --header 'Content-Type: application/json' \
                  --data-raw '{
                     "request": {
                        "category":{
                            "name":"Subject",
                            "description":"Subject",
                            "code":"subject"
                        }
                      }
                  }'

 ```   

Refer [How to Create Framework](developer-docs/how-to-guide/how_to_create_framework_in_sunbird){:target="_blank"}, [How to Create Schemas for Knowledge Platform Objects](developer-docs/server-installation/knowledge-platform-object-schema){:target="_blank"}
