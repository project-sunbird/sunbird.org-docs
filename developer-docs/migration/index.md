---
title: Sunbird Elasticsearch migration to multi index 
page_title: Sunbird Elasticsearch migration to multi index 
description: Sunbird Elasticsearch migration to multi index 
published: true
allowSearch: true
---

## Overview

Since multiple types are deprecated for Elasticsearch 6.x, There is no way to create a new index with multiple type other than migration from older version. This creates challenges as below.

* New adopters cannot have sunbird in it's current state.
* Old static mapping update call doesn't work on migrated index with multiple types.


The document concentrates on multi index approach. The multi index approach is divided into three parts

* Create new indexes with the settings and mappings from old indexes
* Migration of data of old indexes with each type into separate indexes of single type.
* Code changes to point to different indexes in different flows

### Steps

For creating new index with original settings and mappings, first we need to get the settings and mappings of the old indices and then we use that setting and mappings to create new index

#### Setting an index

    get index setting

        Request
        GET /{indexName}/_settings
        
        Response
        
        {
        "searchindex" : {
            "settings" : {
            "index" : {
                "number_of_shards" : "5",
                "provided_name" : "searchindex",
                "creation_date" : "1540294977064",
                "analysis" : {
                "filter" : {
                    "mynGram" : {
                    "token_chars" : [
                        "letter",
                        "digit",
                        "whitespace",
                        "punctuation",
                        "symbol"
                    ],
                    "min_gram" : "1",
                    "type" : "ngram",
                    "max_gram" : "20"
                    }
                },
                "analyzer" : {
                    "cs_index_analyzer" : {
                    "filter" : [
                        "lowercase",
                        "mynGram"
                    ],
                    "type" : "custom",
                    "tokenizer" : "standard"
                    },
                    "keylower" : {
                    "filter" : "lowercase",
                    "type" : "custom",
                    "tokenizer" : "keyword"
                    },
                    "cs_search_analyzer" : {
                    "filter" : [
                        "lowercase",
                        "standard"
                    ],
                    "type" : "custom",
                    "tokenizer" : "standard"
                    }
                }
                },
                "number_of_replicas" : "1",
                "uuid" : "HtjuANPTQH6Q3s4T9wTG3Q",
                "version" : {
                "created" : "5010199",
                "upgraded" : "6030099"
                }
            }
            }
        }
        }
        
        example
        
        curl -X GET http://11.2.3.58:9200/searchindex/_settings



With the response we need to prepare the settings for new indexes, copying the analysis and analyzer field and ignoring index specific fields like uuid, provided_name etc.

