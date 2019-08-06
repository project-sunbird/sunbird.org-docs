---
title: Configure System Settings
page_title: Configure System Settings
description: Describes how to configure system settings
published: true
allowSearch: true
---

## Overview

This page explains how a System Administrator can configure some settings in the system for different purposes. The following can be configured differently:

 * Custodian channel 
 * Custodian Org ID 
 * Default framework ID
 * Content Comming Soon page 
 * Terms & Conditions page
 * FAQs for User Consumption 
 
### Configurable Parameters  

|S No.| Parameter | Description | Example|
|----|-----------|-------------|---------|
|1 | custodianOrgChannel| set default channel into system. The self sign-up or Google sign up user are under this channel | sunbird|
|2 | custodianRootOrgId | set org id of custodianOrgChannel created earlier |  |
|3 | contentComingSoonMsg| message for the rootOrgs whose content is being created or they don't have content yet |  |
|4 | courseFrameworkId | framework ID for course creation, this framework needs to be created first | TPD |
|5 | tncConfig | terms and condition page | |
|6 | consumptionFaqs | public page url for consumption FAQ | |

## Read Values that are Already Set

Use the following curl command to check the value that is already set for a particular parameter. Replace the value in the {key} with the required ID. The key refers to the ID to be configured using the cURL command.

    curl -X GET \
      {{sunbirdBaseURL}}/data/v1/system/settings/get/{key} \
      -H 'Authorization: Bearer {{api-key}}' \
      -H 'Content-Type: application/json'


## Configure Custodian Channel 

Configure the Sunbird LMS custodian channel ID using the following cURL command.


    curl -X POST \
      {{sunbirdBaseURL}}/data/v1/system/settings/set \
      -H 'Authorization: Bearer {{api-key}}' \
      -H 'Content-Type: application/json' \
      -H 'X-Authenticated-User-Token: {{user-token}}' \
      -d '{
      "request": {
                    "id": "custodianOrgChannel",
                    "field": "custodianOrgChannel",
                    "value": "{{custodianOrgChannelValue}}"
                }
    }'

## Configure Custodian Org ID

Configure the Sunbird LMS custodian Org ID using the following cURL command. Use the Org ID for the custodian channel set earlier. The custodian channel ID and the custodian Org ID work as a pair.


    curl -X POST \
      {{sunbirdBaseURL}}/data/v1/system/settings/set \
      -H 'Authorization: Bearer {{api-key}}' \
      -H 'Content-Type: application/json' \
      -H 'X-Authenticated-User-Token: {{user-token}}' \
      -d '{
      "request": {
                    "id": "custodianRootOrgId",
                    "field": "custodianRootOrgId",
                    "value": "{{custodianRootOrgIdValue}}"
                }
    }'


## Confifure the Content Coming Soon page

Configure the message on the Content Coming Soon page using the following cURL command. This message is used by those root organizations that do not have any content, as on date.


    curl -X POST \
      {{sunbirdBaseURL}}/data/v1/system/settings/set \
      -H 'Authorization: Bearer {{api-key}}' \
      -H 'Content-Type: application/json' \
      -H 'X-Authenticated-User-Token: {{user-token}}' \
      -d '{
      "request": {
                    "id": "contentComingSoonMsg",
                    "field": "contentComingSoonMsg",
                    "value": "[{\"rootOrgId\":\"{RootOrgId}\",\"value\":\"Org specific coming soon message\",\"translations\":\"{\\\"en\\\":\\\"Coming soon message\\\"}\"}\"}]"
                }
    }'


## Configure Course Framework ID 

Configure the Sunbird LMS Course Framework ID using the following cURL command. Create the same framework in the Knowledge Platform sub system.


    curl -X POST \
      {{sunbirdBaseURL}}/data/v1/system/settings/set \
      -H 'Authorization: Bearer {{api-key}}' \
      -H 'Content-Type: application/json' \
      -H 'X-Authenticated-User-Token: {{user-token}}' \
      -d '{
      "request": {
                    "id": "courseFrameworkId",
                    "field": "courseFrameworkId",
                    "value": "{{courseFrameworkId}}"
                }
    }'


## Configure the Terms and Conditions page

Configure the Sunbird LMS Terms and Conditions page configuration using the following cURL command.

    curl -X POST \
      {{sunbirdBaseURL}}/data/v1/system/settings/set \
      -H 'Authorization: Bearer {{api-key}}' \
      -H 'Content-Type: application/json' \
      -H 'X-Authenticated-User-Token: {{user-token}}' \
      -d '{
      "request": {
                    "id": "tncConfig",
                    "field": "tncConfig",
                    "value": "{"latestVersion":"v1","v1":{"url":"{public url for config html page}"}}"
                }
    }'


## Configure FAQs for User Consumption

Confifure the Sunbird LMS FAQs for users using the following cURL command.


    curl -X POST \
      {{sunbirdBaseURL}}/data/v1/system/settings/set \
      -H 'Authorization: Bearer {{api-key}}' \
      -H 'Content-Type: application/json' \
      -H 'X-Authenticated-User-Token: {{user-token}}' \
      -d '{
      "request": {
                    "id": "consumptionFaqs",
                    "field": "consumptionFaqs",
                    "value": "{consumption faq public html page url}"
                }
    }'




