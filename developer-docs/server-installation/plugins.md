---
title: Plugins
page_title: Plugins
description: Explains how to build and deploy plugins
keywords: plugins, content plugins, content framework 
allowSearch: true

---

## Overview
This page explains the jobs to be run to build and deploy plugins. In order to do so, log into Jenkins and execute the instructions as per the sequence provided on this page.

## Build

Switch to the `Build/Plugins` folder and run all jobs. Ensure all ArtifactUpload jobs are sucessful after the build. For the value of the **github_release_tag**, refer to [Current Release Tags and Jenkins Jobs Reference](developer-docs/server-installation/current_release_tags_n_jenkins_jobs){:target="_blank"}

**Prerequisites before deployment**

**Container Creation**

Create containers in Azure blob. Use the below command to create initial placeholder containers.

az storage blob upload-batch --destination *container_name/collection-editor* --source *some_folder* --account-name *storage_account_name* --account-key *account_key*

az storage blob upload-batch --destination *container_name/generic-editor* --source *some_folder* --account-name *storage_account_name* --account-key *account_key*

az storage blob upload-batch --destination *container_name/content-editor* --source *some_folder* --account-name *storage_account_name* --account-key *account_key*

az storage blob upload-batch --destination *container_name/v3/preview* --source *some_folder* --account-name *storage_account_name* --account-key *account_key*

**NOTE**
1. The above commands are just to create the directories in azure blob. The deployment script will always try to delte the folders first before deploying new contents, so if we don't have these folders in first run, deployment script will fail.
2. You can upload any content in the blob for first run. Azure does not allow to create emtpy folders, so just add a file in a folder named *dummy*. The above command will create the directories.
3. The *container_name* container must be publicly accessible.


**Base plugin upload**

Upload the intial set of plugins (base plugins) and upload it to your publicly accessible azure container. This must be same as the *container_name* used in the above steps.

Download link - https://sunbirdpublic.blob.core.windows.net/installation/content-plugins.zip

Unzip the contents and you will be able to see a directory names *content-plugins* and run the below command from the directory where the zip was extracted.

az storage blob upload-batch --destination *container_name/content-plugins* --source *content-plugins* --account-name *account_name* --account-key *account_key*

## Deploy

Switch to `Deploy/<env>/DataPipeline` and run the jobs in the following sequence:

1.ContentPlugins  
2.ContentPlayer  
3.CollectionEditor  
4.ContentEditor  
5.GenericEditor  

After the deployment, you will be able to get the URL's for editors zip file. The URL will be similar to this - 

*https://{{azure_account_name}}.blob.core.windows.net/{{plugin_container_name}}/artefacts/editor/generic-editor-iframe-2.4.0.zip*

*https://{{azure_account_name}}.blob.core.windows.net/{{plugin_container_name}}/artefacts/editor/collection-editor-iframe-2.4.0.zip*

*https://{{azure_account_name}}.blob.core.windows.net/{{plugin_container_name}}/artefacts/editor/content-editor-iframe-2.4.0.zip*

You will need to use these 3 URL's when building Player.
