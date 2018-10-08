---
title: Import External Content 
page_title: Import External Content
description: Details on how to configure Sunbird domain to whitelist external domains
keywords: whitelist, upload external link, upload external video, upload other than youtube
published: true
allowSearch: true
---
## Overview

The Sunbird platform allows you, if you have permissions to create content (Content Creator Role), to upload content from external sources to the Sunbird content library. You can upload content from external websites such as YouTube, Dailymotion, etc. This section explains the procedure to enable a Sunbird instance to host content from external sources. 

## Intended Audience
Instance administrator

## Prerequisite
Ensure the following to enable a Sunbird instance to host content from external domains:

- You are logged in as the organization administrator
- You have access to set the environment variables

## Points to Consider before Whitelisting a Domain

There are legal considerations to be taken care of before whitelisting any domain on Sunbird. Such information will be updated soon. 

## Configuring the Domain

To enable a Sunbird instance to host content from external source:

1. Set the **sunbird_extcont_whitelisted_domains** variable in the **Player Service** to whitelist an external website. You can add that variable into the config file.

> Example: To allow an instance to host content from an external source such as **Wordpress**, configure the environment variable in the following format:

    SUNBIRD_EXTCONT_WHITELISTED_DOMAINS: env.sunbird_extcont_whitelisted_domains ||'wordpress.com'

On successful configuration of the external domain, content creators of the organisation to upload content from external sources.

For details on **How to Upload External Content** to Sunbird content library, refer to the [Upload Content to Sunbird](features-documentation/upload/) 
