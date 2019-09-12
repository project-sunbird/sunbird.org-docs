---
title: Manual Configuration
page_title:  Manual Configuration
description:  Manual Configuration
published: true
allowSearch: true
keywords: Upgrade, Sunbird 2.3.0
---

## Overview

With every new release of sunbird you will be able to experience new features, improved performance and bug squashes.
In this document, we will cover detailed steps on how to upgrade Sunbird 2.0.0 to 2.3.0. Below are the some manual changes which are required.

## Manual configuration

1. Cassandra data migration from old keyspace to new keyspace
2. Remove telemetry datapipeline logstash



1> Cassandra data migration from old keyspace to new keyspace
    
There are some structural change in Course-batch table structure in cassandra for 2.3.0. Run the below commands
on KP Cassandra machine.

**NOTE:** Export the data from existing cassandra keyspace to <path_to_save_file>/<name>.csv. Provide the path to save the file in all commands.
   
~~~
# cqlsh -e "COPY sunbird.user_courses (batchid,userid,courseid,active,addedby,completedon,datetime,delta,enrolleddate,grade,lastreadconten
tid,lastreadcontentstatus,status,progress) TO '<path_to_save_file>/sunbird_courses_user_courses.csv' WITH HEADER = TRUE;"


# cqlsh -e "COPY sunbird.content_consumption (contentid,userid,contentversion,batchid,courseid,completedcount,datetime,grade,lastaccesstim
e,lastcompletedtime,lastupdatedtime,progress,result,score,status,viewcount) TO '<path_to_save_file>/sunbird_courses_content_consumption.csv' WITH 
HEADER = TRUE;"


# cqlsh -e "COPY sunbird.course_batch (courseid,id,createdby,createddate,createdfor,description,enddate,enrollmentenddate,enrollmenttype,mentors,name,startdate,status,updateddate) TO '<path_to_save_file>/sunbird_courses_course_batch.csv' WITH HEADER = TRUE;"
~~~


Import the data from csv to sunbird_courses keyspace

~~~
cqlsh -e "COPY sunbird_courses.course_batch (courseid,batchid,createdby,createddate,createdfor,description,enddate,enrollmentenddate,enr
ollmenttype,mentors,name,startdate,status,updateddate) FROM '<path_to_save_file>/sunbird_courses_course_batch.csv' WITH HEADER = TRUE;"

cqlsh -e "COPY sunbird_courses.user_courses (batchid,userid,courseid,active,addedby,completedon,datetime,delta,enrolleddate,grade,lastre
adcontentid,lastreadcontentstatus,status,progress) FROM '<path_to_save_file>/sunbird_courses_user_courses.csv' WITH HEADER = TRUE;"

cqlsh -e "COPY sunbird_courses.content_consumption (contentid,userid,contentversion,batchid,courseid,completedcount,datetime,grade,lasta
ccesstime,lastcompletedtime,lastupdatedtime,progress,result,score,status,viewcount) FROM '<path_to_file>/sunbird_courses_content_consumption.csv' WITH HEADER = TRUE;"
~~~

Once all the steps are done, you can delete the files which is saved with .csv format.


2> Remove telemetry datapipeline logstash docker service.

From release-2.3.0 we are directly sending telemetry events from telemetry-service to ingest kafka topic. So telemetry datapipeline logstash docker service is not required anymore. Execute the below command on swarm manager to remove telemetry datapipeline logstash docker service.

~~~
sudo docker service rm telemetry-datapipeline-logstash
~~~
