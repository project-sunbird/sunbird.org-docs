---
title: Understanding Jenkins Scripts
description: Understanding Jenkins scripts, jobs, jobs parameters and variables
keywords: Understanding Jenkins scripts, jobs, jobs parameters and variables
published: true
allowSearch: true
--- 

## Overview
To effectively do the Jenkins setup, it is important to understand the various scripts, jobs, job parameters and variables involved. This page provides details of all these. 

## Script Details

The following scripts are used by Sunbird for the Jenkins setup.

| Script Name | Description |
|----------------|----------------|
| jenkins-server-setup.sh |This script installs Jenkins and other packages like Maven, Ansible, Pip, etc.|
| jenkins-plugins-setup.sh |This script downloads the m2 repo, if it does not exist and installs the plugins using Butler. The plugin list can be found in the plugins.txt file.|
| jenkins-jobs-setup.sh |This script takes the **envOrder.txt** file as the input and creates the jobs directory in **/var/lib/jenkins**. The jobs directory in **sunbird-devops/deploy/jenkins** is the base for this script, and uses it to create the folder structure.|

## Jenkins Setup Variables

The following variables are used for Jenkins setup.

|Variable Name| Description|
|-----------------|----------------|
|ops_ssh_key| The private key value used to create the VM. It is considered the master key used to can connect to the VM's.|
|deployer_ssh_key| The new key generated on a local machine or any other machine. Ansible creates a new user on all the VM's during the bootstrap process. The user name is found in the common.yml file. After this user is created, Ansible uses this key for all Jenkins jobs. The private key content is copied into this file during the Jenkins setup. The public key will be sprayed to all VM's during the bootstrap process.|
|vault-pass| The password to decrypt to files encrypted using Ansible-vault. <br>The best practice is to encrypt the **secrets.yml** file using Ansible-vault and push it to the private github repo. When Ansible runs, it checks out this file and decrypts it using the vault-pass file. <br>Even if the **secrets.yml** file is not encrypted, it is a must to enter a value in this file. If the file is empty, Ansible will throw an error even if there are no files to decrypt.|

## Jenkins Environment Variables

The following environment variables are used for Jenkins setup.

|Variable Name| Description|
|---------------|----------------|
|hub_org|This is your docker username, docker organisation name.|
|private_repo_branch| The branch name in your private repo where the Ansible hosts, common.yml and secrets.yml files exist.
|private_repo_url| The URL of your private repository. After the repository is created, the URL can be obtained from the browser URL or on clicking the **Clone or Download** button on GitHub. It display an https URL.|
|private_repo_credentials| The ID field value from Jenkins. After the username and password of the private repo are added in the Jenkins global credentials field, it displays an auto generated ID or the user can set a unique ID.|
|public_repo_branch|This is a unique variable. All the jobs in Jenkins are by default configured to checkout the Jenkinsfile from this variable as **${public_repo_branch}**. When a value like release-2.0.0 is provided to this variable, the Jenkins jobs checkout the Jenkins file from release-2.0.0 branch from the URL configured in the job. If this value is set to **refs/tags/release-2.0.0**, then Jenkins checks out the Jenkins file from the tag **release-2.0.0**. You can change this variable in Jenkins job configurations and specify a specific branch or tag name. This is useful when you want to run some jobs from a different branch or tag instead of the value mentioned in the variable.|
|deploy-conf| The name of the library that is used in the Jenkinsfile. This file is used in the global pipeline libraries section. When the Jenkinsfile has this library name, it checks out a couple of common libraries from the URL configured in this section. The Jenkinsfile requires these libraries to run. To avoid writing the same code at multiple places, **common code** is placed in a separate branch and all the Jenkinsfile can use this common code by calling it as a function. If this name is changed, ensure the name in Jenkinsfile is also changed to the new library name|.
|override_public_branch|This variable is used to enable or disable the parameter private_branch in enkins jobs. If you set the value of this variable to true, it will give you an option to enter the private branch in case you want to use a different branch for certain jobs essentially overriding the global variable private_repo_branch.
|override_private_branch|This variable is used to enable or disable the parameter branch_or_tag. If you set the value of this variable to true, it will give you an option to enter the tags for different repositories. This is useful when different repositories have different tags. Using this variable, you can override the global variable public_repo_branch.

## Job Parameters

### Build Jobs

|Parameter| Description|
|---------------|-----------|
|github_release_tag | Specify a tag name here if you want to build from a tag. Example - release-2.0.0. This will look for a tag named release-2.0.0 in the repository URL configured in the Jenkins job and checkout the code from this tag. This should not be confused with **public_repo_branch**. The **public_repo_branch** is used only to checkout the Jenkinsfile which has all the build logic.|

