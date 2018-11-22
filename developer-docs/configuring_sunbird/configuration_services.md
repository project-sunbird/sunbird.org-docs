---
title: Configuration Services
page_title: Configuration Services
description: Document on how to enable configuration services
published: true
allowSearch: true
---
## Overview

To address the overhead of managing configurations of various services, Sunbird provides the option of a central configuration service. The configuration services can be used to update configuration of any service on the fly without requiring a service redeployment.

This document details the procdures on how to manage the configuration services on Sunbird.

> **Note:** To effectively work with APIs, the administrator should be familiar with JSON structures and relevant tools to call APIs, like the Postman tool.

## Prerequisites

+  An intialized Sunbird instance with channel
+  API Key to access Sunbird APIs. To create an API key refer [How to generate a Sunbird API key](http://qa.docs.sunbird.org/1.10/developer-docs/how-to-guide/generate_apikey/)
+  Software that can make API calls like curl or [POSTMAN](https://www.getpostman.com/docs/v6/postman/api_documentation/intro_to_api_documentation)


## Chain Management for Configuration Services

## Creating Configuration Services

Initial / default configurations can be defined in HOCON format and made available with the code. Or these may be available through environment variables / external file hosted on cloud or a separate GIT repository. During bootstrapping, the configuration service should read a system configuration available through an environment variable and understand the source of rest of the configurations. It should then read from the specified location, parse and store with the attached storage.

## Updating Configuration Services

To add / update a configuration, a system admin would update the respective HOCON file (base config file) hosted on cloud or a GIT repository. These changes should be periodically picked up by a scheduled job which then triggers the utility / module to read the configuration changes, parse and store with the attached storage.

## Consuming Configuration Services



##API Reference

Create config
PUT - /config/v1/refresh

Request Object structure

"request": {
  "path": String, //Mandatory. The path to the configuration file on the configured cloud storage.
}
Response Object structure

"responseCode": "OK",
"result": {
}
Get config by params
POST - /config/v1/read

Request Object structure 

"request": {
  "keys": [String],   // Mandatory
Result Object structure






