---
title: Configuration Service Environment Variables  
page_title: Configuration Service Environment Variables 
description: List of environment variables needed to operationalize and customize Sunbird 
published: true
allowSearch: true
---

This document provides a list of environment variables and their default values required to run Sunbird configuration service. The list also provides the description and purpose of these variable. Modifying the variable value allows you to change default behavior based on your requirements.      

|  **S No** | **Variable Name** | **Description** | **Purpose** | **Default Value** | **Path** |
|  ------ | ------ | ------ | ------ | ------ | ------ |
|  1 | aws_storage_key | Represents the AWS access key ID |  |  | Sunbird Config Service |
|  2 | aws_storage_secret  | Represents the AWS access key ID  | | | Sunbird Config Service  |
|  3 | aws_storage_container | Represents the S3 container name where the configuration file is maintained  | | | Sunbird Config Service  |
|  4 | azure_storage_key  | Represents the Azure account name  | | | Sunbird Config Service |
|  5 | azure_storage_secret | Represents the Azure account access key |  |  | Sunbird Config Service |
|  6 | azure_storage_container | Represents the blob storage container where the configuration file is maintained  | | | Sunbird Config Service  |
|  7 | cloud_storage_type | Represents the cloud storage type to be used for configuration files |  | azure | Sunbird Config Service |
|  8 | sunbird_email_max_recipients_limit | Configuration to set a limit the maximum number of recipients in an email notification | To restrict mass mailers from platform beyond the configured limit | 100 | Sunbird Config Service |
|  7 | sunbird_cassandra_host | |  | cassandra-host | Sunbird Config Service |
|  8 | sunbird_cassandra_port | |  | 9042 | Sunbird Config Service |
|  9 | sunbird_cassandra_username| |  | cassandra | Sunbird Config Service |
|  10 | sunbird_cassandra_password | |  | password | Sunbird Config Service |
