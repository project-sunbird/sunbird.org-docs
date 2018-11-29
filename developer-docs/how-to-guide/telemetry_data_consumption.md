---
title: Consume Telemetry Data
page_title: Consume Telemetry Data
description: Consuming Telemetry Data
keywords: Telemetry, analytics, time consumtion, edata, workflow summary, raw data
published: true
allowSearch: true
---

## Scenario

XYZ corporation is an organization dealing with development and training programs.  As a part of the employee development and training program, the XYZ Corporation must create training material. The Development and Training department's admin would like to understand the effectiveness of the courses, so that they can constantly improvise their training material. To meet this objective, the corporation must obtain telemetry data and analyze the data to understand the time spent by a user on a content.

## Overview

Telemetry is an automated remote measurement and data collection process. It is used in all kinds of industries, from tracking spacecraft, tracking wildlife, medical monitoring, law enforcement, and so on. It enables you to answer many questions such as: Who did what, on what, and where, using what, about what?

**Telemetry event specifications.**

Telemetry events are broad, human-readable actions, that can be tracked as a string. Events are used to categorize telemetry data. They are the basic unit for analytics and help identify user navigation or flow. All events follow a common data structure, though the event data structure e-data differs for each event. 

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
    // What is the event data
    "edata": {} // Required.

    // Tags
      "tags": [""] // Optional. Encrypted dimension tags passed by respective channels
    }
```

The level of data collected is a discrete decision of an organization or business. Analysis of this data offers insights into product and user behavior and usage patterns, driving business decisions and research outcomes.

For more information for Telemetry event structure, please refer to the [Telemetry Specification](developer-docs/telemetry/specification/) page.

## Prerequisites

- API Key to access Sunbird APIs. To create an API key refer [How to generate a Sunbird API key](developer-docs/how-to-guide/generate_apikey/)

-  Enable telemetry service:<br>
  1. The telemetry.min.js service file must be imported to app/portal. An object, window: EkTelemetry will be available as a result of importing the telemetry.min.js file. It enables the telemetry service 
  2. Once the page is loaded, use the command: ```window.EkTellemetryinitialise```. It initializes the telemetry service
  3. Configure telemetry using the format:
  
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
```

* Every API key has a consumerId associated with it. The consumerId must be mapped to specific channelId for which the exhaust access must be granted. This is an authorization mechanism to restrict access of exhaust data of specific channels to a consumerId instead of a blanket access to all channels
* Instrumenting Your App for Telemetry and Analytics
* Telemetry service enabled
* Partner/Content App must send Telemetry as per **Using Telemetry SDK** to record telemetry

## Workflow

The process of streaming and consuming telemetry data uses three core components:

• Telemetry Policy File: Determines the kind of telemetry data to be generated, at a specified frequency

• Telemetry Encoder: Encapsulates the generated data into the desired format and transfer to the receiver

• Telemetry Receiver: It is the remote management system that stores the telemetry data

### Pulling and Extracting Data Using Data Exhaust API 

* Using Data exhaust API, you can download raw telemetry data or other summary data generated from raw telemetry
* The data exhaust API allows filters on various fields 
* The data exhaust api requests are run once a day and the data will be available the next day

**API Endpoint**

  POST /data/v3/dataset/request/submit

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

This API is used to submit the exhaust data request to a job manager which runs once a day
The response of the data exhaust request has a request_id to check for the status of the job
This data file will be available for download the next day

**Header Parameters**

Specify the authorization key that you have received from the administrator
> **Note**: To make use of the API, you require authorization. Raise a request to the administrator for the use of the API. You will receive the authorization key. Specify the key received, here.

* Custom the header parameter as per the request

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
        "end_date": "2016-01-30",
        "events": [
          "START", "INTERACT" // or "ME_WORKFLOW_SUMMARY", "ME_SESSION_SUMMARY" in case of summary
        ]
      }
      "output_format": "json" //or "csv"
    }
  }
