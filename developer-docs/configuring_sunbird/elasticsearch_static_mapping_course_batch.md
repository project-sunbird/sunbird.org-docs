---
title: Elasticsearch static mapping for course batch  
page_title: Static mapping configuration
description: Static mapping configuration for course batch
published: true
allowsearch: true
keywords: static mapping, course batch
---
## Overview
Configuring static mapping for course batch. Exisitng coursebatch type is having dynamic mapping and now indexed limit reached to max (1000) , so we need to disable dynamic mapping and start static mapping uses, that will prevent dynamic increment of index limit.

## Prerequisites
Access of elastic search instance. 

Once you have elasticsearch access of elastic search instance use below curl command.
## Step 1:

```
curl -X PUT \
  http://{{host}}:9200/searchindex/batch/_mapping \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'postman-token: a1b4f1d7-1c56-c81b-b18e-9b129a189374' \
  -d '{
  "dynamic": false,
  "properties": {
    "all_fields": {
      "type": "text",
      "fields": {
        "raw": {
          "type": "text",
          "analyzer": "keylower"
        }
      },
      "analyzer": "cs_index_analyzer",
      "search_analyzer": "cs_search_analyzer"
    },
    "countDecrementDate": {
      "type": "text",
      "fields": {
        "raw": {
          "type": "text",
          "analyzer": "keylower",
          "fielddata": true
        }
      },
      "copy_to": [
        "all_fields"
      ],
      "analyzer": "cs_index_analyzer",
      "search_analyzer": "cs_search_analyzer",
      "fielddata": true
    },
    "countDecrementStatus": {
      "type": "boolean",
      "fields": {
        "raw": {
          "type": "boolean"
        }
      }
    },
    "countIncrementDate": {
      "type": "text",
      "fields": {
        "raw": {
          "type": "text",
          "analyzer": "keylower",
          "fielddata": true
        }
      },
      "copy_to": [
        "all_fields"
      ],
      "analyzer": "cs_index_analyzer",
      "search_analyzer": "cs_search_analyzer",
      "fielddata": true
    },
    "countIncrementStatus": {
      "type": "boolean",
      "fields": {
        "raw": {
          "type": "boolean"
        }
      }
    },
    "courseCreator": {
      "type": "text",
      "fields": {
        "raw": {
          "type": "text",
          "analyzer": "keylower",
          "fielddata": true
        }
      },
      "copy_to": [
        "all_fields"
      ],
      "analyzer": "cs_index_analyzer",
      "search_analyzer": "cs_search_analyzer",
      "fielddata": true
    },
    "courseId": {
      "type": "text",
      "fields": {
        "raw": {
          "type": "text",
          "analyzer": "keylower",
          "fielddata": true
        }
      },
      "copy_to": [
        "all_fields"
      ],
      "analyzer": "cs_index_analyzer",
      "search_analyzer": "cs_search_analyzer",
      "fielddata": true
    },
    "batchId": {
      "type": "text",
      "fields": {
        "raw": {
          "type": "text",
          "analyzer": "keylower",
          "fielddata": true
        }
      },
      "copy_to": [
        "all_fields"
      ],
      "analyzer": "cs_index_analyzer",
      "search_analyzer": "cs_search_analyzer",
      "fielddata": true
    },
    "createdBy": {
      "type": "text",
      "fields": {
        "raw": {
          "type": "text",
          "analyzer": "keylower",
          "fielddata": true
        }
      },
      "copy_to": [
        "all_fields"
      ],
      "analyzer": "cs_index_analyzer",
      "search_analyzer": "cs_search_analyzer",
      "fielddata": true
    },
    "createdDate": {
      "type": "text",
      "fields": {
        "raw": {
          "type": "text",
          "analyzer": "keylower",
          "fielddata": true
        }
      },
      "copy_to": [
        "all_fields"
      ],
      "analyzer": "cs_index_analyzer",
      "search_analyzer": "cs_search_analyzer",
      "fielddata": true
    },
    "createdFor": {
      "type": "text",
      "fields": {
        "raw": {
          "type": "text",
          "analyzer": "keylower",
          "fielddata": true
        }
      },
      "copy_to": [
        "all_fields"
      ],
      "analyzer": "cs_index_analyzer",
      "search_analyzer": "cs_search_analyzer",
      "fielddata": true
    },
    "description": {
      "type": "text",
      "fields": {
        "raw": {
          "type": "text",
          "analyzer": "keylower",
          "fielddata": true
        }
      },
      "copy_to": [
        "all_fields"
      ],
      "analyzer": "cs_index_analyzer",
      "search_analyzer": "cs_search_analyzer",
      "fielddata": true
    },
    "endDate": {
      "type": "date",
      "fields": {
        "raw": {
          "type": "date"
        }
      }
    },
    "enrollmentType": {
      "type": "text",
      "fields": {
        "raw": {
          "type": "text",
          "analyzer": "keylower",
          "fielddata": true
        }
      },
      "copy_to": [
        "all_fields"
      ],
      "analyzer": "cs_index_analyzer",
      "search_analyzer": "cs_search_analyzer",
      "fielddata": true
    },
    "hashTagId": {
      "type": "text",
      "fields": {
        "raw": {
          "type": "text",
          "analyzer": "keylower",
          "fielddata": true
        }
      },
      "copy_to": [
        "all_fields"
      ],
      "analyzer": "cs_index_analyzer",
      "search_analyzer": "cs_search_analyzer",
      "fielddata": true
    },
    "id": {
      "type": "text",
      "fields": {
        "raw": {
          "type": "text",
          "analyzer": "keylower",
          "fielddata": true
        }
      },
      "copy_to": [
        "all_fields"
      ],
      "analyzer": "cs_index_analyzer",
      "search_analyzer": "cs_search_analyzer",
      "fielddata": true
    },
    "identifier": {
      "type": "text",
      "fields": {
        "raw": {
          "type": "text",
          "analyzer": "keylower",
          "fielddata": true
        }
      },
      "copy_to": [
        "all_fields"
      ],
      "analyzer": "cs_index_analyzer",
      "search_analyzer": "cs_search_analyzer",
      "fielddata": true
    },
    "mentors": {
      "type": "text",
      "fields": {
        "raw": {
          "type": "text",
          "analyzer": "keylower",
          "fielddata": true
        }
      },
      "copy_to": [
        "all_fields"
      ],
      "analyzer": "cs_index_analyzer",
      "search_analyzer": "cs_search_analyzer",
      "fielddata": true
    },
    "name": {
      "type": "text",
      "fields": {
        "raw": {
          "type": "text",
          "analyzer": "keylower",
          "fielddata": true
        }
      },
      "copy_to": [
        "all_fields"
      ],
      "analyzer": "cs_index_analyzer",
      "search_analyzer": "cs_search_analyzer",
      "fielddata": true
    },
    "startDate": {
      "type": "date",
      "fields": {
        "raw": {
          "type": "date"
        }
      }
    },
    "status": {
      "type": "long",
      "fields": {
        "raw": {
          "type": "long"
        }
      }
    },
    "updatedDate": {
      "type": "text",
      "fields": {
        "raw": {
          "type": "text",
          "analyzer": "keylower",
          "fielddata": true
        }
      },
      "copy_to": [
        "all_fields"
      ],
      "analyzer": "cs_index_analyzer",
      "search_analyzer": "cs_search_analyzer",
      "fielddata": true
    }
  }
}'
```

