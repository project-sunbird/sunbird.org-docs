---
title: Artifact Upload Jobs
page_title: Artifact Upload Jobs
description: Explains Sunbird's deployment process using Artifact upload jobs 
keywords: deployment, Artifacts, Artifact Upload, Jobs 
allowSearch: true
--- 

## Overview
An artifact is a deployable component of your application. Originally, they were called **Build Artifacts**, but as more processes were applied other than build to create them, they are now simply called artifacts. Artifacts can be recreated from the code repository using the same process,if you have preserved the environment in which the process was applied. However, this process is time consuming and the environment may be imperfectly preserved. To be able to recreate artifacts in the exact same way, they are now stored in Artifact Repositories. 
When creating an instance of Sunbird, you nedd to link the appropriate artifact sources to your Sunbird release pipeline. 

## Artifact Upload Job Information

- Most build jobs create artifacts either as zipped files or as docker images. 
- These artifacts are uploaded to the container registry as docker images or Azure blobs as zip files.  
- Create artifact verisions with the value provided in **github_release_tag**
- A drop-down parameter **ArtifactSource**, is associated with every artifact upload job. This parameter has two valid values **ArtifactRepo** (default) and **JenkinsJob**. You can choose either.
- If you choose **ArtifactRepo**, a zip file is uploaded to Azure blob and docker images are uploaded to the container registry
- The Jenkins job also maintains a local copy of the zip files as an artifact.
- All docker images are pushed to the Docker Hub. This is mandatory
- You may choose not to upload the zip file to Azure blobs. To do so, either edit the Jenkins config files to use only the default option **JenkinsJob** or choose **JenkinsJob** and re-run the build. 
> **Note:** 
> Having a copy stored in the Azure blob, gives you the option to rollback a version quicky. You can specify the version that you want to use, rather than rebuilding the service and then deploying it.
> All ArtifactUpload jobs have a log rotation of 5. This means the last 5 artifcats are stored in Jenkins as a local copy. You can modify this number, if required. Doing so makes your local Jenkins your artifact store.
                    