#### Mapping the index type

    get index type mapping

        Request
        GET /{indexName}/_mapping/{type}
        

        Response
        
        {"searchindex":{"mappings":{"user":{"_all":{"enabled":true},"dynamic_templates":[{"longs":{"match_mapping_type":"long","mapping":{"fields":{"raw":{"type":"long"}},"type":"long"}}},{"booleans":{"match_mapping_type":"boolean","mapping":{"fields":{"raw":{"type":"boolean"}},"type":"boolean"}}},{"doubles":{"match_mapping_type":"double","mapping":{"fields":{"raw":{"type":"double"}},"type":"double"}}},{"dates":{"match_mapping_type":"date","mapping":{"fields":{"raw":{"type":"date"}},"type":"date"}}},{"strings":{"match_mapping_type":"string","mapping":{"analyzer":"cs_index_analyzer","copy_to":"all_fields","fielddata":true,"fields":{"raw":{"type":"text","fielddata":true,"analyzer":"keylower"}},"search_analyzer":"cs_search_analyzer","type":"text"}}}],"properties":{"all_fields":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower"}},"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer"},"channel":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"completeness":{"type":"long","fields":{"raw":{"type":"long"}}},"countryCode":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"createdBy":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"createdDate":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"dob":{"type":"date","fields":{"raw":{"type":"date"}}},"email":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"emailVerified":{"type":"boolean","fields":{"raw":{"type":"boolean"}}},"encEmail":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"encPhone":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"firstName":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"framework":{"type":"object"},"gender":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"id":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"identifier":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"isDeleted":{"type":"boolean","fields":{"raw":{"type":"boolean"}}},"language":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"lastName":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"loginId":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"maskedEmail":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"missingFields":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"organisations":{"properties":{"approvalDate":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"approvaldate":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"hashTagId":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"id":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"isApproved":{"type":"boolean","fields":{"raw":{"type":"boolean"}}},"isDeleted":{"type":"boolean","fields":{"raw":{"type":"boolean"}}},"isRejected":{"type":"boolean","fields":{"raw":{"type":"boolean"}}},"orgJoinDate":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"orgName":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"organisationId":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"orgjoindate":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"roles":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"updatedDate":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"userId":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true}}},"phone":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"phoneVerified":{"type":"boolean","fields":{"raw":{"type":"boolean"}}},"phoneverified":{"type":"boolean","fields":{"raw":{"type":"boolean"}}},"profileVisibility":{"properties":{"address":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"firstName":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"gender":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"location":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true}}},"roles":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"rootOrgId":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"rootOrgName":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"skills":{"properties":{"createdBy":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"createdOn":{"type":"date","fields":{"raw":{"type":"date"}}},"endorsementCount":{"type":"long","fields":{"raw":{"type":"long"}}},"endorsersList":{"properties":{"endorseDate":{"type":"date","fields":{"raw":{"type":"date"}}},"userId":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true}}},"id":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"lastUpdatedBy":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"lastUpdatedOn":{"type":"date","fields":{"raw":{"type":"date"}}},"skillName":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"skillNameToLowercase":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"userId":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true}}},"status":{"type":"long","fields":{"raw":{"type":"long"}}},"updatedBy":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"updatedDate":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"userId":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"userName":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true},"userType":{"type":"text","fields":{"raw":{"type":"text","analyzer":"keylower","fielddata":true}},"copy_to":["all_fields"],"analyzer":"cs_index_analyzer","search_analyzer":"cs_search_analyzer","fielddata":true}}}}}}
        
        
        example
        curl -X GET \
        http://localhost:9200/searchindex/_mapping/user \
        -H 'cache-control: no-cache



### Prepare the mapping as input to create index

* Copy the inner json of the index starting from mapping as root
* change the original type name to _doc as per 6.x convention
* Enabling [_all] is disabled in 6.0. hence we need to remove that configuration ("_all":{"enabled":true})
* for searchindex the mapping type needs to be static, hence dynamic field should be set to false and dynamic_template field should be removed.


Once we have the settings and mappings prepared we can create index with the settings, refer [Solution Approach](https://project-sunbird.atlassian.net/wiki/spaces/SBDES/pages/1024589843/Sunbird+Elasticsearch+migration+to+multi+index)



### Creating indexes through cURL commands

        Elasticsearch mapping update job steps
        cd sunbird-utils/elasticsearch-util/src/main/resources/indices
        curl -X PUT http://{es-ip}:{es-port}/user -H 'Content-Type: application/json' -d @user.json
        curl -X PUT http://{es-ip}:{es-port}/org -H 'Content-Type: application/json' -d @org.json
        curl -X PUT http://{es-ip}:{es-port}/location -H 'Content-Type: application/json' -d @location.json
        curl -X PUT http://{es-ip}:{es-port}/usernotes -H 'Content-Type: application/json' -d @usernotes.json
        curl -X PUT http://{es-ip}:{es-port}/badgeassociations -H 'Content-Type: application/json' -d @badgeassociations.json
        curl -X PUT http://{es-ip}:{es-port}/cbatch -H 'Content-Type: application/json' -d @cbatch.json

        curl -X PUT http://{es-ip}:{es-port}/cbatchstats -H 'Content-Type: application/json' -d @cbatchstats.json
        curl -X PUT http://{es-ip}:{es-port}/userprofilevisibility -H 'Content-Type: application/json' -d @userprofilevisibility.json
        curl -X PUT http://{es-ip}:{es-port}/usercourses -H 'Content-Type: application/json' -d @usercourses.json
        curl -X PUT http://{es-ip}:{es-port}/announcement -H 'Content-Type: application/json' -d @announcement.json
        curl -X PUT http://{es-ip}:{es-port}/announcementtype -H 'Content-Type: application/json' -d @announcementtype.json
        curl -X PUT http://{es-ip}:{es-port}/metrics -H 'Content-Type: application/json' -d @metrics.json



### Migrate old index data 

The old data can be migrated to multiple types data to new indexes with single type

* reindex API in elasticsearch
* sync functionality in sunbird


### Pros and Cons

|Approach            | Pros             | Cons        | 
|--------------------|------------------|-------------|
| sync flow	         |                  | need to modify to include support for all types|	
| reindex API        | can apply settings like size, throttling etc. <br>no involvement of sunbird application |     |


### Reindex API to migrate data

POST /_reindex call can be made with proper arguments

    reindex API

        Request
        
        POST /_reindex
        {
        "source": {
            "index": "{oldIndexName}",
            "type": "{type}"
        },
        "dest": {
            "index": "{newIndexName}",
            "type" : "_doc"
        }
        }
        
        Response
        
        {
            "took": 632,
            "timed_out": false,
            "total": 114,
            "updated": 0,
            "created": 114,
            "deleted": 0,
            "batches": 1,
            "version_conflicts": 0,
            "noops": 0,
            "retries": {
                "bulk": 0,
                "search": 0
            },
            "throttled_millis": 0,
            "requests_per_second": -1,
            "throttled_until_millis": 0,
            "failures": []
        }
        
        
        example
        
        curl -X POST \
        http://localhost:9200/_reindex \
        -H 'Content-Type: application/json' \
        -H 'cache-control: no-cache' \
        -d '{
        "source": {
            "index": "searchindex",
            "type": "org"
        },
        "dest": {
            "index": "org",
            "type" : "_doc"
        }
        }'

### Additional details

The reindex API need to be called for

* user
* organization
* usercourses
* cbatch
* badgeassociations
* usernotes
* userprofilevisibility
* location


#### cURL command for reindex data from old index to new


    reindex curl command

        curl -X POST http://{es-ip}:{es-port}/_reindex -H 'Content-Type: application/json' -d '{"source":{"index":"searchindex","type":"user"},"dest":{"index":"user","type":"_doc"}}'
        curl -X POST http://{es-ip}:{es-port}/_reindex -H 'Content-Type: application/json' -d '{"source":{"index":"searchindex","type":"org"},"dest":{"index":"org","type":"_doc"}}'
        curl -X POST http://{es-ip}:{es-port}/_reindex -H 'Content-Type: application/json' -d '{"source":{"index":"searchindex","type":"location"},"dest":{"index":"location","type":"_doc"}}'
        curl -X POST http://{es-ip}:{es-port}/_reindex -H 'Content-Type: application/json' -d '{"source":{"index":"searchindex","type":"usernotes"},"dest":{"index":"usernotes","type":"_doc"}}'
        curl -X POST http://{es-ip}:{es-port}/_reindex -H 'Content-Type: application/json' -d '{"source":{"index":"searchindex","type":"badgeassociations"},"dest":{"index":"badgeassociations","type":"_doc"}}'
        curl -X POST http://{es-ip}:{es-port}/_reindex -H 'Content-Type: application/json' -d '{"source":{"index":"searchindex","type":"cbatch"},"dest":{"index":"cbatch","type":"_doc"}}'
        curl -X POST http://{es-ip}:{es-port}/_reindex -H 'Content-Type: application/json' -d '{"source":{"index":"searchindex","type":"userprofilevisibility"},"dest":{"index":"userprofilevisibility","type":"_doc"}}'
        curl -X POST http://{es-ip}:{es-port}/_reindex -H 'Content-Type: application/json' -d '{"source":{"index":"searchindex","type":"usercourses"},"dest":{"index":"usercourses","type":"_doc"}}'
        curl -X POST http://{es-ip}:{es-port}/_reindex -H 'Content-Type: application/json' -d '{"source":{"index":"sunbirdplugin","type":"announcement"},"dest":{"index":"announcement","type":"_doc"}}'
        curl -X POST http://{es-ip}:{es-port}/_reindex -H 'Content-Type: application/json' -d '{"source":{"index":"sunbirdplugin","type":"announcementtype"},"dest":{"index":"announcementtype","type":"_doc"}}'
        curl -X POST http://{es-ip}:{es-port}/_reindex -H 'Content-Type: application/json' -d '{"source":{"index":"sunbirdplugin","type":"metrics"},"dest":{"index":"metrics","type":"_doc"}}'


### Open Questions

1.sunbirddataaudit index is used to log some of the request auditing in elasticsearch. Is it still needed and supported with new multi index way. (AuditLogActions.java has details of which API being audited currently)

2.sunbirdplugin index is used based on the API call, the type is passed into the request. need discussion as how to support it in new multi index format.

3.Currently health check url for elasticsearch checks if "searchindex" exists or not, since we are having multiple index for different entity how do we verify health check for elasticsearch? do we just check user index or all indexes or some other way.