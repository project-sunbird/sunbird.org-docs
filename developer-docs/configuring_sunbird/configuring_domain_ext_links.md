---
title: Import External Content 
page_title: Import External Content
description: Details on how to configure Sunbird domain to whitelist external domains
keywords: whitelist, upload external link, upload external video, upload other than youtube
published: true
allowSearch: true
---
## Overview

Sunbird platform allows adopters/users (content creator) to upload content from external sources. Using this option, users can upload content from the external sources to sunbird content library.They can upload external content from different websites such as youtube, Dailymotion and so on. This section explains the procedure of enabling a domain to host content from external sources. 

## Intended Audience
Instance admin

## Prerequisite
Ensure the following to enable a domain to host content from external links:

- You are logged in as the organization administrator
- You have access to set the environment variables

## Points to Consider before Whitelisting a Domain

<Will be taken care by legal team>

## Configuring the Domain

To enable a Sunbird instance to host content from external source:

1. Set the "sunbird_extcont_whitelisted_domains" variable in player service to whitelist an external website. You can add that variable into config file and deploy.

Example: To allow an instance to host content from an external source such as "wordpress.com", you need to configure the environmen variable in the below format:

SUNBIRD_EXTCONT_WHITELISTED_DOMAINS: env.sunbird_extcont_whitelisted_domains ||'wordpress.com'

2. On successful configuration of the external domain, it allows content creators of the organisation to upload content from external sources.

For more details on **how to upload external content** to Sunbird content library, refer to the [Upload Content to Sunbird](features-documentation/upload/) section.