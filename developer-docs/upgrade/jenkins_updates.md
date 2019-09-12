---
title: Update Jenkins 
page_title: Update Jenkins
description: Update Jenkins 
published: true
allowSearch: true
keywords: Upgrade, Sunbird 2.3.0, jenkins updates
---
## Overview

Jenkins is the CI tool used for build and deploy. As part of every release, we upgrade Jenkins and its plugins. This improves the stability and security of Jenkins.

### Points to remember

* Always create a new job using the pre-configured job as a template to make changes in Jenkins jobs  
* Whenever a new configuration change is released by Sunbird for a particular release, it is mandatory to update Jenkins jobs with the new updated configuration provided in the release  
* By not updating the jobs configuration, the job may fail if there are some under the hood changes to Jenkinsfile, shared libraries or Jenkins parameters  
* As part of the upgrade, the existing jobs which Sunbird provides are overwritten with new content  
* Before upgrading, always take a backup of your existing configration using thin backup in Jenkins  

Follow the below steps to upgrade:

1.Run the following commmands to set up the repository:

        git clone https://github.com/project-sunbird/sunbird-devops.git
        cd sunbird-devops && git checkout tags/release-2.3.0 -b release-2.3.0
        cd deploy/jenkins

2.If there are changes in environment and you require additional folders for other environments, then update the **envOrder.txt** file with new environment order and run the script  

3.If there is no change in the folders or environments from your original setup, then you can just run the below scripts:

        sudo bash jenkins-server-setup.sh (to install if any new packages are required for jobs)
        sudo bash jenkins-plugins-setup.sh (to install any new plugins that are required for jobs)
        sudo bash jenkins-jobs-setup.sh (to update the job configurations)
   
4.Switch to jenkins user and run the below command to install NVM    
        ```curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash```
        
5.Remove the variable github_release_tag from global environment variables in Jenkins (This was added in release 1.1.4 and now this must be removed)

6.The script will show the list of differences between your current configuration and the new configuration. Take a deep look at these changes and when you are ready to update, provide the confirmation as YES 

7.The script will overwrite the existing jobs (only those sunbird provides by default) and update the configurations with new changes of that release.

8.Add the below two Jenkins environment variables under Mange Jenkins → Configure System

|Variable | Value |
|----------|-------|
| override_private_branch |	true |
| override_public_branch | true |

9.Go to Manage Jenkins → Configure System → Global Pipeline Libraries → Change Default Version to `release-2.0.0-shared-lib`

10.Go to Manage Jenkins → Configure System → Update `public_repo_branch` to `refs/tags/release-2.3.0` or go to Manage Jenkins → Configure System → Update `private_repo_branch` to the branch name of your private repo branch in case you created a new branch for release-2.3.0 inventory updates  

11.Restart your Jenkins and you are ready to go  

**IMPORTANT**: Open one of the Deploy job and click on configure  

12.Click **Save**  

13.You can take a look at what has changed in existing job and accordingly update your custom job manually so that the same changes are available in your custom jobs

