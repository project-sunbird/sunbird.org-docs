---
title: Resetting User Profile Visibility
page_title: Resetting User Profile Visibility
description: Details on how to reset user profile visibility
keywords: user profile, profile visibility, reset user profile
allowSearch: true
published: true
---

## Overview

Profile visibility settings are captured at user level in Sunbird. The users can control the visibility (public / private) of their profile data fields, to other users. This is an optional job, which enables an adopter of Sunbird to reset the profile visibility settings of all users and enforce the global profile visibility settings uniformly across all users.

## Prerequisites

To run the migration script, ensure you have:

1. Access to cassandra database
2. A backup of sunbird keyspace in Cassandra DB.

## Configuration Parameters

The following parameters needs to be passed as arguments for the user profile visibility reset job:

 S.No. | Parameter | Description | Example 
-------|-----------|-------------|---------
1 | sunbird_cassandra_server | Cassandra DB IP Address| 198.168.1.1
2 | sunbird_cassandra_port | Cassandra DB Port Number | 9042 
3 | sunbird_cassandra_username* | Cassandra DB User Name | username 
4 | sunbird_cassandra_password* | Cassandra DB Password | password 

> Note: If authentication is not required, pass `""` for parameters, username, and password

## Resetting User Profile Visibility

To reset user profile visibility of all the users:

1. Extract the archive file (sunbird-utils/cassandra-migration-etl/common/UserProfileVisibilityResetBin.zip) that contains the script to reset the profile visibility settings of all users.

2. Run the following command to migrate the data:
<pre> 
UserProfileVisibilityReset_run.sh --context_param sunbird_cassandra_server="{sunbird_cassandra_server}" --context_param sunbird_cassandra_port="{sunbird_cassandra_port}" --context_param sunbird_cassandra_username="{sunbird_cassandra_username}" --context_param sunbird_cassandra_password="{sunbird_cassandra_password}"
</pre>

3. On successful execution of this job, the following query would return zero when executed in cassandra database.

 - Query to fetch number of users with profile visibility value
     ```select count(profilevisibility) from user;```
     
4. UserSync job needs to be run to sync the changes from cassandra to elastic search.
