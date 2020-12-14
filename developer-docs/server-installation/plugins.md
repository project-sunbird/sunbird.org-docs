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

### Prerequisites Before Deployment

**Create Containers**

Create containers in Azure blob. Use the following commands to create initial placeholder containers:

```
az storage blob upload-batch --destination container_name/collection-editor --source some_folder --account-name storage_account_name --account-key account_key

az storage blob upload-batch --destination container_name/generic-editor --source some_folder --account-name storage_account_name --account-key account_key

az storage blob upload-batch --destination container_name/content-editor --source some_folder --account-name storage_account_name --account-key account_key

az storage blob upload-batch --destination container_name/v3/preview --source some_folder --account-name storage_account_name --account-key account_key
```

> **Note:**
1. The commands only create the required directories in Azure blob. The deployment script always tries to delete the folders before deploying new contents. Hence, if these folders are not available during the first run, the deployment script fails.
2. You can upload any content in the blob for the first run. Azure does not allow you to create emtpy folders. Hence, add a file in a folder named *dummy*. The commands mentioned create the required directories.
3. The **container_name** container must be publicly accessible.


**Upload Base Plugin**

Upload the initial set of plugins (base plugins) to your publicly accessible Azure container. 
> **Note:** The name of the Azure container must be same as the **container_name** mentioned in the section on creating containers.

You can download the initial Plugins from [here](https://sunbirdpublic.blob.core.windows.net/installation/content-plugins.zip)

Unzip the contents and the directory **content-plugins** is available. Run the following command from the directory where the zip was extracted.

```
az storage blob upload-batch --destination container_name/content-plugins --source content-plugins --account-name account_name --account-key account_key
```

## Deploy

Switch to `Deploy/<env>/Plugins` in your jenkins machine and run the jobs in the following sequence:

1.ContentPlugins  
2.ContentPlayer  
3.CollectionEditor  
4.ContentEditor  
5.GenericEditor  


	