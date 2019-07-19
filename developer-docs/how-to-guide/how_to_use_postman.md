---
title: Installing and Using POSTMAN
page_title: Installing and Using POSTMAN
description: How to Install and Call an API using POSTMAN 
keywords: using POSTMAN, installing POSTMAN, calling an API using POSTMAN
published: true
allowSearch: true
---
## Scenario

A Sunbird adopter wants to create the framework using the Create Framework API. To do so, the developer needs an API client. This page explains the use of POSTMAN as an API client.  

### Prerequisites

A desktop or laptop computer with the latest Windows or Mac OS version 

## Taskflow
 
### Download the POSTMAN App

Download and install the relevant (depending on your OS type and version) [POSTMAN app](http://www.getpostman.com) 

>Note: It is recommended to make the API calls on staging environment

### Calling an API

1. Start the Postman app, refer [Launching POSTMAN](https://www.getpostman.com/docs/v6/postman/launching_postman/installation_and_updates)

2. Select the appropriate method. The value for the method is operation dependent. The valid values are:
   - GET
   - POST
   - PATCH
   - DELETE

3. Insert the endpoint into the box next to {METHOD}:https://staging.open-sunbird.org/{ }/{ }/{ }
			
4. Click the Params button (to the right of the box where you inserted the endpoint) and provide input to the following mandatory parameters: 
    - Content-Type
    - Authorization
    - X-Channel-Id
    
When you add the parameters, they are dynamically added as a query string to the endpoint URI. 
For example, Customize the authorization header and [channel header](https://staging.open-sunbird.org/framework/v1/create?content=95050&auth=fd4698c940c6d1da602a70ac34f0b147&chID=axxxx) values with your unique generated API key and your registered organization channel ID.

>Note: This example uses the staging environment to make an API call.  
