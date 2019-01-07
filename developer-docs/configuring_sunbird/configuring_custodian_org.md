---
title: Configuring Custodian Organisation
page_title: Configuring Custodian Organisation
description: Technical document on configuring custodian organisation
published: true
allowSearch: true
---

## Overview
Self signed up users are by default added to a custodian organisation. 

The purpose of this document is to explain how a Sunbird system administrator can configure an existing root organisation as the custodian organisation.

## Read custodian organisation configuration

Existing custodian root organisation ID and channel configuration can be read using below cURL commands.

```
curl -X GET \
  {{sunbirdBaseURL}}/data/v1/system/settings/get/custodianOrgId \
  -H 'Authorization: Bearer {{api-key}}' \
  -H 'Content-Type: application/json'
```

```
curl -X GET \
  {{sunbirdBaseURL}}/data/v1/system/settings/get/custodianRootOrgId \
  -H 'Authorization: Bearer {{api-key}}' \
  -H 'Content-Type: application/json'
```

```
curl -X GET \
  {{sunbirdBaseURL}}/data/v1/system/settings/get/custodianOrgChannel \
  -H 'Authorization: Bearer {{api-key}}' \
  -H 'Content-Type: application/json'
```

## Define custodian organisation configuration

Define custodian organisation ID in Sunbird LMS using below cURL command.

```
curl -X POST \
  {{sunbirdBaseURL}}/data/v1/system/settings/set \
  -H 'Authorization: Bearer {{api-key}}' \
  -H 'Content-Type: application/json' \
  -H 'X-Authenticated-User-Token: {{user-token}}' \
  -d '{
  "request": {
                "id": "custodianOrgId",
                "field": "custodianOrgId",
                "value": "{{custodianOrgId}}"
            }
}'
```

Define custodian root organisation ID in Sunbird LMS using below cURL command.

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
                "value": "{{custodianOrgId}}"
            }
}'
```

Define custodian organisation channel in Sunbird LMS using below cURL command.

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
                "value": "{{custodianOrgChannelName}}"
            }
}'
```

SNo. | Parameter | Description | Example
-----|-----------|-------------|---------
1 | custodianOrgId | Custodian organisation ID | 0126632859575746566
2 | custodianRootOrgId | Custodian Root organisation ID | 0126632859575746566
3 | custodianOrgChannelName | Custodian organisation channel name | ntpDefault