## Step 2:
 Get total number of batches by running this CQl command.
```
select count(*) from sunbird.course_batch;
```
## Step 3:
 Once Mapping is created successfully and deployment completed, then run sync job for course batch using below curl.
```
curl -X POST \
  {{BaseUrl}}/api/data/v1/index/sync \
  -H 'accept: application/json' \
  -H 'authorization: Bearer {{api-key}}' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'postman-token: d52140d3-5eea-4fad-08d1-1ede432d7fcf' \
  -H 'ts: 2017-05-25 10:18:56:578+0530' \
  -H 'x-consumer-id: X-Consumer-ID' \
  -H 'x-device-id: X-Device-ID' \
  -H 'x-msgid: 8e27cbf5-e299-43b0-bca7-8347f7e5abcf' \
  -d '{"request":{"objectType":"batch","objectIds":[]}}'
```

## Step 4:
 How to verify data migration : Run this curl command to get all migrated batch details.if both count are same then migration occured successfully.
```
curl -X POST \
  {{baseUrl}}/api/course/v1/batch/list \
  -H 'accept: application/json' \
  -H 'authorization: Bearer {{api-key}}' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'postman-token: 784309bc-db98-692f-a172-85e8176c8ca3' \
  -H 'ts: 2017-05-25 10:18:56:578+0530' \
  -H 'x-authenticated-user-token: {{user-token}}' \
  -H 'x-consumer-id: X-Consumer-ID' \
  -H 'x-device-id: X-Device-ID' \
  -H 'x-msgid: 8e27cbf5-e299-43b0-bca7-8347f7e5abcf' \
  -d '{"request":{"filters":{}
}}'
```

