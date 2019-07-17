---
page_title: Understanding Jenkins scripts, jobs, jobs parameters and variables
description: Understanding Jenkins scripts, jobs, jobs parameters and variables
keywords: Understanding Jenkins scripts, jobs, jobs parameters and variables
published: true
allowSearch: true
--- 

## Script Details
    
jenkins-server-setup.sh

• This script installs jenkins and other packages like maven, ansible, pip etc.

jenkins-plugins-setup.sh

• This script downloads the m2 repo if not exists and install the plugins using butler. The plugin list is mentioned in the plugins.txt file.

jenkins-jobs-setup.sh

• This script takes the envOrder.txt as the input and creates the jobs directory in /var/lib/jenkins. The jobs directory in sunbird-devops/deploy/jenkins is the base for this script which it uses to create the folder structure.

Jenkins setup variable details

`ops_ssh_key`

This is the private key value using which the VM was created. This is considered as the master key using which we can connect to the VM's

`deployer_ssh_key`

This is a new key which we generate on local machine or any other machine. Ansible will create anew user (user name will be mentioned in the common.yml file) on all the VM's during bootstrap process. Once this user is created, ansible will use this key for all jenkins jobs. The private key content will be copied into this file during Jenkins setup. The public key will be sprayed to all VM's during bootstrap process.

`vault-pass`

This is the password to decrypt to the files encrypted using ansibile-vault. The best practice is to encrypt the secrets.yml using ansible-vault and push it to the private github repo. When ansible runs, it will checkout this file and decrypt using the vault-pass file. Even if the secrets.yml is not encrypted, it is a must to enter some value in this value. If the file is empty, Ansible will throw an error even when there is no decryption.

## Jenkins environment variable detail

`hub_org` 

This can be your docker username, docker organisation name

private_repo_branch

This is the branch name in your private repo where the ansible hosts, common.yml and secrets.yml exists.

private_repo_url

This is the URL of your private repository. Once repository is created, the URL can be obtained from the browser URL or when clicking the &quot;Clone or Download&quot; button on github, it will display a https URL.

private_repo_credentials

This is the ID field value from Jenkins. Once the username and password of private repo are added in Jenkins global credentials, it will display an auto generated ID or the user can set an unique ID.

public_repo_branch

This is a unique variable. All the jobs in Jenkins are by default configured to checkout the Jenkinsfile from this variable as **${public_repo_branch}. **
When a value like release-2.0.0 is provided to this variable, the Jenkins jobs checkout the Jenkinsfile from release-2.0.0 branch from the URL configured in the job. If this value is set to 

refs/tags/release-2.0.0, 

then Jenkins will checkout the Jenkinsfile from the tag named release-2.0.0. This variable can be changed in Jenkins job configurations and a specific branch or tag name can be specified. This is useful when you want to run some jobs from a different branch or tag instead of the value mentioned in this variable.

deploy-conf (Global pipeline libraries section)

This is the name of the library which we have used in Jenkinsfiles. When Jenkinsfile has this library name mentioned, it will checkout couple of common libraries from the URL configured in this section. These libraries are required for the Jenkinsfile to run. To avoid writing same code at multiple places, common code is placed in a separate branch and all Jenkinsfile can use this common code by calling it as a function. If this name is changed, ensure the name in Jenksinfile is also changed to the new library name.

Parameters details

Build jobs

github_release_tag

Specify a tag name here if you want to build from a tag. Example - release-2.0.0. This will look for a tag named release-2.0.0 in the repository URL configured in the Jenkins job and checkout the code from this tag. This should not be confused with 

public_repo_branch. 

The public_repo_branch is used only to checkout the Jenkinsfile which has all the build logic. Even if public_repo_branch is configured to some tag name, you will still need to provide a tag name in this parameter box when running the build. If this is empty, it will checkout code from the tag specified in `public_repo_branch` but it will not tag build artifact with the tag name. Instead it will tag it with commit hash which is undesirable when you want to build from tag.

