---
title: Sync Telemetry Data Captured from Offline Devices
page_title: Sync Telemetry Data Captured from Offline Devices
description: Sync Telemetry Data Captured from Offline Devices
keywords: Telemetry, analytics, time consumtion, offline, data sync,share telemetry file
published: true
allowSearch: true
---
## Scenario

An educational Institution XYZ, with over three thousand students, is spread across three locations. XYZ institute has decided to use Sunbird for its digital learning solution to provide more scalable and effective education to its students. As the institute mainly operates from the rural area, internet connectivity is a challenge at most branches. 

X is a student who resides in an area where internet connection is poor but, he has access to smartphones, tablets and other handheld devices. The student uses the Sunbird mobile app frequently in offline mode to consume content created by his educational institute.

The Admin of the institute wants to access the telemetry data of each students’ device for better decision making. The admin operates from the urban area and has full access to internet connection.  In that case, admin can ask the student X to share the telemetry data with him.

Using the Share Telemetry feature student X can share the telemetry data as per his convenience with the admin via email or via any messaging apps like Whatsapp, messenger and so on. The admin now can sync the telemetry data with a server by using the shared telemetry file. The student, X can even sync the data to a server by himself by clicking **Sync Now** option when he comes online. 

## Overview

Telemetry is a term used for technologies that automatically record and measure software- generated, statistical data from real-world use. Telemetry is used in a myriad of industries from tracking spacecraft, medical monitoring, tracking wildlife, and so on. 

The concept of telemetry events is used to identify: Who did what, on what, and where, using what, about what? 

**Telemetry event specifications:**

Telemetry events are broad, human-readable actions, that can be tracked as a string. Events are used to categorize telemetry data. They are the basic unit for analytics and help identify user navigation or flow. All events follow a common data structure, though the event data structure ("edata") differs for each event.

All events data is captured via a common event JSON structure. Depending on the event, edata element carries event specific data. All events have unique event codes (IDs).

The complete data structure is as follows:
```javascript
{
  //** About the event**
  "eid": , // Required.
  "ets": , // Required. Epoch timestamp of event (time in milli-seconds. For ex: 1442816723)
  "ver": , // Required. Version of the event data structure, currently "3.0"
  "mid": , // Required. Unique message ID. Used for deduplication, replay and update indexes

  //** Who did the event**
  "actor": { // Required. Actor of the event.
    "id": , // Required. Can be blank. Id of the actor. For ex: uid incase of an user
    "type":  // Required. Can be blank. User, System etc.
  },

  //** Context of the event**
  "context": { // Required. Context in which the event has occured.
    "channel": , // Required. Channel which has produced the event
    "pdata": { // Optional. Producer of the event
      "id": , // Required. unique id assigned to that component
      "pid": , // Optional. In case the component is distributed, then which instance of that component
      "ver":  // Optional. version number of the build
    },
    "env": , // Required. Unique environment where the event has occured.
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

  /**/ What is the target of the event**
  "object": { // Optional. Object which is the subject of the event.
    "id": , // Required. Id of the object. For ex: content id incase of content
    "type": , // Required. Type of the object. For ex: "Content", "Community", "User" etc.
    "ver": , // Optional. version of the object
    "rollup": { // Optional. Rollups to be computed of the object. Only 4 levels are allowed.
      "l1": "",
      "l2": "",
      "l3": "",
      "l4": ""
    }
  },

  // **What is the event data**
  "edata": {} // Required.

  // Tags
  "tags": [""] // Optional. Encrypted dimension tags passed by respective channels
}
```

The level of data collected is a discrete decision of an organization or business. Analysis of this data offers insights into product and user behavior and usage patterns, driving business decisions and research outcomes. 

For more information, please refer to the [Telemetry Specification](http://docs.sunbird.org/latest/developer-docs/telemetry/specification/) page.

## Prerequisites

* The offline user must share telemetry file of Sunbird app with admin

* Admin must download the shared file and open the file with Sunbird app installed on his or her device

**Sharing telemetry file:**

To share the telemetry file, the offline user must follow the steps listed:

* Open the Sunbird app installed on the device

* Navigate to **Profile**> **Setting**> **Data Sync**

* Click **Share Telemetry** to share the file which contains telemetry data of the user’s Sunbird app

**Using shared telemetry file:**

To sync the telemetry data, the admin must use the shared telemetry file and follow the steps as listed below: 

* Download the shared telemetry

* Open the shared file with Sunbird app installed on the admin’s mobile

* Click **Sync Now**

> **Note**: If the admin doesn’t click **Sync Now**, the file will be auto-synced after a certain interval of time

## Workflow

The **telemetry sync** API allows applications to sync telemetry data.

 <b>Request URL</b>:   {{host}}/api/data/v1/telemetry
 <b>Request Method</b>: POST

<b>Request Headers</b>:
```javascript
X-Device-Id:{{Device ID of the mobile}}
X-Channel-Id:{{channel id}}
X-App-Id:{{app id}}
Authorization:Bearer {{user_token}} 
```

**Request Body:**
```javascript
{
  "id": "api.telemetry",
  "ver": "2.0",
  "ts": "2017-10-04T10:54:28.916",
  "params": {
    "did": telemtrysync.default_did",
    "key": "13405d54-85b4-341b-da2f-eb6b9e546e",
    "msgid": "uuidv1()",
    "requesterId": "req.kauth.grant.access_token.content.sub"
  },
  "events": [
    {
  "actor": {
    "id": "0cd56545-2564-438c-9604-620e46bfcf5f",
    "type": "User"
  },
  "context": {
    "cdata": [
      
    ],
    "channel": "b00bc992ef25f1a9a8d63291e20efc8d",
    "did": "0351212662af4957ac08138c1776c9798661f359",
    "env": "user",
    "pdata": {
      "id": "staging.sunbird.app",
      "pid": "sunbird.app",
      "ver": "2.0.localstaging-debug"
    },
    "sid": "35c8d4ce-e0f7-4702-91b6-9e940b8fc161"
  },
  "edata": {
    "id": "group-assesment-details",
    "pageid": "group-assesment-details",
    "subtype": "byuser-tab-clicked",
    "type": "TOUCH"
  },
  "eid": "INTERACT",
  "ets": 1535459220545,
  "mid": "6092a4c3-a9c5-4790-af8d-16d3b08d37fd",
  "object": {
    "id": "",
    "type": "",
    "version": ""
  },
  "tags": [
    
  ],
  "ver": "3.0",
  "ts": "2018-08-28T12:27:00.545+0000"
}
  ]
}
```
**Response Body:**

200 Telemetry Success response
``` javascript
{
  "id": "api.telemetry",
  "ts": "2017-10-04T10:54:28.916",
  "ver": "1.0",
  "params": {
    "resmsgid": "eb1e9d98-b1c9-4db6-b044-e58d9c12fcb",
    "msgid": "uuidv1()",
    "status": "sucess",
    "err": "string",
    "errmsg": "string"
  }
}
```

**Response Code:**

**200**: Telemetry Success response

**400**: Invalid request structure

**401**: Authentication failure
