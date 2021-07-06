---
title: Jenkins Setup
page_title: Jenkins Setup
description: Step-by-step instructions to set up the Jenkins server for the Sunbird installation
keywords: Sunbird installation, Jenkins, Setup set up, steps for Jenkins installation
allowSearch: true
---


## Jenkins Setup

Jenkins is used to build, deploy and setup the infrastructure for Sunbird. Almost everything in Sunbird is automated using Jenkins pipelines which integrates with ansible and other tools.

- SSH to the Jenkins server and enter the following commands -

     ```bash
     git clone https://github.com/project-sunbird/sunbird-devops.git
     cd sunbird-devops && git checkout tags/release-3.9.0_RC18 -b release-3.9.0_RC18
     cd deploy/jenkins
     sudo bash jenkins-server-setup.sh
     ```

- Open Jenkins UI in a browser by visiting **JENKINS_IP:8080**

- Enter the initial password and follow the on-screen instructions. Choose **Install suggested plugin** and create an admin user

- Run the below commands on Jenkins server -

    ```bash
    sudo bash jenkins-plugins-setup.sh
    cp envOrder.txt.sample envOrder.txt
    vi envOrder.txt
    ```

- Update the environment list as per your requirement in ascending order. For example, if you want to have dev, staging and production environments, your **envOrder.txt** will look like -

    ```bash
    dev=0
    staging=1
    production=2
    ```

- Run the below script on Jenkins server and provide input as required (case sensitive) -

    ```bash
    sudo bash jenkins-jobs-setup.sh
    ```

- Restart jenkins

    ```bash
    sudo service jenkins restart
    ```

- Add a credential in Jenkins and choose **_Username with Password_** from the drop down. Enter the username and password of the private github repository. Enter a unique value for the **ID** field like **_private-repo-creds_**

- Go to **Manage Jenkins** -> **Configure System** -> **Environment Variables** and add the following variables

| **Name**                      | **Value**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
|-------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **ANSIBLE_FORCE_COLOR**       | `true`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| **ANSIBLE_HOST_KEY_CHECKING** | `false`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| **ANSIBLE_STDOUT_CALLBACK**   | `debug`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| **hub_org**                   | docker hub organization / username. Example: In `docker pull sunbird/ubuntu:20.04`, the hub_org is `sunbird`                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| **private_repo_branch**       | private repo branch name where ansible inventory is present                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| **private_repo_credentials**  | Go to [github token page](https://github.com/settings/tokens/new) create a new token, check repo box, give a proper note, and generate token<br>Copy the token, goto [jenkins credentials page](http://jenkins_ip:8080/credentials/store/system/domain/_/newCredentials)<br>Give your username and password(token you copied), give a proper ID(something like github-cred) and save it.<br> Goto the **settings page -> environment variables** and paste the unique value which you provided for **ID** field while adding the credentials |
| **private_repo_url**          | The **https** github url of your private repo                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| **public_repo_branch**        | `release-3.9.0`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| **override_private_branch**   | `true`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| **override_public_branch**    | `true`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| **java11_home**               | `/usr/lib/jvm/java-11-openjdk-amd64/`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |

- Scroll down to the **Global Pipeline Libraries** section and click on **Add**. Provide the values as below:

    |**Name**|**Value**|
    |-------|--------|
    |**Library Name**|`deploy-conf`|
    |**Default version**|`shared-lib`
    |**Retrieval method**|Modern SCM|
    |**Source Code Management**|`Git`|
    |**Project Repository**|`https://github.com/project-sunbird/sunbird-devops.git`|

- Click **Save** and go to **Manage Jenkins** -> **Configure global security**

- Choose the **Markup Formatter** as **Safe HTML** and Under **Copy Artifact Compatibility mode**  choose **Migration**

- Go to **Manage Jenkins** -> **Manage Nodes** -> Click **master** -> Click **Configure** -> Provide **labels**. Provide the label as `build-slave ops-slave`

- Update the number of executors (`cpu cores x 2 = number of executors`)

- Run the below commands on Jenkins server -

    ```bash
    sudo su jenkins
    mkdir -p /var/lib/jenkins/secrets
    cd /var/lib/jenkins/secrets
    touch deployer_ssh_key vault-pass k8s.yaml
    chmod 400 deployer_ssh_key vault-pass k8s.yaml
    ```

- Copy the contents of your server's private key into `/var/lib/jenkins/secrets/deployer_ssh_key`  

- Copy the kubernetes config file contents into `/var/lib/jenkins/secrets/k8s.yaml`

- If you have encrypted your `secrets.yml` using `ansible-vault`, enter the password to decrypt into `/var/lib/jenkins/secrets/vault-pass`. If you have not encrypted, then enter a random value like **12345**

- Run `sudo visudo` on jenkins server and add the below line -

 ```bash
    jenkins ALL=(ALL) NOPASSWD:ALL
 ```

- Reboot the Jenkins VM (`sudo reboot`)
