---
title: Configuring Course Framework id into system settings
page_title: Configuring Course Framework Id
description: Technical document on configuring Course Framework Id
published: true
allowSearch: true
---

## Overview
Based on configuration, Course filtres will be populated  

The purpose of this document is to explain how a Sunbird system administrator can configure framework id for course

## Read terms and conditions configuration

Course Framework Id configuration can be read using below cURL commands.

```
curl -X GET \
  {{sunbirdBaseURL}}/data/v1/system/settings/get/courseFrameworkId \
  -H 'Authorization: Bearer {{api-key}}' \
  -H 'Content-Type: application/json'
```

## Define terms and conditions configuration

Define Course Framework Id configuration in Sunbird LMS using below cURL command.

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
                "value": "{{TPD}}"
            }
}'
```


SNo. | Parameter | Description | Example
-------|-----------|-------------|---------
1 | TPD | Framework id which will be used for course filter | 
