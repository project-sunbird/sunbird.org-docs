---
title: Configuring Consumtion FAQs
page_title: Configuring Consumtion FAQs
description: Technical document on configuring consumption FAQs
published: true
allowSearch: true
---

 ## Overview
Based on configuration, users are can explore FAQs. 

 The purpose of this document is to explain how a Sunbird system administrator can configure FAQs for Sunbird users.

 ## Read consumption FAQs configuration

 FAQs configuration can be read using below cURL commands.

 ```
curl -X GET \
  {{sunbirdBaseURL}}/api/data/v1/system/settings/get/consumptionFaqs \
  -H 'Authorization: Bearer {{api-key}}' \
  -H 'Content-Type: application/json'
```

 ## Define consumption FAQs configuration

 Define consumption FAQs configuration in Sunbird LMS using below cURL command.

 ```
curl -X POST \
  {{sunbirdBaseURL}}/api/data/v1/system/settings/set \
  -H 'Authorization: Bearer {{api-key}}' \
  -H 'Content-Type: application/json' \
  -H 'X-Authenticated-User-Token: {{user-token}}' \
  -d '{
  "request": {
                "id": "consumptionFaqs",
                "field": "consumptionFaqs",
                "value": "{{consumptionFaqsPublicUrl}}"
            }
}'
```

 SNo. | Parameter | Description | Example
-------|-----------|-------------|---------
1 | consumptionFaqsPublicUrl | Public URL where consumption FAQs HTML is hosted | https://some.domain.net/consumption-faqs.html
