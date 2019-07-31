---
title: Portal Service Environment Variables  
page_title: Portal Service Environment Variables 
description: List of environment variables needed to operationalize and customize Sunbird 
published: true
allowSearch: true
---

## Overview
This page provides a list of environment variables with their default values, description and purpose as required to run the Sunbird portal service. To change default behavior, modify the variable value based on your requirements.

## Variable List

| **S No** | **Variable Name** | **Description** | **Purpose** | **Default Value** |
|----|------| ----------------------- | ---------------------- |---|------|
| 1 | sunbird_portal_realm | Represents the Keycloak realm value | The realm value of Keycloak to update in each installation | sunbird |
| 2 | sunbird_portal_auth_server_url | Represents the Keycloak authorization service URL | To connect to the Keycloak server | https://staging.open-sunbird.org/auth | 
| 3 | sunbird_portal_auth_server_client | Represents the client ID of the Keycloak client | To update the client ID | portal | 
| 4 | sunbird_environment | Represents the environment where the instance is running | To send the telemetry with proper pdata and for other purposes | | 
| 5 | sunbird_instance | Represents the name of the instance | To set up the name of the instance | | 
| 6 | sunbird_learner_player_url | Represents the learner service proxy URL | To change the learner service proxy URL | https://staging.open-sunbird.org/api/ | 
| 7 | sunbird_content_player_url | Represents the content service proxy URL | To change content service proxy URL | https://staging.open-sunbird.org/api/ | 
| 8 | sunbird_content_proxy_url | Represents the proxy URL address to load plugins | To load plugins | https://staging.open-sunbird.org | 
| 9 | sunbird_default_channel | Represents the default channel of the installation, same as in learner service and content service | To set default channel for installation | | 
| 10 | sunbird_api_auth_token | Represents the auth token to connect APIs | To connect the services | | 
| 11 | sunbird_telemetry_packet_size | Represents the size of the batch to sync data | To set the size of events to be synced | 20 | 
| 12 | sunbird_echo_api_url | Represents the URL to validate the SSO token | To validate the JWT Token from the trampoline service | https://staging.open-sunbird.org/api/echo/ | 
| 13 | sunbird_autocreate_trampoline_user | In case there are no users, auto create a user from the trampoline service | To change the handle for user creation from trampoline service | true |
| 14 | sunbird_trampoline_client_id |Represents the trampoline client ID | To identify the client using the trampoline service | trampoline |
| 15 | sunbird_trampoline_secret | Represents the trampoline secret | | |
| 16 | sunbird_session_store_type | Represents the storage to store portal sessions | To set the storage type | in-memory | 
| 17 | sunbird_portal_title_name | Represents the title displayed in browser | To update title name for browser | Sunbird |
| 18 | sunbird_portal_cdn_url | Represents the CDN BASE URL where static assets are stored | To update the CDN based on implementation| |
| 19 | sunbird_portal_default_language | To set the default language of the portal | Set the display language of the portal | en | 
| 20 | sunbird_dataservice_url | Represents the data service URL | The URL to access the data services |https://staging.open-sunbird.org/api/ | 
| 21 | sunbird_keycloak_public | Represents the keycloak | | true | 
| 22 | sunbird_keycloak_realm | Represents the Keycloak realm| | sunbird | 
| 23 | sunbird_content_channel_filter_type | Represents the filter type to show content based on the applied filter. By default it is set to 'all' which displays all content. If set to 'self', it shows the current channel content | | all |
| 24 | sunbird_android_app_url | Represents the android app URL in play store | Used to set the android app URL | http://www.sunbird.org |
| 25 | sunbird_enable_signup | Enables and disables signup functionality | To enable and disable sign-in functionality | true | 
| 26 | sunbird_api_response_cache_ttl | Represents the Time-to-Live (TTL) for the API response cache in seconds | To set cache for API responses in seconds | 600 |
| 27 | sunbird_tenant_cdn_url | Represents the URL of the CDN, the tenant specific files are stored here | To render the static tenant pages from the CDN | |
| 28 | sunbird_cloud_storage_urls | URLs are stored and get the assets passed to editors from portal as config | To change the assets and data storage by setting this env | |
| 29 | sunbird_portal_user_upload_ref_link | URL of the user upload instruction document | To get the instruction about user upload | http://www.sunbird.org/features-documentation/register_user |
| 30 | config_service_enabled | To enable/disable the fetching of configuration details from config service | To enable/disable the fetching of configuration details | false |
| 31 | config_refresh_interval | Represents the interval in minutes to refresh the fetching of configurations | To set the interval of time within which configurations are refreshed | 1440 |
| 32 | sunbird_cassandra_urls | Represents the URLs of Cassandra instance | Used to connect to the Cassandra db | 127.0.0.1:9042 | 
| 33 | sunbird_cassandra_consistency_level | Represents the minimum number of Cassandra nodes that must acknowledge a read or write operation before the operation can be considered successful | Used to mantain the data consistency of multi node Cassandra | one |
| 34 | sunbird_cassandra_replication_strategy | Represents data replication of Cassandra | To replicate the Cassandra data set | '{"class":"SimpleStrategy","replication_factor":1}' |
| 35 | device_register_api | Device registry Api | To register/capture IP address/geo-location/device information | https://api.open-sunbird.org/v3/device/register/ |
| 36 | sunbird_azure_account_name | Azure account name | To login to Azure account | |
| 37 | sunbird_azure_account_key | Azure account key | To login to Azure account | |
| 38 | sunbird_azure_report_container_name | Container for storing reports | To store organization reports | reports |
| 39 | sunbird_response_cache_ttl | API response cache time | API response is cached with configured time in browser | 180 |
| 40 | sunbird_health_check_enable | To enable/disable health check API | If dependent service is down, api call will not be proxy-ed if value is set to true | true |
| 41 | sunbird_cassandra_consistency_level | Cassandra consistency level | Used in cassandra configuration | one |
| 42 | sunbird_processing_kafka_host | Processing Kafka host URL | To send Kafka messages to process  Kafka host URL | |
| 43 | sunbird_sso_ kafka_topic | Kafka topic for SSO | To send Kafka messages in SSO flow | |
| 44 | sunbird_portal_preview_cdn_url | Content player CDN preview URL | To load the content player from CDN | |

