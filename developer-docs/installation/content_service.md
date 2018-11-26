---
title: Content Service
page_title: Content Service
description: Details on content service avaialable on Sunbird
published: true
allowSearch: true
---

## Overview
This Document is created to help the developers to set-up content service in local linux machine.

## System Requirements

To install Sunbird Content Service, ensure that your laptop or desktop has the following minimum system requirements:

- Operating System: Linux  
- RAM: 2GB or more
- CPU: 1 cores, 2 GHz or more

### Pre-requisites

1. [Install node](https://nodejs.org/en/download/)
2. [Install Imagemagick](https://www.npmjs.com/package/gm)
3. [Install Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

### Environment Variables:

    sunbird_content_provider_api_base_url: content provider API base url. e.g.: https://qa.ekstep.in or https://api.ekstep.in
    sunbird_content_provider_api_key: API key for the above content provider URL please refer http://docs.sunbird.org/latest/developer-docs/telemetry/authtokengenerator_jslibrary/#how-to-generate-authorization-credentials for api keys.
    sunbird_content_plugin_base_url: Content plugin base url. e.g.: https://qa.ekstep.in or https://community.ekstep.in
    sunbird_keycloak_auth_server_url: Sunbird keycloak auth server url e.g.: https://dev.open-sunbird.org/auth (string)
    sunbird_keycloak_realm: Sunbird keycloak realm e.g.: sunbird (string)
    sunbird_keycloak_client_id: Sunbird keycloak client id e.g: portal (string)
    sunbird_keycloak_public: Sunbird keycloak public e.g.: true (boolean)
    sunbird_cache_store: Sunbird cache store e.g.: memory (string)
    sunbird_cache_ttl: Sunbird cachec time to live e.g.: 1800(number)
    sunbird_image_storage_url
    sunbird_azure_account_name
    sunbird_azure_account_key
    sunbird_dial_code_registry_url eg: staging.open-sunbird.org/dial/
    sunbird_cassandra_ips e.g : 127.0.0.1,127.0.0.2
    sunbird_cassandra_port e.g: 9042
    sunbird_telemetry_sync_batch_size e.g: 20
    sunbird_learner_service_local_base_url e.g: 'http://learner-service:9000'

### Setup Instructions

    Clone the project from https://github.com/project-sunbird/sunbird-content-service .
    Run "git clone --recursive  git@github.com:project-sunbird/sunbird-content-service.git"
    Change to src folder
    Run npm install
    If above step returns output  "npm WARN lifecycle content-service@1.11.1~preinstall: cannot run in wd content-service@1.11.1 
    npm install ./libs/sb-config-util && npm install ./libs/sb-http-util && npm install ./libs/sb_content_provider_util && npm install ./libs/sb_logger_util && npm install ./libs/sb_req_validator_util && npm install ./libs/response_util && 
    npm install ./libs/sb_api_interceptor && npm install ./libs/sb_cache_manager && npm install ./libs/sb_telemetry_util 
    (wd=~/sunbird-content-service/src)" , Please install all above npm packages manually  .
    Use "node app.js" to run.
   
    

##### Output will be 

```
Telemetry is initialized.

Error fetching default channel null

DEFAULT_CHANNEL sunbird

server running at PORT [5000]
```
