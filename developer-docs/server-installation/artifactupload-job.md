---
title: Artifact Upload Jobs
page_title: Artifact Upload Jobs
description: Server Installation
keywords: installation, server installation 
allowSearch: true
--- 


- Most of the build jobs create an artifact either in zip or as a docker image
- All these artifacts are uploaded to container registry(docker images) or Azure blobs (zip files)
- These are verisioned with the value provided in **github_release_tag**
- There is a dropdown parameter called ArtficatSource for evry artifact upload job. This dropdown includes two choices- **ArtifactRepo (default) and JenkinsJob**
- If the option chosen is ArtifactRepo, it will upload to Azure blob (zip file) and to container registry (docker images)
- A local copy of the zip files is also kept in Jenkins job as an artifact
- All docker images are pushed to docker hib 
- This is mandatory-You can optionally choose not to upload the zip file to Azure blobs. This can be done either by editing the Jenkins config files to use the default option as **JenkinsJob** or re-running the build with option chosen as **JenkinsJob**
- **The advantage of having a copy stored in blob is the option to rollback a version quicky by specifying which version to use rather than going through the process of rebuilding the service and then deploying it.**
- All ArtifactUpload jobs have alog rotation of 5 which means the last 5 artifcats will be stored in Jenkins as a local copy. This can be changed to a bigger number if required. By doind this, your local Jenkins becomes your artifact store
                    