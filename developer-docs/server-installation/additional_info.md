---
title: Additional Variables for Core Service 
page_title: Additional Variables for Core service 
description: Provides information on the additional variables required if only the Sunbird Core service is installed
keywords: Core service variables, only core service deployment, use core service only
allowSearch: true
---

## Overview
This page provides with details of the additional variables that you need to set, if you want to install only Sunbird's Core Service and connect to the Knowledge Platform and Data Pipeline services running in the EkStep environment.
The variables need to be set in the **common.yml** and **secrets.yml** files.


## Variable List

In **common.yml**

|Variable Name | Sample Value | Used for/in|
|--------------|--------------|------------|
|ekstep_env| qa | qa or dev or prod env of Ekstep that you want to connect|
|sunbird_content_repo_api_base_url| "https://qa.ekstep.in/api" | qa or dev or prod env of Ekstep that you want to connect|
|sunbird_analytics_api_base_url| https://qa.ekstep.in/api| qa or dev or prod env of Ekstep that you want to connect|
|sunbird_search_service_api_base_url| https://qa.ekstep.in/api/search  |qa or dev or prod env of Ekstep that you want to connect|
|sunbird_cloud_storage_urls:|'https://s3.ap-south-1.amazonaws.com/ekstep-public-{{ekstep_s3_env}}/,https://ekstep-public-{{ekstep_s3_env}}.s3-ap-south-1.amazonaws.com/'| This value can be the same as this line|
|sunbird_ekstep_proxy_base_url:| https://qa.ekstep.in/  |qa or dev or prod env of Ekstep that you want to connect|
|upstream_url | "ekstep-public-{{ekstep_s3_env}}.s3-ap-south-1.amazonaws.com" | This value can be the same as this line |
|learningservice_ip|  | Dummy IP or provide IP of Swarm manager |
|keycloak_auth_server_url| "{{proto}}://{{ proxy_server_name }}:8080/auth" | This value can be the same as this line. If you use a LB for keycloak, remove port :8080|

In **secrets.yml**

|Variable Name | Sample Value | Description|
|--------------|--------------|------------|
|core_vault_sunbird_ekstep_api_key|  As3445h7788| The Ekstep key|

> **Note:** Update the following variables after onboarding consumers. The take the value for these variables from api-management-test-user file 

|Variable Name | Sample Value | Description|
|--------------|--------------|------------|
|core_vault_sunbird_api_auth_token| As238904934839883899dre| The Sunbird key after onboarding consumers|
|core_vault_kong__test_jwt| de54thH7892347678|  The Sunbird key after onboarding consumers
