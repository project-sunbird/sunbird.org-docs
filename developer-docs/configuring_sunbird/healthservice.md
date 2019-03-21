---
title: Configuration for health check api 
page_title: Configuration for health api
description: How to configure health check 
published: true
allowsearch: true
keywords: health service,health api
---
## Overview
Every service will have two health check end points. 
#1 {service-url}/health : This api will do complete health check. So it will do health check of all dependent component and if any one component is not working as expected then it will set a global falg as false and after that it won't allow any other api to process further.
All other api will get 503 HTTP ERROR CODE. This behaviour can be turn ON/OFF using environment variable "sunbird_health_check_enable" (possible value are TRUE , FALSE).
This api will be always called based on some time interval, on each call only global variable value will be reset. On failure of this api no need to restart docker container. Value will be reset only on next call for {service-url}/health , so make sure this api call will always happen with some time interval. 

#2 {service-url}/service/health : This api will do health cehck of particular service only.If service is not running then caller should restart docker container.


## Prerequisites
Devops script required to run both api end point.

## Example: 

```
  Method: GET
  URL: http://serverip:port/health 
  Sceond api:
  Method: GET
  URL : http://serverIp:port/service/health 
```

