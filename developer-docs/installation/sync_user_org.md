---
title: Sync User and Organisation data
page_title: Sync User and Organisation Data
description: Details on how to sync user and organisation data between Cassandra and Elasticsearch
keywords: Sync user, sync organisation, sync specific user data, sync specific organization data
published: true
---

## Overview

In Sunbird, all write operations are done in Cassandra and read operations are done from Elasticsearch. After write operations are completed in Cassandra, the data is written asynchronously into Elasticsearch as well.
In case of a mismatch of data between the Cassandra database and Elasticsearch, there needs to be a data sync. The information provided in this page to sync either:
- All user data
- All organization data
- Specific user data
- Specific organization data

## Prerequisites

To sync user or organisation data, you need:

1. Access to Cassandra database
2. API Key to access the Sync API

## Configuration Parameters

Pass the following parameters as arguments for the sync job:

 S.No. | Parameter | Description | Example 
-------|-----------|-------------|---------
1 | sunbird_cassandra_server | The IP address of the Cassandra DB. This parameter is used to identify the server on which the Cassandra DB runs. The system uses the details provided to connect to the database.| 198.168.1.1
2 | sunbird_cassandra_port | The port number of the Cassandra DB. This parameter is used to identify the port on which the Cassandra DB runs.  The system uses the details provided to connect to the database.| 9042 
3 | sunbird_cassandra_username* | The user name for the Cassandra DB. This parameter is used to authenticate the user accessing the DB. | abc@xyz.com 
4 | sunbird_cassandra_password* | The password for the Cassandra DB. This parameter is used to authenticate the user accessing the DB.| password 
5 | sunbird_sync_api_endpoint  | The [Sync API](http://docs.sunbird.org/latest/apis/datasyncapi/#tag/Data-Sync-API(s)) | {{domain}}/api/data/v1/index/sync 
6 | sunbird_sync_api_key | The API Key to access the Sync API. | As23456789zws34567w234 
7 | sunbird_sync_block_size | The number of user records to be synced per API call. | 20 
8 | sunbird_sync_sleep_time | The time interval in milliseconds between API calls. | 10000
9 | sunbird_sync_id_file | Path of csv file, with no headers, containing user IDs that need to be synced | /home/userIds.csv
10| sunbird_cassandra_table | Name of the table in Cassandra that needs to sync to Elasticsearch | user/organisation
11| sunbird_sync_object_type | Type of the object to be synced to Elasticsearch | user/organisation
12| dry_run  | if enabled, only report generation and not actual migration happens | true

> Note: If you do not need to authenticate access to the API, pass `""` value for the **username** and **password** parameters.

## Syncing User Data

To sync user data from Cassandra to Elasticsearch:

1. Extract the [archive file](https://github.com/project-sunbird/sunbird-utils/tree/master/cassandra-migration-etl/common/SyncBin.zip) that contains the script to sync the user's data.

2. Run the following command to sync **all users** data.

(dry_run: false)

```
Sync_run.sh --context_param sunbird_cassandra_server="{sunbird_cassandra_server}" --context_param sunbird_cassandra_port="{sunbird_cassandra_port}" --context_param sunbird_cassandra_username="{sunbird_cassandra_username}" --context_param sunbird_cassandra_password="{sunbird_cassandra_password}" --context_param sunbird_sync_api_endpoint="{sunbird_sync_api_endpoint}" --context_param sunbird_sync_api_key="{sunbird_sync_api_key}" --context_param sunbird_sync_block_size="{sunbird_sync_block_size}" --context_param sunbird_sync_sleep_time="{sunbird_sync_sleep_time}" --context_param sunbird_cassandra_table="user" --context_param sunbird_sync_object_type="user" --context_param dry_run=false
```

Run the following command to sync **all organisations** data.

```
Sync_run.sh --context_param sunbird_cassandra_server="{sunbird_cassandra_server}" --context_param sunbird_cassandra_port="{sunbird_cassandra_port}" --context_param sunbird_cassandra_username="{sunbird_cassandra_username}" --context_param sunbird_cassandra_password="{sunbird_cassandra_password}" --context_param sunbird_sync_api_endpoint="{sunbird_sync_api_endpoint}" --context_param sunbird_sync_api_key="{sunbird_sync_api_key}" --context_param sunbird_sync_block_size="{sunbird_sync_block_size}" --context_param sunbird_sync_sleep_time="{sunbird_sync_sleep_time}" --context_param sunbird_cassandra_table="organisation" --context_param sunbird_sync_object_type="organisation" --context_param dry_run=false
```

3. Run the following command to sync **specific users** data.

```
Sync_run.sh --context_param sunbird_cassandra_server="{sunbird_cassandra_server}" --context_param sunbird_cassandra_port="{sunbird_cassandra_port}" --context_param sunbird_cassandra_username="{sunbird_cassandra_username}" --context_param sunbird_cassandra_password="{sunbird_cassandra_password}" --context_param sunbird_sync_api_endpoint="{sunbird_sync_api_endpoint}" --context_param sunbird_sync_api_key="{sunbird_sync_api_key}" --context_param sunbird_sync_block_size="{sunbird_sync_block_size}" --context_param sunbird_sync_sleep_time="{sunbird_sync_sleep_time}" --context_param sunbird_cassandra_table="user" --context_param sunbird_sync_object_type="user" --context_param sunbird_sync_id_file="{sunbird_sync_id_file}" --context_param dry_run=false
```

Run the following command to sync **specific organisations** data.

```
Sync_run.sh --context_param sunbird_cassandra_server="{sunbird_cassandra_server}" --context_param sunbird_cassandra_port="{sunbird_cassandra_port}" --context_param sunbird_cassandra_username="{sunbird_cassandra_username}" --context_param sunbird_cassandra_password="{sunbird_cassandra_password}" --context_param sunbird_sync_api_endpoint="{sunbird_sync_api_endpoint}" --context_param sunbird_sync_api_key="{sunbird_sync_api_key}" --context_param sunbird_sync_block_size="{sunbird_sync_block_size}" --context_param sunbird_sync_sleep_time="{sunbird_sync_sleep_time}" --context_param sunbird_cassandra_table="organisation" --context_param sunbird_sync_object_type="organisation" --context_param sunbird_sync_id_file="{sunbird_sync_id_file}" --context_param dry_run=false
```

4. On completion, refer to the success and failure logs that are generated 

5. When running the script for specified ids, give all the ids as below format in the csv file and no headers required.
Example:
3150aa06-333e-4d6d-8d81-3d8e14e7b245
a354f4c4-a5a7-4eee-9b69-7305cc52a480
bf1efbd7-4ad6-4e2f-925d-0a6095aeafb0
54660e04-4d7c-4f12-b307-c5a7174b68d4
3b87a8a1-0831-453c-8230-b5306daca44f
b6de8b58-144e-49b2-a65a-835cf81ee700

6. Another way proposed for running failure Id's in the failure log is by running the script
URL: https://DNS
Bearer: Bearer value
```
#!/bin/bash
# Variables Section
variablescript=$1
URL=""
Bearer=""
​
if [ $# -ne 1 ];
then
    echo "Usage: syncFilename.sh logfile"
    exit 0
fi
requests=$(cat ${variablescript} | grep "Request :" | cut -d " " -f3 | jq -c '.request.objectIds')
​
for ids in ${requests[@]};
do
    echo "Syncing for $ids"
    command=$(echo "curl -X POST   $URL/api/data/v1/index/sync   -H 'Accept: */*'   -H 'Authorization: Bearer $Bearer'   -H 'Content-Type: application/json'   -H 'cache-control: no-cache'   -d '{\"request\":{\"objectType\":\"user\",\"objectIds\":$ids}}'")
    echo $command | bash
    sleep 5
    echo -e "\n############################################################################################################\n"
done
```

Run the script "bash fileName logFile" 
fileName is the script file
logFile is the failure log file name.
