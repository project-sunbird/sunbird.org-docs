---
title: Configuring Course Framework ID
page_title: Configuring Course Framework ID
description: Configuring Course Framework ID
published: true
allowSearch: true
---

## Overview
The purpose of this document is to explain how a System Administrator can configure Course Framework ID that allows an application to use a specific framework for creating courses.

## Read Course Framework ID configuration

Course Framework ID configuration can be read using below cURL command.

```
curl -X GET \
  {{sunbirdBaseURL}}/data/v1/system/settings/get/courseFrameworkId \
  -H 'Authorization: Bearer {{api-key}}' \
  -H 'Content-Type: application/json'
```

## Define Course Framework ID configuration

Define Course Framework ID configuration in Sunbird LMS using below cURL command.

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


SNo. | Parameter | Description | Example
-------|-----------|-------------|---------
1 | courseFrameworkId | Framework ID to be used for course creation | TPD 
