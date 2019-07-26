---
title: Running Builds, Artifact Uploads and Deployments
page_title: Running Builds, Artifact Uploads and Deployments
description: An overview to running builds, artifact uploads and deployments
keywords: Running builds, builds, artifact Uploads, Deployment
allowSearch: true
--- 

## Overview
After completing the Jenkins setup, you need to build and deploy Sunbird services to bring up the Sunbird instance. Sunbird services are deployed through build jobs. Most of the build jobs create artifacts either as zip files or docker images.
To understand the scripts, jobs, job parameters and the associated environment variables, refer to the **Understanding Jenkins Scripts, Jobs, Job Parameters and Environment Variables** page. 
To understand the artifact upload jobs, refer to the **Understanding Artifact Upload Jobs** page. 
Adhere to the following sequence to deploy the services: 

1.  [Knowledge Platform](knowledge-platform.md)
2.  [DataPipeline](data-pipeline.md)
3.  [Core Services](core-services.md)