> **Note:** Even if the **public_repo_branch** is configured to a tag name, you need to provide a tag name in this parameter box when running the build. If this is empty, it will checkout code from the tag specified in **public_repo_branch** but it will not tag build artifact with the tag name. Instead it will tag it with commit hash which is undesirable when you want to build from tag. All build jobs create an artifact **metadata.json** that has details such as artifact/docker image name and version, and the Jenkins slave on which it was built.

### Artifact Upload Jobs

|Parameter| Description|
|---------------|----------------|
|absolute_job_path| The path from where the **metadata.json** file is copied. The **metadata.json** file contains important information like name and version of artifact/docker image and the Jenkins slave on which it was built. It is not recommended to change this value. All jobs in Jenkins heavily rely on the **metadata.json** file to obtain the needed information and the path to this file is critical. For all ArtifactUpload jobs, the **metadata.json** file is copied from the build jobs.|
|Image_tag| This is available for docker container jobs. This field may have a value or may be blank. By default when the ArtifactUpload job runs, it copies the image name and image tag from the **metadata.json** file and pushes it to the container registry specified in **hub_org**. As an example scenario, let us see when we need to provide the value in this field. Let's say the build job X with build number 1 completed and triggers the ArtifactUpload job. For some reason, the ArtifactUpload job fails and it could not push the image built by the build job X in build number 1. The build job X runs again after some new commits and triggers the ArtifactUpload job. This time the upload jobs pushes the image to **hub_org**. But the image build in build number 1 is not available in the docker hub as the upload failed. In this scenario, go to the build number 1 of job X and copy the image tag from metadata.json file. Paste the image tag value in this parameter of the upload job. This will push that specific version of the image to **hub_org**.|
|build_number|This is same as the **image_tag** of docker builds, except that it is used for other type of jobs where zip / tar / jar type artifacts are created. This field is optional and may be blank. Apply the same scenario explained above to this field in order to understand the usage of this field. Since these are artifacts and not containers, you need to use the build job number to copy the artifact. Every new run of any job will clear the workspace but the artifacts are archived on the Jenkins master.|
|artifact_source| For docker jobs, this parameter is default as **ArtifactRepo** and cannot be changed. All containers must be pushed to some hub so that it can be pulled from the hub during deployment.|

For other type of jobs, you can choose where you want to push the artifacts. You can either choose to push it to Azure blob or store it in Jenkins. Pushing to Azure blob also stores a copy in Jenkins but not vice versa. To push to Azure blob, ensure you have set up your Ansible hosts and **common.yml** and **secrets.yml** files. The default is to store in Jenkins job only.

### Deploy Jobs

| Parameter|  Description |
|---------------|----------------|
|artifact_source| In deploy jobs, the artifact is downloaded or pulled from the option specified. This is the opposite of the behaviour in ArtifactUpload jobs.|
|artifact_version|If you leave this value empty, by default it will take the version specified in the **metadata.json** file and deploy that version. In case you want to deploy some other version, you can provide the version value here.This is useful when you want to roll back to a previous version from current version.|
|private_branch|In this parameter you can specify the private branch. This will checkout the inventory and variables from the branch specified here. By default it shows the value which is in the global variable private_repo_branch. This option is used to override the global value.
|branch_or_tag|In this parameter you can specify the branch or tag of a repository. The public code like ansible playbooks will be checked out from this branch or tag. Since each repository can have a different tag or branch, you need to specify this value. Please refer to this page to get the details on latest tags - [Current Release Tags and Jenkins Jobs Reference](/developer-docs/server-installation/current_release_tags_n_jenkins_jobs){:target="_blank"}

### Summary Jobs

Every deploy folder has a summary job. This job consists of a **summary.txt** file that has details of all the versions currently deployed. You can use this file to see which version of the artifact is currently deployed in that environment.

### Artifact Pushes

1.The default configuration uploads the artifacts (zip, jar, etc files) to Azure blob and the docker containers to the configured container registry.
2.Docker container push mandatorily requires a hub account. But if you decide to not use Azure storage blob to store artifacts, then you can change the configuration in Jenkins jobs to disable to push to Azure blob.
3.Go to the Jenkins ArtifactUpload jobs and Deploy jobs and change the order from ArtifactRepo JenkinsJob to JenkinsJob ArtifactRepo.

## Log Rotation
   
By default, the Jenkins configuration for log rotation for build jobs is set to 1 and for all other builds it is set to 5. However, you can change this value under **job configuration** -> **Discard old builds** -> **Advanced** -> **Max # of build artifacts to keep**.

> **Note**: When the **jenkins-jobs-setup.sh** script is triggered, it overwrites these changes. You can run a simple find and replace using any editor to make the configuration changes as per your requirement. The find and replace needs to be run on the **config.xml** files. This can be done even before the **jenkins-jobs** script runs or later in the **/var/lib/jenkins/jobs** directory.
> Ensure you take a backup.
