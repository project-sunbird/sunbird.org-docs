---
type: landing
directory: developer-docs/installation
title: Installing Sunbird Backend
page_title: Installing Sunbird Backend
description: Installing Sunbird Backend requires the backend API interface.
published: true
allowSearch: true
---
## Overview

The purpose of this section is to assist you:
  - with the installation of Sunbird LMS service on your local machine 
  - in testing Sunbird LMS service and API workflows

## Prerequisites

Before set up of Sunbird LMS service, following prerequisites need to be installed. 

1. [Apache Cassandra v3.10](http://archive.apache.org/dist/cassandra/3.10/)

2. [Elastic Search v5.4.0](https://www.elastic.co/downloads/past-releases/elasticsearch-5-4-0)

3. [Keycloak v3.2.1](https://www.keycloak.org/archive/downloads-3.2.1.html) 

After installation, keycloak administration console is accessible at `http://localhost:8080`. 

4. [PostgreSQL v9.5.14](https://www.postgresql.org/ftp/source/v9.5.14/)

5. [Badgr](https://github.com/concentricsky/badgr-server) (integrated with master branch and commit SHA e6b8568798686217d1b9fff06dde57e0a681dd25)

## Building Sunbird LMS Service

Following are the steps to build Sunbird LMS Service:
1. Clone source code from `sunbird-lms-service` repository
```
git clone https://github.com/project-sunbird/sunbird-lms-service.git
```
2. Fetch source code for submodules
```
cd sunbird-lms-service
git submodule update --init --recursive --remote
```
3. Build `sunbird-lms-service`
```
cd sunbird-lms-service
mvn clean install -DskipTests
```

## Minimal Configuration

The following environment variables are part of minimalistic required configuration to get Sunbird LMS Service up and running. For complete list of supported environment configuration variables, please refer [LMS Service Environment Variables](http://docs.sunbird.org/latest/developer-docs/configuring_sunbird/env_variables_lms/).

| Environment Variable | Description |
|----------------------|-------------|
| sunbird_cassandra_host | Comma-separated list of Cassandra cluster node IP addresses. |
| sunbird_cassandra_port | Comma-separated list of Cassandra cluster node ports. |
| sunbird_es_host | Comma-separted list of Elastic search node IP addresses. |
| sunbird_es_port | Comma-separated list of Elastic search node ports. |
| sunbird_sso_url      | Base URL of Keycloak server. (e.g. http://localhost:8080/auth/) |
| sunbird_sso_realm    | Realm of Keycloak server. Use default realm as master or you can create a new realm. |
| sunbird_sso_username | Keycloak admin user name. |
| sunbird_sso_password | Keycloak admin user password. |
| sunbird_sso_client_id | Keycloak client ID. Use default as admin-cli or you can create new client in Keycloak. |
| sunbird_installation | Sunbird installation name. |
| sunbird_quartz_mode | Mode (embedded or cluster) of quartz scheduler jobs. In cluster mode, PostgreSQL configuration is required. Set value as "embedded" for local installation. |
| ekstep_api_base_url | Base URL of EkStep platform. EkStep platform base URL is used to invoke platform functionality (e.g. Content APIs). |
| ekstep_authorization | API key to use for authentication with EkStep platform. |

e.g.
```
export sunbird_cassandra_host=localhost
export sunbird_cassandra_port=9042

export sunbird_es_host=localhost
export sunbird_es_port=9300

export sunbird_sso_url="http://localhost:8080/auth/"
export sunbird_sso_realm=master
export sunbird_sso_username=admin
export sunbird_sso_password=admin123
export sunbird_sso_client_id=admin-cli

export sunbird_installation=local
export sunbird_quartz_mode=embedded

export ekstep_api_base_url="https://staging.open-sunbird.org/api"
export ekstep_authorization="your-auth-key"
```

## Creating Sunbird LMS Service Schema

1. First run `cassandra.cql` script to create Sunbird keyspace, initial set of tables and indices. [cassandra.cql](https://github.com/project-sunbird/sunbird-lms-mw/blob/master/actors/src/main/resources/cassandra.cql) all cql to create the required keyspace, tables and indices
```
cqlsh -f sunbird-lms-service/actors/sunbird-lms-mw/service/src/main/resources/cassandra.cql
```
2. Next, perform migration.
```
cd sunbird-lms-service/actors/sunbird-lms-mw/actors/sunbird-utils/cassandra-migration
mvn clean install -DskipTests
mvn exec:java
```

### Running Sunbird LMS Service

1. Run following command.
```
cd sunbird-lms-service/service
mvn play2:run
```
**Note**: For running Sunbird LMS Service in debug mode use below command and perform remote debugging on port 9999.
```
mvn play2:run -Dplay2.serverJvmArgs="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=9999"
```

## Sunbird LMS Service Initialisation

Sunbird LMS Service initialisation involves following steps to create first root organisation and user.

1. Create a user in Keycloak.

2. Generate JWT token using following curl command with created user credentials.

```
curl -X POST 
  {{keycloak-base-url}}/auth/realms/{realm-name}/protocol/openid-connect/token 
  -H 'cache-control: no-cache' 
  -H 'content-type: application/x-www-form-urlencoded' 
  -d 'client_id={client-id}&username={username}&password={password}&grant_type=password'
```

3. Use `access_token` in the response to create first root organisation using [Organisation Management APIs](http://docs.sunbird.org/latest/apis/orgapi/).

4. Create first Sunbird user in LMS Service using [User APIs](http://docs.sunbird.org/latest/apis/userapi/).

Now that you are done with Sunbird LMS Service initialisation, you may onboard several other users and sub-organisations onto the platform.
