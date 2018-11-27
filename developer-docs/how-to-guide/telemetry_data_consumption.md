---
title: Consume Telemetry Data
page_title: Consume Telemetry Data
description: Consuming Telemetry Data
keywords: Telemetry, analytics, time consumtion, edata, workflow summary, raw data
published: true
allowSearch: true
---

## Scenario

XYZ coorporation is an organization dealing with develpoment and training programs.  As a part of the employee development and training program, the XYZ Corporation must create training material. The Learning and Develop department's admin would like to understand the effectiveness of the courses, so that they can constantly improvise their training material. To meet this objective, the corporation must obtain telemetry data and analyze the data to understand the time spent by a user on a content.

## Overview

Telemetry is an automated remote measurement and data collection process. It is used in all kinds of industries, from tracking spacecraft, tracking wildlife, medical monitoring, law enforcement, and so on. It enables you to answer many questions such as: Who did what, on what, and where, using what, about what?

**Telemetry event specifications.**

Telemetry events are broad, human-readable actions, that can be tracked as a string. Events are used to categorize telemetry data. They are the basic unit for analytics and help identify user navigation or flow. All events follow a common data structure, though the event data structure ("edata") differs for each event. 

All events data is captured via a common event JSON structure. Depending on the event, edata element carries event specific data. All events have unique event codes (IDs).

The complete data structure is as follows:

