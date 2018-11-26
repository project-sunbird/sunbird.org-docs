---
title: Configuration Services
page_title: Configuration Services
description: Document on how to enable configuration services
published: true
allowSearch: true
---
## Overview

Updating an instance on Sunbird can happen in following way:

1. Code update that requires code change and re-building instance  
2. Environment variables update that requires redeploying instance 
3. Database update in the runtime
4. Configuration Services that updates the database and the code instantly through APIs 

The system updates in Sunbird is catered using services configuration services. The configuration services uses a centralized method and thereby reducing the overhead of managing multiple components. They can be used to update configuration of any service instantly without requiring a service redeployment.

This document details the procedures on how to manage the configuration services on Sunbird.

> **Note:** To effectively work with APIs, the administrator should be familiar with JSON structures and relevant tools to call APIs, like the Postman tool.

## Prerequisites

1. An intialized Sunbird instance with channel with hierarchial structure
2. API Key to access Sunbird APIs. To create an API key refer [How to generate a Sunbird API key](http://qa.docs.sunbird.org/1.10/developer-docs/how-to-guide/generate_apikey/)
3. Software that can make API calls like curl or [POSTMAN](https://www.getpostman.com/docs/v6/postman/api_documentation/intro_to_api_documentation)


## Chain Management for Configuration Services

A heirarchial structure is followed in the rules that are defined to maintain the configuration services to run properly. 
The heirarchy is defined as:

1. Instance: contains the configuration variables in a well defined format, for that particular instance of Sunbird and the associated tenants    
2. Tenant: contains the configuration variables in a well defined format, for that tenant and its organizations
3. Organization: contains the configuration variables in a well defined format for the organization

Each level of heirarchy has defined microservices that needs configuration and contains the variables in the key-value pair that are unique. These key-value pairs are grouped for ease of access in different components of the instance. For example: the API_timeout is defined at all heirarchial level but contains different values for each level, in this case the configuration service has increased performance while changing the values of the variable. 

## Creating Configuration Services

The initial or the default configurations are defined in HOCON format and is available with the <*which*, need link> code. The configuration is available in [environment variables]() *external file hosted on cloud or a separate GIT repository*. During bootstrapping, the configuration service must read system configuration available through an environment variable and understand the source of rest of the configurations <need example>. It should read <what> from the specified location, parse and store with the attached storage.

## Updating Configuration Services

To add or update a configuration, a system admin updates the respective [HOCON file](*need link*) (base config file). These changes are periodically (can we specify time interval) picked up by a scheduled job which then triggers the utility or the module to read the configuration changes, parse it and store them in the  specified storage.

## Consuming Configuration Services

The configuration service connects with different services to retrieve (and update) configurations. These services include 

  - KV store service
  - Database
  - Environment variable
  - Properties file and so on
  
Depending on the consumer need it should be able to fetch the required configuration from the given service.

*(need an valid example)*

This configuration service should also support fallback among connected services. In case the required configuration is not available with a particular connected service, the client module should be able to query next in line service to retrieve the required configuration. The depth of fallback should not be limited to one so that the module may keep looking through all defined services for the particular configuration.

## API Reference

<>
Create config
1. Path for () `PUT - /config/v1/refresh`

#### Request Body for Object Structure

  "request": 
  {
    "path": String, //Mandatory. The path to the configuration file on the configured cloud storage
  }

#### Response Body for Object Structure

  "responseCode": "OK",
  "result": {
  }

Get config by params

1. Path for (): `POST - /config/v1/read`

#### Request Body for Object Structure 

  "request": {
    "keys": [String],   // Mandatory Result Object structure
  }

#### Response Body for Object Structure 





