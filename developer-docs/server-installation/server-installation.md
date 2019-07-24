---
title: Jenkins Setup
page_title: Jenkins Setup
description: Step-by-step instructions to set up the Jenkins server for the Sunbird installation
keywords: Sunbird installation, Jenkins, Setup set up, steps for Jenkins installation
allowSearch: true
---


## Jenkins Setup

1. SSH to the Jenkins server. Enter the following commands:
    - `git clone` [https://github.com/project-sunbird/sunbird-devops.git](https://github.com/project-sunbird/sunbird-devops.git)** 
    - `cd sunbird-devops && git checkout tags/release-2.0.0 -b release-2.0.0`
    - `cd deploy/jenkins`
    - `sudo bash jenkins-server-setup.sh`
        
2. After the `jenkins-server-setup.sh` script is executed, open Jenkins in browser by typing **domain-name:8080 / public-ip:8080**

3. Enter the initial password. Follow the on-screen instructions. 

4. Choose **Install suggested plugin** 

5. Create an admin user. 

6. Choose the default Jenkins URL. You can either change this to your domain name or public IP. If in doubt, use the name displayed on screen, as it can be changed later if required, in the Jenkins configuration.

7. Switch back to the terminal session on the Jenkins server. To do so, enter the following command:
`sudo bash jenkins-plugins-setup.sh`
- Enter the URL as localhost:8080
- Enter the admin username and password

    
8. Go to Manage Jenkins -> Manage Plugins -> Update Center -> Check status of plugin install. If any plugins have failed to install, install them manually by visiting the plugins section of Jenkins.

9. Switch back to the terminal session on the Jenkins server.
```
** cp envOrder.txt.sample envOrder.txt** 
** vi envOrder.txt** 
```

10. Update the environment list as per your infrastructure in ascending order. For example if you have only dev and production, your ** envOrder.txt**will look like:
```
** dev=0**  *
*  production=1** 
```
 11. Now run the ** jenkins-jobs-setup.sh**script, using the command:
<`** sudo bash jenkins-jobs-setup.sh**`

 12. Follow the onscreen instructions of the script. Enter the choice as **Yes** for all questions. The options are case sensitive, the script will display the accepted options. 
 
 13. After the script completes copying the job config, go to the browser and restart Jenkins using the command:
 `** public-ip:8080/restart OR domain-name:8080/restart**` 
 
 14. Go to ** http://<jenkins_domain>/credentials/store/system/domain/_/newCredentials** 
 
 15. Select **Username with Password** 
 
 16. Enter the username and password of the GitHub account where the private repo is hosted. 
 
 17. Enter a unique long string for the ID field, for example,** private-repo-creds** 
 
 18. Specify the description for the repository, for example, private repo credentails, and click **OK**. 
 
 19. Go to **http://<jenkins_domain>/configure** 
 
 20. Select the  **Environment variables** check box
 
 21. Click **Add** and enter the following Name, Value pairs: 
 |** Name**|** Value**| 
 |--- |--- | 
 |** ANSIBLE_FORCE_COLOR**|true| |** ANSIBLE_HOST_KEY_CHECKING**|false| |** ANSIBLE_STDOUT_CALLBACK**|debug| |** hub_org**|docker hub organization / username eg: In sunbird/player image, sunbird is the hub_org| |** private_repo_branch**|The branch name in the private repository which you would like to use. This branch will have the inventory and secrets| |** private_repo_credentials**|The unique string which you provided for ID field while entering the GitHub repo credentials. eg: ** private-repo-creds**| |** private_repo_url**|The GitHub URL to your private repo. You can visit your private repo and click on the clone button, which will display the https URL to your private repository. Only https URL is currently supported.| |** public_repo_branch**|This is the branch or tag from where Jenkinsfile will be picked up. You can set this value as refs/tags/release-1.14.0 if you want to build from tags or provide the value of development branch like release-1.15 (not recommended since development branches are not stable).| |** override_private_branch**|true| |** override_public_branch**|true| 
 
 22. Scroll to the **Global Pipeline Libraries** section and click **Add**. Provide the values as below: 
 |** Name**|** Value **| 
 |--- |--- | 
 |** Library Name**|deploy-conf| |** Default version**|Tag name of the Jenkins shared library. This should be the same version of the release you are going to build and deploy. For example, if you decide to use tags release-2.0.0 as your base, Jenkins shared library tag will be release-2.0.0-shared-lib. When you upgrade to tag release-2.1.0, this value should get changed to release-2.1.0-shared-lib| |** Retrieval method**|Modern SCM| |** Source Code Management**|Git| |** Project Repository**|https://github.com/project-sunbird/sunbird-devops.git| 
 23. Click **Save** and go to **Manage Jenkins -> Configure global security** 
 24. Choose the **Markup Formatter** as **Safe HTML**
 25. Go to **Manage Jenkins -> Manager Nodes -> Click master -> Click Configure -> Provide labels**. Provide the label as “** build-slave** ” 
 26. Set the number of executors to a number. For example, if your system configuration is 16 GB RAM and 4 core CPU set the number as 15. Adjust this number based on your system configuration 
 27. Restart Jenkins using the command `** sudo service jenkins restart**` 
 28. Switch back to the terminal session on the Jenkins server.
<div class="table-wrap"><table class="wrapped confluenceTable"><colgroup><col></colgroup><tbody><tr><td class="confluenceTd">** sudo su jenkins**  ** mkdir -p /var/lib/jenkins/secrets && cd /var/lib/jenkins/secrets**  ** touch deployer_ssh_key ops_ssh_key vault-pass**  ** chmod 400 deployer_ssh_key ops_ssh_key vault-pass** </td></tr></tbody></table></div>

 29. The key which you used to login to the Jenkins server will be called as ** ops_ssh_key**from now on wards. Example:
<div class="table-wrap"><table class="wrapped confluenceTable"><colgroup><col></colgroup><tbody><tr><td class="confluenceTd">** ssh -i somekey.pem ubuntu@jenkins-server-ip**  Here *** somekey.pem** * is the key you used to login to the Jenkins server which will be called as ** ops_ssh_key** </td></tr></tbody></table></div>

30. Copy the contents of the key you used to connect to VM into ** ops_ssh_key**file 

31. Create a new ssh key on your local machine or any server. We will use this for a user named ** deployer**(or any name you like) 

32. ** ssh-keygen -f deployer_ssh_key**(passphrase should be empty) 

33. Copy the contents of the ** deployer_ssh_key** into ** /var/lib/jenkins/secrets/deployer_ssh_key**  

34. If your github private repo consists of ansible encrypted files, then enter the decryption password in **/var/lib/jenkins/secrets/vault-pass** . If there are no encrypted files, then enter some random value like ** 12345**into the** vault-pass file. This file cannot be empty. 

35. Restart the Jenkins server

36. > **Note** Open any of the config files from the **Deploy** directory and save it. Without this some of the parameters will not be visible.** 

37. Follow the next set of steps to create inventory, secrets and ansible hosts in the private repo.