```
  {
    //About the event
    "eid": , // Required.
    "ets": , // Required. Epoch timestamp of event (time in milli-seconds. For ex: 1442816723)
    "ver": , // Required. Version of the event data structure, currently "3.0"
    "mid": , // Required. Unique message ID. Used for deduplication, replay and update indexes
    //Who did the event
    "actor": { // Required. Actor of the event.
      "id": , // Required. Can be blank. The id of the actor. For eg: u`id in case of an user
      "type":  // Required. Can be blank. User, System etc.
    },

    //Context of the event
    "context": { // Required. Context in which the event has occured.
      "channel": , // Required. The channel which has produced the event
      "pdata": { // Optional. Producer of the event
        "id": , // Required. unique id assigned to that component
        "pid": , // Optional. In case the component is distributed, then which instance of that component
        "ver":  // Optional. version number of the build
        },
      "env": , // Required. A unique environment where the event has occurred.
      "sid": , // Optional. session id of the requestor stamped by portal
      "did": , // Optional. uuid of the device, created during app installation
      "cdata": [{ // Optional. correlation data
        "type":"", // Required. Used to indicate action that is being correlated
        "id": "" // Required. The correlation ID value
        }],
        "rollup": { // Optional. Context rollups
          "l1": "",
          "l2": "",
          "l3": "",
          "l4": ""
        }

    {
      //About the event
      "eid": , // Required.
      "ets": , // Required. Epoch timestamp of event (time in milli-seconds. For ex: 1442816723)
      "ver": , // Required. Version of the event data structure, currently "3.0"
      "mid": , // Required. Unique message ID. Used for deduplication, replay and update indexes
      //Who did the event
      "actor": { // Required. Actor of the event.
        "id": , // Required. Can be blank. The id of the actor. For eg: u`id in case of an user
        "type":  // Required. Can be blank. User, System etc.
      },

      //Context of the event
      "context": { // Required. Context in which the event has occured.
        "channel": , // Required. The channel which has produced the event
        "pdata": { // Optional. Producer of the event
          "id": , // Required. unique id assigned to that component
          "pid": , // Optional. In case the component is distributed, then which instance of that component
          "ver":  // Optional. version number of the build
          },
        "env": , // Required. A unique environment where the event has occurred.
        "sid": , // Optional. session id of the requestor stamped by portal
        "did": , // Optional. uuid of the device, created during app installation
        "cdata": [{ // Optional. correlation data
          "type":"", // Required. Used to indicate action that is being correlated
          "id": "" // Required. The correlation ID value
          }],
          "rollup": { // Optional. Context rollups
            "l1": "",
            "l2": "",
            "l3": "",
            "l4": ""
          }
        },

        // What is the target of the event
        "object": { // Optional. Object which is the subject of the event.
          "id": , // Required. The id of the object. For eg: content id in case of content
          "type": , // Required. Type of the object. For eg: "Content", "Community", "User" etc.
          "ver": , // Optional. version of the object
          "rollup": { // Optional. Rollups to be computed of the object. Only 4 levels are allowed.
            "l1": "",
            "l2": "",
            "l3": "",
            "l4": ""
          }
        },

      // Tags
      "tags": [""] // Optional. Encrypted dimension tags passed by respective channels
    }
```
        // What is the event data
        "edata": {} // Required.

        // Tags
        "tags": [""] // Optional. Encrypted dimension tags passed by respective channels
      }

The level of data collected is a discrete decision of an organization or business. Analysis of this data offers insights into product and user behavior and usage patterns, driving business decisions and research outcomes.

For more information for Telemetry event structure, please refer to the [Telemetry Specification](developer-docs/telemetry/specification/) page.

## Prerequisites

- API Key to access Sunbird APIs. To create an API key refer [How to generate a Sunbird API key](developer-docs/how-to-guide/generate_apikey/)

-  Enable telemetry service:<br>
  1. The telemetry.min.js service file must be imported to app/portal. An object, window: EkTelemetry will be available as a result of importing the telemetry.min.js file. It enables the telemetry service to use.
  2. Once the page is loaded, use the command:window.EkTellemetryinitialise It initiliase the telemetry service.
  3. Now, configure telemetry using the format:
  
```
  { 
    pdata: 
    { 
      "hostURL": window.location.origin, // "hostURL": "https://xyz.in", 
      "telemetry": 
      { 
        "pdata": 
          { 
          "id": window.location.origin.indexOf("xyz.in") >= 0 ? 
          "prod.xyz.portal": "staging.xyz.portal", 
          "ver": "1.10.1", "pid": 
          "sunbird-portal" 
        } 
      } 
    }, 
    endpoint: endpoint, 
    apislug: "/content", 
    host: hostURL, 
    uid: 'anonymous', 
    sid: window.uuidv1(), 
    channel: 
    env: 
  }

{ 
          pdata: 
          { 
            "hostURL": window.location.origin, // "hostURL": "https://xyz.in", 
            "telemetry": 
            { 
              "pdata": 
                { 
                "id": window.location.origin.indexOf("xyz.in") >= 0 ? 
                "prod.xyz.portal": "staging.xyz.portal", 
                "ver": "1.10.1", "pid": 
                "sunbird-portal" 
              } 
            } 
          }, 
          endpoint: endpoint, 
          apislug: "/content", 
          host: hostURL, 
          uid: 'anonymous', 
          sid: window.uuidv1(), 
          channel: 
          env: 
}
```

* Obtain an API Key to access Sunbird APIs. The specific Channel Ids for which data exhaust API access is requested should be specified along with the API key request. To create an API key, please refer to How to generate a Sunbird API key

* Instrumenting Your App for Telemetry and Analytics

* Telemetry service enabled

* Partner/Content App must send Telemetry as per Using Telemetry SDK to record Telemetry

## Workflow

The process of streaming and consuming telemetry data uses three core components:

• Telemetry Policy File: Determines the kind of telemetry data to be generated, at a specified frequency

• Telemetry Encoder: Encapsulates the generated data into the desired format and transfer to the receiver

• Telemetry Receiver: It is the remote management system that stores the telemetry data

### Pulling and extracting data using data exhaust API 

Using Data exhaust API, you can get workflow summary or raw data generated as by product of user activities. Data exhaust also helps in data mining analytics.

**Authentication**

**API Endpoint**

/data/v3/dataset/request/submit

**Bearer**
<br>Security scheme type: API Key
<br>Header parameter name: Authorization

**X-Channel-ID**
<br>Header parameter name: X-Channel-ID
<br>Header paramter value: Channel ID for which data exhaust is requested for

**Content Type**
<br>Header parameter name: Content-Type
<br>Header paramter value: application/json

**Submit Data Request**

This API is used to submit the data request to get the exhaust data
The response of the request initiates with the creation of a data file
This data file can be downloaded and used for analytics etc.

**Header Parameters**

* Specify the authorization key that you have received from the administrator.
Note: To make use of the API, you require authorization. Raise a request to the administrator for the use of the API. You will receive the authorization key. Specify the key received, here.

* Custom the header parameter as per the request.

<b>X-Channel-ID</b>: {{channel id}}

<b>Content-Type</b>: application/json

<b>Authorization</b>: Bearer {{api_key}}

**REQUEST BODY**

The body refers to the format of the request. It contains metadata about the data request to be sent

```
  {
    "id": "xyz.analytics.dataset.request.submit",
    "ver": "1.0",
    "ts": "2015-08-04T17:36:36+05:30",",
    "params": {
      "msgid": "ff305d54-85b4-341b-da2f-eb6b9e5460fa",
      "client_key": "61d81wac-cc60-4f2f-9fe7-daef674af21a"
      },
    "request": {
      "dataset_id": "eks-consumption-raw", //or "eks-consumption-summary"
      "filter": {
        "start_date": "2016-01-01",
        "end_date": "2016-01-31",
        "events": [
          "START", "INTERACT"
        ]
      },
      "output_format": "json" //or "csv"
    }
  }
```
<b>Response Body</b>

    {
      "id": "xyz.analytics.dataset.request.submit",
      "ver": "1.0",
      "ts": "2015-08-04T17:36:36+05:30",",
      "params": {
        "msgid": "ff305d54-85b4-341b-da2f-eb6b9e5460fa",
        "client_key": "61d81wac-cc60-4f2f-9fe7-daef674af21a"
        },
      "request": {
        "dataset_id": "eks-consumption-raw", //or "eks-consumption-summary"
        "filter": {
          "start_date": "2016-01-01",
          "end_date": "2016-01-31",
          "events": [
            "START", "INTERACT"
          ]
        },
        "output_format": "json" //or "csv"
     }
    }

#### Response Body 

This API returns the dataset based on **fromDate** and **toDate**.

Response body sample with indicative values:

 ```   
  {
    "id": "org.xyz.analytics.telemetry",
    "ver": "1.0",
    "ts": "2018-11-15T12:35:37.522+00:00",
    "params": {
      "resmsgid": "e7e8f75d-fcc2-4f4f-96a1-ab48257591b5",
      "status": "successful",
      "client_key": null
    },
    "responseCode": "OK",
    "result": {
      "telemetryURLs": [
      **"https://xyzproductionall.blob.core.windows.net/telemetry-data-store/channel/01235953112556064029750/raw/2018-10-01-1538393108525.json.gz"**
        ],
      "expiresAt": 1542287137444
    }
  }
```
> **Note**:
> <b>fromDate</b> and <b>toDate</b> must be in YYYY-MM-DD format
> <b>toDate</b> must be greater than or equal to <b>fromDate</b> and toDate must be less than today
   
    {
      "id": "org.xyz.analytics.telemetry",
      "ver": "1.0",
      "ts": "2018-11-15T12:35:37.522+00:00",
      "params": {
        "resmsgid": "e7e8f75d-fcc2-4f4f-96a1-ab48257591b5",
        "status": "successful",
        "client_key": null
      },
      "responseCode": "OK",
      "result": {
        "telemetryURLs": [
        **"https://xyzproductionall.blob.core.windows.net/telemetry-data-store/channel/01235953112556064029750/raw/2018-10-01-1538393108525.json.gz"**
          ],
        "expiresAt": 1542287137444
      }
    }

> **Note**:
> fromDate and toDate must be in YYYY-MM-DD format
> toDate must be greater than or equal to fromDate and toDate must be less than today

* Maximum one month’s (31 days) data could be downloaded in one API call.

* The API key is required for accessing the data exhaust. 

**Extracting Data**:

* Using the telemetry URL that you recieve as part of the the response body of data exhaust API, you can download and extract the file ( .gzip format) that contain telemetry log.

* Store the extracted json file to server/cloud storage for subsequent analysis.

### Analyzing the Data

Analyst can now retrive the data stored on the server/cloud storage and analyse the data based on the use case and scenario using some analytics tool as per your choice.

1. Analyst may apply certain filters based on the use case for analysis of the data.
For example, to compute app session or portal session time, you can apply filtes as mentioned below: 

For App content sessions:

"dimensions.pdata.id" = "prod.diksha.app" & "dimensions.mode" = "play" & "dimensions.type" in ("content","player")

For Portal content sessions:

"dimensions.pdata.id" = "prod.diksha.portal" & "dimensions.mode" = "play" & "dimensions.type" = "content"

2. Another example: To calculate the overall time spent on a content, analyst should use <b>time_spent</b> parameter under the <b>eks</b> section in the edata field from the [workflow summary](https://github.com/ekstep/Common-Design/wiki/[Data-Product]-Workflow-Summarizer) data.

```
  {
    "edata": {
    "eks": {
      "start_time": Long, // Epoch Timestamp of start. Retrieved from first event.
      "end_time": Long, // Epoch Timestamp of end. Retrieved from last event.
      "time_spent": Double, // Total time spent in seconds excluding idle time.
      "time_diff": Double, //  Diff between the last event and first event in seconds.
      "interact_events_count": Long, // Count of interact events
      "interact_events_per_min": Double, // Count of interact events per minute
      "telemetry_version": String, //Version of the telemetry 1.0 or 2.0
      "env_summary": [
          {
          "env": String, // High level env within the app (content, domain, resources, community)
          "time_spent": Double, // Time spent per env
          "count": Long // count of times the environment has been visited
            }
          ]
        }
      }
    }
{
      "edata": {
      "eks": {
        "start_time": Long, // Epoch Timestamp of start. Retrieved from first event.
        "end_time": Long, // Epoch Timestamp of end. Retrieved from last event.
        "time_spent": Double, // Total time spent in seconds excluding idle time.
        "time_diff": Double, //  Diff between the last event and first event in seconds.
        "interact_events_count": Long, // Count of interact events
        "interact_events_per_min": Double, // Count of interact events per minute
        "telemetry_version": String, //Version of the telemetry 1.0 or 2.0
        "env_summary": [
            {
            "env": String, // High level env within the app (content, domain, resources, community)
            "time_spent": Double, // Time spent per env
            "count": Long // count of times the environment has been visited
              }
            ]
      }
    }
  }
  ```

## Concept Covered

- Telemetry Services

- Telemetry Events

- Data Exhaust API

- Data Storage

- Data Population

