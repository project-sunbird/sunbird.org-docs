---
title: Running the Installer
page_title: Running the Installer
description: Procedure to install Sunbird on server
keywords: install, server installation, install and validate, installation scripts, scripts, 
allowSearch: true
---

## Running the Installer

This section details the procedures to install Sunbird's core and auxilliary services and to validate the installation. Once the installation is validated, you can sign-up to begin using Sunbird.


### Installing Auxilliary Services

Begin by installing the auxilliary services. To complete this step, run the installation script 

    cd <path/to/sunbird-devops/deploy>
    ./sunbird_install.sh

The installtion script will run through the following steps

|Stage name|Description| 
|:-------|:--------|
|config |Generates configuration file and hosts file |
|dbs|Installs all databases and creates schema  |
|apis|Sets up API manager kong and Onboard API's and consumer's  |
|proxy|Deploys and configures Nginx|
|keycloak| Deploys and configures Keycloak |
|badger|Deploys the badger service|
|core|Deploys all core services|
|systeminit|Initializes the system by creating first organisation and admin user|

> Note: The badger service does not work without an Azure storage account name 


### Configuring the authentication service certificate

* Log into Keycloak as the admin user
  * You can access keycloak via `http://{dns_name}/auth` where `{dns_name}` is the same as the configured value
  * Refer to the config file to get the Keycloak admin credentials
* Once logged in, navigate to: *Administration console -> Realm Settings -> Keys -> Public keys*
* Click on the RSA public key which will present you a pop-up containing the value
* Copy this key and and set it for `sunbird_sso_publickey` parameter in the `config` file.


### Installing Core Services

Continue the installation to deploy the core services with the configured authentication certificate:

    ./sunbird_install.sh -s core
     
> Note:
>   * Running the installer script with `-s <stage name>` runs only that stage of the installation.
> 
>   * To know more about the script `sunbird_install.sh` refer to the section [Sunbird Install Script](developer-docs/installation/server_installation/#sunbird-install-script")


## Validating the installed services

1. Run the script `./sunbird_install.sh -s posttest` to validate all the successfully installed services. On executing the script, a file `logs/postInstallationLogs.log` is created

1. Open `https://{dns-name}/` and login with the configured root admin login ID/password to access the Sunbird portal. 
  * `{dns-name}` is the value which you configured when installing Sunbird
  * The login ID is `sunbird_init_admin_user_username@sunbird_init_custodian_tenant_channel`


## Post-Install sign-up

Once the install is validated, you can create new user accounts by signing-up. Sign-up is a seamless process -- you can sign-up via the portal. For details on signing up on Sunbird, refer to <a href="http://www.sunbird.org/features-documentation/signup/" target="_blank">Sign-up on Sunbird</a>

1. Open `https://{dns-name}/` and sign-up (where `{dns-name}` is the value which you configured when installing Sunbird)

1. Choose your own loginID and password. The format for the loginID is `username@channelName`


## Sunbird Install Script 

The Sunbird installation script `./sunbird_install.sh` is a wrapper shell script that invokes other scripts or Ansible playbooks. It fetches docker images from the Sunbird DockerHub repository. For details on the scripts and Ansible playbooks invoked, refer to [Additional Information](developer-docs/installation/server_installation/additional_info.md)
