---
title: Static Mapping for Course Batches in Elasticsearch 
page_title: Static Mapping for Course Batches in Elasticsearch
description: Static Mapping for Course Batches in Elasticsearch
published: true
allowsearch: true
keywords: Elasticsearch, static mapping, course batch
---

## Overview
Existing coursebatch type Elasticsearch index is having dynamic mapping and it recently hit the default max limit (1000). As such, it is required to disable dynamic mapping and use static mapping which would index the necessary fields only.

## Prerequisites
Access to Elasticsearch and Cassandra instances. 

## Step 1:
Update course batch mapping using below curl command.

```
curl -X PUT \
  http://{{es-host}}:9200/searchindex/cbatch/_mapping \
  -H 'content-type: application/json' \
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
Get total number of batches by running below CQL command.
```
select count(*) from sunbird.course_batch;
```

## Step 3:
Perform sync of all course batches using Learner Service Sync API so that course batch data is reindexed as per latest mapping defined in Elasticsearch.

```
curl -X POST \
  {{lms-base-url}}/api/data/v1/index/sync \
  -H 'accept: application/json' \
  -H 'authorization: Bearer {{api-key}}' \
  -H 'content-type: application/json' \
  -d '{"request":{"objectType":"batch","objectIds":[]}}'
```

## Step 4:
Verify that the sync has happened successfully to the new index by using Learner Service List Course Batches API. The counts in Step 2 and Step 4 should match. 
```
curl -X POST \
  {{lms-base-url}}/api/course/v1/batch/list \
  -H 'accept: application/json' \
  -H 'authorization: Bearer {{api-key}}' \
  -H 'content-type: application/json' \
  -H 'x-authenticated-user-token: {{user-token}}' \
  -d '{"request":{"filters":{}
}}'
```