```

#### Response Body 

Response body sample with indicative values:

 ```   
  {
  "id":"ekstep.analytics.dataset.request.submit",
  "ver":"1.0",
  "ts":"2018-11-15T07:26:00.516+00:00",
  "params":{
    "resmsgid":"44a59259-6db3-44f6-a54c-e5a3a1ecf0f9",
    "status":"successful",
    "client_key":null
  },
  "responseCode":"OK",
  "result":{
    "job_stats":{
      "dt_job_submitted":1543389841536, // Date when the job was submitted in epoch time format
      "dt_job_processing":null,
      "dt_job_completed":null,
      "input_events":null,
      "output_events":null,
      "latency":null,
      "execution_time":null
    },
    "attempts":0,
    "last_updated":1543389841536,
    "status":"COMPLETED", // Status of the job. Possible values "SUBMITTED", "PROCESSING", "COMPLETED", "FAILED"
    "request_id":"9835E106F2FB406D74EAA0F896AFFC5A", // Job request Id
    "output":{ // Signed url which expires after the mentioned date in the parameter se
      "location":"https://xyzproductionall.blob.core.windows.net/ntp-content-production/data-exhaust/9835E106F2FB406D74EAA0F896AFFC5A.zip?sv=2017-04-17&se=2018-11-22T11%3A01%3A26Z&sr=b&sp=r&sig=WaMwPBwUuStGMAFrrVhWGrrGmJjGcrA25VUafMj0lS8%3D",
      "file_size":null,
      "dt_file_created":null,
      "dt_first_event":null,
      "dt_last_event":null,
      "dt_expiration":null
    },
    "request_data":{
      "filter":{ // Request filters
        "partner_id":null,
        "group_user":null,
        "content_id":null,
        "tag":null,
        "tags":null,
        "start_date":"2018-08-17",
        "end_date":"2018-08-17",
        "events":null,
        "app_id":null,
        "channel":"in.ekstep",
        "user_id":null,
        "device_id":null,
        "metrics_type":null,
        "mode":null
      },
      "summaries":null,
      "trend":null,
      "context":null,
      "query":null,
      "filters":null,
      "config":null,
      "limit":null,
      "output_format":"json",
      "dataset_id":"eks-consumption-raw",
      "ip_addr":null,
      "loc":null,
      "dspec":null,
      "channel":null
    }
  }
}
```
> **Note**:
> * <b>start_date</b> and <b>end_date</b> must be in YYYY-MM-DD format
> * <b>dataset_id</b> can be either eks-consumption-raw or eks-consumption-summary
> * The fields on which filters can be applied are partner_id, group_user, content_id, tags, events, app_id, channel, user_id, device_id, metrics_type, mode
> * The signed url uses the Shared Access Signature url feature of the Azure blob storage. For more information, refer to https://docs.microsoft.com/en-us/azure/storage/common/storage-dotnet-shared-access-signature-part-1
   
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

* The API allows you to download exhaust data for a maximum of one month date range.

* The API key is required for accessing the data exhaust. 

### Pulling and Extracting Data Using Channel Exhaust API 

Using the Channel exhaust API, you can download raw telemetry data or other summary data generated from raw telemetry for a specific channel. The channel exhaust api requests are executed immediately and the download url to download data will be available for download.

**API Endpoint**

  GET /data/v3/dataset/get/<datasetId>?type=wfs&from=2018-11-12&to=2018-11-14

**Bearer**
  <br>Security scheme type: API Key
  <br>Header parameter name: Authorization

**X-Channel-ID**
  <br>Header parameter name: X-Channel-ID
  <br>Header paramter value: Channel ID for which data exhaust is requested for

**Content Type**
  <br>Header parameter name: Content-Type
  <br>Header paramter value: application/json

**Channel Exhaust Data Request**

* This API is used to request data exhaust for a specific channel
* The response of the data exhaust request has a signed URL to download the exhaust data
* This data file will be available for download immediately

**Header Parameters**

* Specify the authorization key that you have received from the administrator.
Note: To make use of the API, you require authorization. Raise a request to the administrator for the use of the API. You will receive the authorization key. Specify the key received, here.

* Custom the header parameter as per the request.

<b>X-Channel-ID</b>: {{channel id}}

<b>Content-Type</b>: application/json

<b>Authorization</b>: Bearer {{api_key}}

**Response Body**

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
      **"https://xyzproductionall.blob.core.windows.net/telemetry-data-store/channel/01235953112556064029750/raw/2018-11-15-1538393108525.json.gz"**
        ],
      "expiresAt": 1542285633000
    }
  }
```

> **Note**:
> * <b>datasetId</b> can be either raw or summary
> * <b>type</b> will be the type of the summary to download if the datasetId is summary. Default will be wfs (Workflow Summary)
> * <b>from</b> and <b>to</b> dates must be in YYYY-MM-DD format

* The API allows you to download exhaust data for a maximum of one month date range.

* The API key is required for accessing the Channel exhaust. 

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

