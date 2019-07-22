---
title: Configuring System settings
page_title: Configuring System settings
description: Configuring System settings
published: true
allowSearch: true
---

## Overview
The purpose of this document is to explain how a System Administrator can configure system setting for different purpose.
 * Setting custodian channel and orgId 
 * setting default framework id
 * setting comming soon 
 * tnc config
 * consumption faq


## Read already set values

command to verify which value is already set.{key} need to be replaced.
Here key is refering id which we are using in set curl command.

```
curl -X GET \
  {{sunbirdBaseURL}}/data/v1/system/settings/get/{key} \
  -H 'Authorization: Bearer {{api-key}}' \
  -H 'Content-Type: application/json'
```




## Define custodian channel configuration

Define Custodian channel configuration in Sunbird LMS using below cURL command.

```
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
```
## Define custodian org id configuration

Define Custodian org id configuration in Sunbird LMS using below cURL command.Use org id for above set custodian channel

```
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
```
## Define Content coming soon 

Define Content coming soon, this message will be defined for those rootOrg who won't have any content as of now.

```
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
```
## Define Course Framework ID configuration

Define Course Framework ID configuration in Sunbird LMS using below cURL command.
Same framework need to be created inside knowledge plateform.

```
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
```
## Define tnc config page

Define tnc configuration in Sunbird LMS using below cURL command.

```
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
```

## Define consumptionFaqs page

Define consumptionFaqs configuration in Sunbird LMS using below cURL command.

```
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
```



SNo. | Parameter | Description | Example
-------|-----------|-------------|---------
1 | custodianOrgChannel| set default channel into system. All self signup or Google sign up user will fall under this channel | sunbird
2 | custodianRootOrgId | set org id of above created  custodianOrgChannel | 
3 | contentComingSoonMsg| this message need to be set for those rootOrg which don't have content yet.
4 | courseFrameworkId | Framework ID to be used for course creation, this framework need to pe pre-created | TPD 
5 | tncConfig | terms and condition page |
6 | consumptionFaqs | public page url for consumption faq |

