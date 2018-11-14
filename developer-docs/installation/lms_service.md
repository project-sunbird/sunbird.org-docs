---
title: Developer Installation Of Learner Service
page_title: Developer Installation Of Learner Service
description: Installing  the Sunbird Learner Service
published: true
allowSearch: true
---

## Overview

This page provides information for you to install, setup, configure, run and use a Sunbird Learner Service instance on your laptop or desktop. The objective of such an installation is to demo and test the Learner application. It is not advised to use the instance for a production environment. Follow the instructions provided on this page to ensure an optimal installation experience. Before installing this on your laptop or desktop, ensure that the you have the necessary resources and compliant target systems. 

## System Requirements

To install Sunbird Learner Service, ensure that your laptop or desktop has the following minimum system requirements:

- Operating System: Linux  
- RAM: 4GB or more
- CPU: 2 cores, 2 GHz or more


## Sunbird Learner Service Setup

The following sections provide you with the sequence to setup the Sunbird Learner Service. 

### Prerequisites

**Software dependencies**
	
   * [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
   * [Maven](https://maven.apache.org/install.html)

**Essentials For Setting Up Sunbird Learner Service**
	
   * [Cassandra](developer-docs/installation/lms_service/#setup-cassandra) 
   * [ElasticSearch](developer-docs/installation/lms_service/#setup-elasticsearch)
   * [Keycloak](developer-docs/installation/lms_service/#setup-keycloak)
   * [Enviroment Variables](developer-docs/installation/lms_service/#set-env)
   

### Setup Cassandra <a name="setup-cassandra"></a>

1. Install Cassandra database and start the server (Use Cassandra version 3.*)
2. Clone the repository [sunbird-lms-mw](https://github.com/project-sunbird/sunbird-lms-mw)
3. Go to `sunbird-lms-mw/service/src/main/resources`
4. Run the **cassandra.cql** file to create the required keyspaces, tables and indices using the following command in cqlsh terminal
```" source 'sunbird-lms-mw/service/src/main/resources/cassandra.cql' "```  
5. Copy the files **pageMgmt.csv** and **pageSection.csv** to a temporary folder on the Cassandra machine. For example, **/tmp/cql/pageMgmt.csv and /tmp/cql/pageSection.csv**
6. Execute the below commands in the terminal: 

``` 
	   cqlsh -e "COPY sunbird.page_management(id, appmap,createdby ,createddate ,name ,organisationid ,portalmap ,updatedby ,updateddate ) FROM '/tmp/cql/pageMgmt.csv'"
       cqlsh -e "COPY sunbird.page_section(id, alt,createdby ,createddate ,description ,display ,imgurl ,name,searchquery , sectiondatatype ,status , updatedby ,updateddate) FROM '/tmp/cql/pageSection.csv'"
```

  7.Clone the repository (sunbird-utils)[https://github.com/project-sunbird/sunbird-utils] 

  ```
   $ cd {sunbird-utils folder}/cassandra-migration/
   $ mvn clean install -U -DskipTests
   $ mvn exec:java
  ```
  8. To verify the Cassandra installation use following commands:
  
    -> Step 7 should be completed without any errors.
    -> use "select * from sunbird.user" in cqlsh terminal, it will return an empty table.

### Setup ElasticSearch<a name="setup-elasticsearch"></a>

1. Download ElasticSearch (version 5.*) from "https://www.elastic.co/downloads/elasticsearch".
2. Install ElasticSearch database and start the server.
3. Use following command to verify elastic search "curl 'http://localhost:9200/?pretty' ".
4. If above step returns " Failed to connect to localhost port 9200: Connection refused " please reinstall or check elasticsearch setup.


### Setup Keycloak Server<a name="setup-keycloak"></a>

1. Get Keycloak (wget https://downloads.jboss.org/keycloak/4.0.0.Final/keycloak-4.0.0.Final.tar.gz)
2. Extract it and Start Cassandra and keycloak server (sh keycloak-4.0.0.Final/bin/standalone.sh).
3. Login to keycloak from browser (http://localhost:8080/auth) configure and update admin user.

### Set Environment Variables<a name="set-env"></a>

1. Set Configuration Variables please refer "http://docs.sunbird.org/latest/developer-docs/configuring_sunbird/env_variables_lms/"
 

## Build & Run Sunbird Learner Service

1. Clone the repository. (sunbird-lms-service)[https://github.com/project-sunbird/sunbird-lms-service]
2. 
 <pre>
   $ cd {sunbird-utils folder}/
   $ mvn clean install -U -DskipTests
   $ cd {sunbird-lms-mw folder}/
   $ mvn clean install -U -DskipTests
   $ cd {sunbird-lms-service folder}/
   $ mvn clean install -U -DskipTests
   $ cd service/
   $ mvn play2:run
</pre>
    


**Note:** use http://localhost:9000 as endpoint

