---
title: Configuring Terms and Conditions
page_title: Configuring Terms and Conditions
description: Technical document on configuring terms and conditions
published: true
allowSearch: true
---

## Overview
Based on configuration, users are prompted to accept terms and conditions on first login or whenever a new version of terms and conditions are available. 

The purpose of this document is to explain how a Sunbird system administrator can configure a new version of terms and conditions for Sunbird users.

## Read terms and conditions configuration

Terms and conditions configuration can be read using below cURL commands.

```
curl -X GET \
  {{sunbirdBaseURL}}/data/v1/system/settings/get/tncConfig \
  -H 'Authorization: Bearer {{api-key}}' \
  -H 'Content-Type: application/json'
```

## Define terms and conditions configuration

Define terms and conditions configuration in Sunbird LMS using below cURL command.

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
                "value": "{
                            \"latestVersion\": \"{{tncVersion}}\",
                            \"{{tncVersion}}\": {
                              \"url\": \"{{tncPublicUrl}}"
                            }
                }"
            }
}'
```

SNo. | Parameter | Description | Example
-------|-----------|-------------|---------
1 | tncVersion | Version of terms and conditions | v1
2 | tncPublicUrl | Public URL where terms and conditions HTML is hosted | https://some.domain.net/portal/terms-and-conditions-v1.html

