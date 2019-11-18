---
title: Jenkins Setup
page_title: Jenkins Setup
description: Step-by-step instructions to set up the Jenkins server for the Sunbird installation
keywords: Sunbird installation, Jenkins, Setup set up, steps for Jenkins installation
allowSearch: true
---


## Overview
This page provides you with step-by-step instructions to set up the Jenkins server. This is the first step in the Sunbird installation process.

## Jenkins Setup

1.SSH to the Jenkins server. Enter the following commands:

```
    - git clone [https://github.com/project-sunbird/sunbird-devops.git](https://github.com/project-sunbird/sunbird-devops.git) 
    - cd sunbird-devops && git checkout tags/release-2.4.0 -b release-2.4.0
    - cd deploy/jenkins
    - sudo bash jenkins-server-setup.sh
 ```   
        
2.After running the `jenkins-server-setup.sh` script, open Jenkins in browser by typing **domain-name:8080 / public-ip:8080**

3.Enter the initial password and follow the on-screen instructions

4.Choose **Install suggested plugin** 

5.Create an admin user 

6.Choose the default Jenkins URL. You can either change this to your domain name or public IP. If in doubt, use the name displayed on screen, as it can be changed later if required, in the Jenkins configuration

7.Switch back to the terminal session on the Jenkins server. Enter the following command, which will install required plugins:

    `sudo bash jenkins-plugins-setup.sh`

- Enter the URL as localhost:8080
- Enter the admin username and password
   
8.Go to **Manage Jenkins** -> **Manage Plugins** -> **Update Center** -> **Check status of plugin install**. If any plugins have not been installed, install them manually. To do so, go to the plugins section of Jenkins

9.Switch back to the terminal session on the Jenkins server
    
    cp envOrder.txt.sample envOrder.txt 
    vi envOrder.txt  (Note: you can use :wq after editing the file to save and quit)
    

10.Update the environment list as per your infrastructure in ascending order. For example, if you have only dev and production, your **envOrder.txt**will look like:

    dev=0
    production=1 

11.Run the `jenkins-jobs-setup.sh` script, using the command,`sudo bash jenkins-jobs-setup.sh`

12.Follow the on-screen instructions. Enter **Yes** for all questions, when prompted for a choice. 

> **Note** The options are case sensitive, the script displays the accepted options 
 
13.After the script completes copying the job configurations, go to the browser and restart Jenkins using the command, `public-ip:8080/restart` OR `domain-name:8080/restart` 
 
14.Go to **http://(jenkins_domain)/credentials/store/system/domain/_/newCredentials** 
 
15.Select **Username with Password** 
 
16.Enter the username and password of the GitHub account where the private repository is hosted
 
17.Enter a unique long string for the ID field, for example,**private-repo-creds** 
 
18.Specify the description for the repository, for example,**private repo credentails**, and click **OK**
 
19.Go to **http://(jenkins_domain)/configure** 
    
20.Select the **Environment Variables** check box
 
21.Click **Add** and enter the following Name, Value pairs: 

|**Name**|**Value**| 
|---|---| 
|**ANSIBLE_FORCE_COLOR**|true| 
|**ANSIBLE_HOST_KEY_CHECKING**|false| 
|**ANSIBLE_STDOUT_CALLBACK**|debug| 
|**hub_org**|docker hub organization / username. Example: In sunbird/player image, sunbird is the hub_org| 
|**private_repo_branch**|The branch name in the private repository which you would like to use. This branch has the inventory and secrets| 
|**private_repo_credentials**|The unique string which you provided for ID field while entering the GitHub repo credentials. Example: **private-repo-creds**| 
|**private_repo_url**|The GitHub URL to your private repo. To get the URL of your private repository, go to your private repository and click the **Clone** button. The https URL of your private repository is displayed. Currently, Sunbird supports only https URLs| 
|**public_repo_branch**|This is the branch or tag from where the Jenkins file is picked up. You can set this value as **refs/tags/release-2.4.0** if you want to build from tags or provide the value of the development branch, for example, release-2.4.0. This is not recommended since development branches are not stable|
|**override_private_branch**|true|
|**override_public_branch**|true| 
 
22.Scroll to the **Global Pipeline Libraries** section and click **Add**. Provide the values as below:

|**Name**|**Value**| 
|-------|--------| 
|**Library Name**|deploy-conf| 
|**Default version**|Tag name of the Jenkins shared library. This should be the same version of the release you are going to build and deploy. For example, if you decide to use tag release-2.4.0 as your base, the Jenkins shared library tag is release-2.4.0-shared-lib. When you upgrade to tag will differ.
|**Retrieval method**|Modern SCM| 
|**Source Code Management**|Git| 
|**Project Repository**|https://github.com/project-sunbird/sunbird-devops.git| 

23.Click **Save** and go to **Manage Jenkins** -> **Configure global security** 

24.Choose the **Markup Formatter** as **Safe HTML**

25.Go to **Manage Jenkins** -> **Manager Nodes** -> Click **master** -> Click **Configure** -> Provide **labels**. Provide the label as `build-slave` 

26.Set the number of executors. For example, if your system configuration is: RAM - 16 GB and CPU - 4 core, set the number as 15. Adjust this number based on your system configuration 

27.Restart Jenkins using the command `sudo service jenkins restart` 

28.Switch back to the terminal session on the Jenkins server using the following commands:


    sudo su jenkins  
    mkdir -p /var/lib/jenkins/secrets && cd /var/lib/jenkins/secrets  
    touch deployer_ssh_key ops_ssh_key vault-pass**  ** chmod 400 deployer_ssh_key ops_ssh_key vault-pass 


29.The key used to login to the Jenkins server will henceforth be named `ops_ssh_key`. Example:

    ssh -i somekey.pem ubuntu@jenkins-server-ip
    Here `somekey.pem` is the key you used to login to the Jenkins server. Henceforth it will be named `ops_ssh_key` 


30.Copy the contents of the key that is used to connect to the VM into the `ops_ssh_key` file 

31.Create a new ssh key on local machine or on any server. This key will be used for a different user, for example,**deployer**. The name is as per your liking 

32.Use the command `ssh-keygen -f deployer_ssh_key`. The passphrase for this user should be empty

33.Copy the contents of the `deployer_ssh_key` into `/var/lib/jenkins/secrets/deployer_ssh_key`  

34.If your private GitHub repository has Ansible encrypted files, then enter the decryption password in `/var/lib/jenkins/secrets/vault-pass`. If there are no encrypted files, then enter a random value like **12345** into the `vault-pass` file. This file cannot be empty

35.Restart the Jenkins server

> Note: 
> Open any of the config files from the **Deploy** directory and save it. Without this, some of the parameters will not be visible 
> After completing the Jenkins setup, follow instructions provided in the [Running Builds, Artifact Uploads and Deployment](developer-docs/server-installation/running-build-artifact-uploads-and-deployments) page to create inventory, secrets and Ansible hosts in the private repository        
