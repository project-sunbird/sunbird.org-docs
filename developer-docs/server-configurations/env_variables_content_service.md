---
title: Content Service Environment Variables
page_title: Content Service Environment Variables
description: List of Environment variables required to operationalize the Sunbird content service 
published: true
allowSearch: true
---

## Overview

The page contains the list of environment variables, their descriptions, purpose and sample values, as required to run the Sunbird content service. To change default behavior, modify the variable value to suit your need or purpose.

## Variable List
 	 
| S No. | Variable Name | Description| Purpose | Sample Value |
|-------|---------------|------------|----------|-------------|
| 1 | ekstep_telemetry_storage_toggle | Represents the toggle to turn the EkStep telemetry storage on or off | To turn the telemetry on or off | on |	
| 2 | sunbird_extcont_whitelisted_domains | Represents the file that stores the whitelisted domains in a comma-separated format | To store the white listed domains| youtube.com.youtu.be |
| 3 | sunbird_default_channel | Represents the default channel to generate telemetry, if nothing is sent from client headers. This is the same as specified in the learner service. It should be a valid root org | To ensure there is a channel for each telemetry event generated | |
| 4 | sunbird_content_plugin_base_url | Represents the proxy URL to the content plugins repository<br/> This is needed only in the dev setup. In the server environment, plugins are handled by the nginx proxy | To update the plugins base URL | https://qa.ekstep.in |
| 5 | sunbird_content_provider_api_base_url | Represents the base URL of the content provider | To update the content provider URL | https://qa.ekstep.in/api |
| 6 | sunbird_content_provider_api_key | Represents the API Key to authorize the content provider | To authorize the content provider | |
| 7 | sunbird_environment | Represents the instance environment | To identify the environment to which to send telemetry data with proper pdata. It is also used for other related purposes | |
| 8 | sunbird_instance | Represents the name of the instance. This should be the same as the value in the player/learner-service | To set the name of the instance | |
| 9 | sunbird_cassandra_urls | Represents the URLs of Cassandra instance | To connect to Cassandra db | 127.0.0.1:9042 |
| 10 | sunbird_cassandra_consistency_level | Represents the minimum number of Cassandra nodes that must acknowledge a read or write operation before the operation can be considered successful | To mantain the data consistency of multi node Cassandra | one |
| 11 | sunbird_cassandra_replication_strategy | Represents data replication of cassandra | To replicate the Cassandra data set | '{"class":"SimpleStrategy","replication_factor":1}' |
| 12 | sunbird_keycloak_auth_server_url | The URL of the Keycloak auth service to connect the Sunbird Content service | To connect the Keycloak server | https://staging.open-sunbird.org/auth |
| 13 | sunbird_keycloak_realm | Represents the keycloak realm value | To update the realm value of Keycloak, per installation | Sunbird |
| 14 | sunbird_keycloak_client_id | Represents the client ID in Keycloak | To update the client ID in Keycloak | portal |
| 15 | sunbird_keycloak_public | Represents the Keycloak type | To specify the keycloak public type | true |
| 16 | sunbird_image_storage_url | Represents the base URL where images are stored after generating the qrcode images | To edit the storage URL | |
| 17 | sunbird_dial_code_registry_url | Represents the base URL of the qr code image generated | To set the base URL for qr code | |
| 18 | sunbird_azure_account_name | Represents the Azure account name to connect to Azure storage | To connect the Azure account | |
| 19 | sunbird_azure_account_key | Represents the azure account key to connect to the Azure storage | To connect to Azure | |
| 20 | sunbird_telemetry_sync_batch_size | Represents the batch size to sync data | To set the size of events to be synced | 20 |
| 21 | sunbird_content_service_whitelisted_channels | Represents list of whitelisted channels (comma separated) | To whitelist channels | $.instance.all |
| 22 | sunbird_content_service_blacklisted_channels | Represents list of blacklisted channels (comma seperated) | To blacklist channels | 1.23E+19 | 
| 23 | sunbird_content_service_channel_refresh_cron | Represents the node cron interval string | To run cron every 5 minutes. enabled only if $.instance.all is present in whitelisted channels) | */5**** | 
| 24 | sunbird_content_service_whitelisted_framework| Represents list of whitelisted frameworks (comma seperated) | To whitelist frameworks while searching for content | NCF, NCFCOPY |
| 25 | sunbird_content_service_blacklisted_contenttype | Represents list of blacklisted content types(comma sepertaed) | To blacklist contenttype while searching for content | Asset | 
| 26 | sunbird_content_service_blacklisted_resourcetype | Represents list of blacklisted resource types(comma seperated) | To blacklist contenttype while searching for content | Lesson plan | 
| 27 | sunbird_content_service_blacklisted_mimetype | Represents list of blacklisted mime types(comma seperated) | To blacklist mimetype while searching for content | video/x-youtube | 
| 28 | sunbird_content_service_enable_logging | To enable or disable the content service logging | | True |
| 29 | sunbird_content_repo_api_base_url | Represents the proxy URL to the content repository | | https://qa.ekstep.in/api |
| 30 | sunbird_content_repo_api_key | Represents the proxy URL API key for the content repository | | |
| 31 | sunbird_search_service_api_base_url | Represents the proxy URL to the search service| | https://qa.ekstep.in/api/search|
| 32 | sunbird_search_service_api_key | Represents the proxy URL API key for the search service | | True |
| 33 | sunbird_dial_repo_api_base_url | Represents the proxy URL to the dial repository | | https://qa.ekstep.in/api |
| 34 | sunbird_dial_repo_api_key | Represents the proxy URL API key for the dial repository | | |
| 35 | sunbird_plugin_repo_api_base_url | Represents the proxy URL to the plugin repository for searching plugins | | https://qa.ekstep.in/api |
| 36 | sunbird_plugin_repo_api_key | Represents the proxy URL API key to the plugin repository for searching plugins | | |
| 37 | sunbird_data_service_api_base_url | Represents the proxy URL to the data service | | https://qa.ekstep.in/api |
| 38 | sunbird_data_service_api_key | Represents the proxy URL API key for the data service | | |
| 39 | sunbird_language_service_api_base_url | Represents the proxy URL to the language service | | https://qa.ekstep.in/api/language|
| 40 | sunbird_language_service_api_key | Represents the proxy URL API key for the language service | | |
| 41 | sunbird_portal_base_url | To construct the content link which will be sent in the email and also to read the Form API | | https://staging.open-sunbird.org |
| 42 | sunbird_gzip_enable | Specifies the API response is enabled or disabled for zipping | | |
| 43 | sunbird_cassandra_consistency_level | Provides consistency level in cassandra| | |
| 44 | sunbird_cassandra_replication_strategy | Specifies the cassandra replication strategy | | |
| 45 | sunbird_health_check_enable | Specifies that the health check of the dependant services to be checked or not (ex: true/false)| | |
| 46 | sunbird_content_service_log_level | Specifies the log level of this service (ex: info, debug, error, warn)| | |

** Related Pages**
* [Import External Content](..\configuring_domain_ext_links.md)
* [Content Filtering](..\content_filtering.md)
