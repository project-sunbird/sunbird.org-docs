---
title: Data Pipeline
page_title: Data Pipeline
description: data pipeline
keywords: data, data pippeline, data sequence 
allowSearch: true
--- 
                   
## Build

<li style="list-style-type: none;"><ul><li>Switch to <code>Build</code><span> </span>folder and run all jobs. Provide the value for <strong>github_release_tag</strong><span> </span>as per the details mentioned in this page - <a style="text-decoration: none;" href="https://project-sunbird.atlassian.net/wiki/spaces/DevOps/pages/1025376293/Current+Release+Tags+and+Jenkins+Jobs+Reference" rel="nofollow">Current Release Tags and Jenkins Jobs Reference</a></li></ul></li></ul>


## OpsAdministration
    
    1. Bootstrap                    //# Creates Deployer User
    
## Provision

<ul><li>Switch to <code>Provision/&lt;env&gt;/DataPipeline</code> and run all jobs<ol><li>AnalyticsApi</li><li>AnalyticsSecor</li><li>AnalyticsSpark</li><li>Influxdb</li><li>Kibana</li><li>Postgress</li><li>Yarn</li></ol></li></ul>

## Deploy

<ul><li>Switch to <code>Deploy/dev/DataPipeline</code> and run all jobs in following order</span><ol><li> CassandraDbUpdate</span></li><li>KafkaSetup</span></li><li> AnalyticsApi</span></li><li> DataProducts</span></li><li> Secor</span></li><li> KafkaIndexer</span></li><li> SamzaTelemertySchemas</span></li><li> Yarn</span></li></ol>
