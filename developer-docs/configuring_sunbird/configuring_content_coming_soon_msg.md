---
title: Configuring Tenant Specific Content Coming Soon Message
page_title: Configuring Tenant Specific Content Coming Soon Message
description: Technical document on configuring tenant specific content coming soon message
published: true
allowSearch: true
---

 ## Overview
Implementation approaches tenants for custom 'Coming Soon' messages to be displayed to users for empty nodes, a catch-all message for a book, or a catch-all message at the level of the tenant. This is then added into the system. Based on the detail up to which the tenant goes, the message is packaged with the book (to enable offline support as well), or with tenant specific information packaged with the app. The book or the tenant specific information can be updated from time to time, which results in the app eventually getting the updated information without having to upgrade the app.

When the node is filled with atleast one content, the message is anyway not displayed.

The purpose of this document is to explain how a Sunbird system administrator can configure tenant specific content coming soon message.

 ## Read content coming soon configuration

 Content coming soon configuration can be read using below cURL commands.

 ```
curl -X GET \
  {{sunbirdBaseURL}}/data/v1/system/settings/get/contentComingSoonMsg \
  -H 'Authorization: Bearer {{api-key}}' \
  -H 'Content-Type: application/json'
```

 ## Define content coming soon configuration

 Define content coming soon in Sunbird LMS using below cURL command.

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
        "value": "[{\"rootOrgId\":\"{{rootOrgId}}\",\"value\":\"Org specific coming soon message\",\"translations\":\"{\\\"en\\\":\\\"Coming soon message\\\"}\"},{\"rootOrgId\":\"{{rootOrgId}}\",\"value\":\"Org specific coming soon message\",\"translations\":\"{\\\"en\\\":\\\"Coming soon message\\\"}\"}]"
    }
}'
```

 SNo. | Parameter | Description | Example
-----|-----------|-------------|---------
1 | rootOrgId | Root organisation ID | 0126632859575746566, b00bc992ef25f1a9a8d63291e20efc8d
2 | value | Default message for content coming soon | Tenant specific content coming soon
3 | translations | Translations for the default message | \"{\\\"en\\\":\\\"Coming soon message\\\"}\"}