All Build jobs creates an artifact called metadata.json which will have details such as artifact / docker image name and version, on which Jenkins slave it was built.

ArtifactUpload jobs

`absolute_job_path`

This is the path from where the metadata.json will be copied. The metadata.json will contain important information like name and version of artifact / docker image and on which Jenkins slave it was built. It is not recommended to change this value. All jobs in Jenkins heavily rely on the metadata.json file to obtain the needed information and the path to this metadata.json file is very critical. For all ArtifactUpload jobs, the metadata.json file will be copied from the Build jobs.

`image_tag`

This is available for docker container jobs. This field is can take some value or can remain blank. By default when the ArtifactUpload job runs, it will copy the image name and image tag from the metadata.json file and push it to the container registry specified in **hub_org.** As an example scenario, let us see when we need to provide the value in this filed. Lets say the build job X with build number 1 completed and triggers the ArtifactUpload. For some reason, the ArtifactUpload job fails and it could not push the image built by the job X in build number 1. The build job X runs again after some new commits and triggers the ArtifactUpload this. This time the upload jobs pushes the image to **hub_org**. But the image build in build number 1 is not available in the docker hub as the upload failed. In this scenario, go to the build number 1 of job X and copy the image tag from metadata.json. Paste the image tag value in this parameter of the upload job. This will push that specific version of the image to **hub_org.**

`build_number`

This is same as **image_tag** of docker builds except that this is used for other type of jobs where a zip / tar / jar type artifacts are created. Again this is optional and can remain blank. Apply the same scenario explained above to this field in order to understand usage of this filed. Since these are artifacts and not containers, you need to use the build job number to copy the artifact. Every new run of any job will clear the workspace but the artifacts are archived on the Jenkins master

`artifact_source`

For docker jobs, this is default as ArtifactRepo and cannot be changed. All containers must be pushed to some hub so that it can be pulled from hub during deploy

For other type of jobs, there is an option to choose where to push the artifacts. You can either choose to push it to Azure blob or store is in Jenkins only. Pushing to Azure blob also stores a copy in Jenkins but not vice versa. To push to azure blob, ensure you have setup your ansible hosts, common.yml and secrets,yml files.

## Deploy jobs

`artifact_source`

In deploy jobs, the artifact is downloaded or pulled from the option specified. This is the opposite behaviour as seen in ArtifactUpload jobs.

`artifact_version`

If you leave this value empty, by default it will take the version specified in the metadata.json file and deploy that version. In case you want to deploy some other version, you can provide the version value here. 
This is useful when you want to roll back to a previous version from current version.

## Summary jobs

Every deploy folder has a summary job. This job consists of a summary.txt file which has details of all the versions currently deployed. You can use this file to see which version of the artifact is currently deployed in that environment.

`Artifact Pushes`
1. The default configuration is to upload the artifacts (zip, jar etc files) to azure blob and docker containers to the configured container registry.

2. Docker container push require a hub account mandatorily. But if you decide to not use azure storage blob to store artifacts, then you can change the configuration in Jenkins jobs to disable to push to azure blob.

3. Go to the Jenkins ArtifactUpload jobs and Deploy jobs and change the order from ArtifactRepo JenkinsJob to JenkinsJob ArtifactRepo

## Log rotation
   
By default the log rotation for build jobs is configured as 

1. Which means only the last built artifact is kept in build jobs and others are deleted. You can change this value in the job configuration.

2. The log rotation for all other jobs is by default set to 5. Which means the last 5 successful artifacts are stored.

> Note: When the jenkins-jobs-setup.sh script is triggered, it will overwrite these changes. You can run a simple find and replace using sublime or any other editor to make the configuration changes as per your desire. The find and replace needs to be run on the config.xml files. This can be done even before the jenkins-jobs script runs or later in the /var/lib/jenkins/jobs directory (Take a backup first!)