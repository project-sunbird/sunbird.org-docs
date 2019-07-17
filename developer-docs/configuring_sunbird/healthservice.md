---
title: Health Check API Configuration 
page_title: Health Check API Configuration
description: Health Check API Configuration
published: true
allowsearch: true
keywords: Health Check
---
## Overview
A service can have two health check end points.

## 1. {service-url}/health 
This API shall perform complete health check. This includes health check of all dependent components. 

If any component is NOT working as expected then it will set overall health status (flag) as false and which would prevent other service APIs to return service unavailable (503) HTTP error. This behaviour can be enabled or disabled using environment variable "sunbird_health_check_enable" (possible value are true , false).

This API needs to be called periodically so that the service is able to update the overall health status regularly. There is no need to restart the service container if its overall status is not healthy.

## 2. {service-url}/service/health 
This API shall return health status of the service only (excluding any dependent components status). If this API does not return success then the service container should be restarted.

## Prerequisites
Devops script required to run both API end points.

## Example: 

```
  Method: GET
  URL: http://service-url:port/health 
```

```
  Method: GET
  URL : http://service-url:port/service/health 
```
