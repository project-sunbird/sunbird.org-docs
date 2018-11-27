---
title: Configuring the Installer
page_title: Configuring the Installer
description: Prerequisites for setting up Sunbird on a server
keywords: configuration, configure, installer, 
allowSearch: true
published: true
---

## Installation Procedure

To install Sunbird, choose the **app server as the installation server**, SSH to that server and execute the instructions as explained in this section.

> In a two server setup, execute the following steps from the server designated to run the application server

## Getting the Installer 
Run this as the user that was setup for the install ~sunbird in the sample setup in Pre requisites

* Clone the installer repository from github.com and checkout the release branch using the following commands:

        git clone https://github.com/project-sunbird/sunbird-devops.git
        cd sunbird-devops
        git checkout tags/release-1.10.2 
        cd deploy

> **Note**: 
- There will be a git warning message during the checkout step - you are in 'detached HEAD' and this message can be safely ignored.
- Do not use 10.0.0.0 network subnet while creating your VMs. Docker uses this subnet for internal communications and thus this may result in a clash with the host IPs.

## Configuring the Installer

You can update the configuration parameters in the `sunbird-devops/deploy/config` file. The config file is a YAML file. Maintain a minimum of one space after each colon (:)

> **Note**: If you are running a two-server installation, you only need to fill in the BASIC section of the config file and can leave the advanced section as is.

The BASIC configuration parameters are explained in the following table: 

| Variable Name | Description   | Mandatory|
|:--------|:-------------------------|----------|
|env|	A short descriptive name of the type of installation. Typical examples are dev, test, qa, staging, performance, preprod, production etc. Please only use characters and underscore in the value of this field.| Yes|
|implementation_name|	The name of your Sunbird implementation. As a best practice, use the org name that is in the domain (dns) name that is going to be used for this Sunbird instance. Please only use characters and underscore in the value of this field. |Yes|
|ssh_ansible_user|	The SSH user name that has sudo access to all servers. If you have followed the user creation sample in the pre-requisites, then this would be Sunbird	|Yes|
|sudo_passwd |	This variable is not required if you have created a user with passwordless ssh as mentioned in the prerequisites. This variable would be removed in a future release	| No|
|ansible_private_key_path|	This is the private key file name with the full path. This private key would have been generated during the “Setup a user with password less ssh & sudo access” process. (eg: /home/sunbird/.ssh/id_rsa)|	 Yes|
|application_host	|The private IP of the designated app server. Every cloud VM would have a private IP associated with it and it can be found by running ifconfig on the VM |	 Yes|
|app_address_space	|The application server address space in CIDR notation. This has to be calculated from the application_host private IP. For eg. if the application_host IP is 11.12.1.5, then the app_address_space would be 11.12.1.0/24 (derived by setting the last octet in the IP to 0, followed by /24)|	 Yes|
|dns_name|	The domain name or IP address of your installation. Provide the IP address, if want to access Sunbird over an IP address (http://x.y.z.a). It is best to use a domain name instead of the IP address.	| Yes|
|proto|	The protocol to be used, either http or https. Use http if the value of the dns_name variable is an IP address or if you have a domain but do not want to enable SSL. Note that the latest browsers would mark sites without https as insecure.	| Yes|
|cert_path	|Path to the .cert file in the SSL certificate for nginx. This variable is not mandatory, if the value of the proto variable is set to http |	No|
|key_path|	Path to .key file in the SSL certificate for nginx. This variable is not mandatory, if the value of the proto variable is set to http|	No|
|database_host |	The private IP address of the DB server	| Yes|
|database_password|	All the databases will be secured using this password. Use the same password if you want to connect to the sunbird databases for running any queries directly. Ensure the password is an alphanumeric string that is atleast 8 characters long |	Yes |
|keycloak_admin_password|	The Keycloak admin user password. The default admin username is admin. Use this password to login to keycloak for any administration.	Ensure the password is an alphanumeric string that is atleast 8 characters long | Yes|
|sso_password|	The password for the keycloak SSO user. The default username is user-manager. Sunbird backend uses this password to invoke keycloak APIs for user creation, authentication. Ensure the password is an alphanumeric string that is atleast 8 characters long |Yes|
|trampoline_secret|	The trampoline secret for Keycloak. This secret is required only while setting up single sign on to Sunbird |No|
|badger_admin_password|	The password for the Badgr administrator. The default username is admin. This password would be required if you want to invoke APIs on the badger service and is used in Sunbird backend|	 Yes|
|badger_admin_email	|The email ID of the Badgr administrator|	 Yes|
|ekstep_api_base_url|	The base URL for all EkStep APIs. The URL for staging is: https://qa.ekstep.in/api and production is: https://api.ekstep.in	| Yes|
|ekstep_proxy_base_url|	The proxy URL for EkStep. The URL for staging is: https://qa.ekstep.in and production: https://community.ekstep.in	| Yes|
|ekstep_api_key|	The JWT token generated by the key, secret generated from Ekstep	| Yes|
|sunbird_image_storage_url|	The Azure storage endpoint url that was created as a prerequisite. Eg: https://storageaccountname.blob.core.windows.net/dial/ where dial is the container within the storage account |Yes
|sunbird_azure_storage_account|	The Azure storage account name setup during the storage account creation |	Yes|
|sunbird_azure_storage_key	|The Azure storage account key generated during the storage account creation |Yes|
|sunbird_default_channel|	The name of the custodian (or default) tenant channel. This should have the same value as the sunbird_custodian_tenant_channel variable	|Yes
|sunbird_custodian_tenant_name|	The name of first tenant organisation. This is used to bootstrap the installation and you can add more tenants by following the howto guides. Please only use characters and underscore in the value of this field.	|Yes
|sunbird_custodian_tenant_description|	Description of first tenant organisation. Please only use characters and underscore in the value of this field.	|Yes
|sunbird_custodian_tenant_channel|	The channel value of first tenant organisation. This can be same as the implementation name. Please only use characters and underscore in the value of this field.	|Yes
|sunbird_root_user_firstname|	First name of this Sunbird instance's administrator. Please only use characters in the value of this field.|	Yes
|sunbird_root_user_lastname|	Last name of this Sunbird instance's administrator. Please only use characters in the value of this field.	|No
|sunbird_root_user_username|	Username of this Sunbird instance's administrator. Please only use characters and underscore in the value of this field.	Yes
|sunbird_root_user_password|	Password of this Sunbird instance's administrator	|Yes
|sunbird_root_user_email|	Email of this Sunbird instance's administrator	|Yes
|sunbird_root_user_phone|	Contact number (without country code) of this Sunbird instance's administrator e.g. 9090909090	|Yes

The Advanced configuration parameters are explained in the following table: 

| Variable Name | Description   | Mandatory|
|:--------|:-------------------------|----------|
|cassandra_host|	The IP address of the Cassandra database |	No|
|elasticsearch_host|	A comma-separated (,) list of Elasticsearch database IP addresses	| No|
|grafana_admin_password|	The password for Grafana dashboard	|No|
|keycloak_host|	A comma-separated (,) list of Keycloak IP addresses|	No|
|mail_server_host|	The ID of the mail server host used to send alerts|	No|
|mail_server_password|	The password of mail|	No|
|mail_server_port|	The port used by mail server for alerting	| No|
|mail_server_username|	 Username of the account permitted to send Sunbird email alerts	|No|
|monitor_alerts_slack_channel|	List of SLACK channels which would require Sunbird alert emails| No|
|monitor_alerts_slack_url|	SLACK application webhook URL |	No|
|postgres_master_host|	The IP address of the Postgres master database	|No|
|postgres_slave_host|	The IP address of the Postgres slave database. If you do not need a slave node, specify the IP address of the master	|No|
|proxy_prometheus|	Setting up Prometheus Proxy|	No|
|sunbird_installation_email|	The Sunbird installation email ID	|No
|sunbird_sso_publickey|	For creation of user, http://< dns_name >/auth -> realm settings -> keys -> public keys (click on public keys) and paste the value	|Yes|
|sunbird_telemetry_pdata_id|	The Sunbird telemetry pdata ID, for example {env}.{implimentation_name}.learning.service	|No|
|swarm_manager_host|	A comma-separated (,) list of the IP addresses of swarm managers	|No|
|swarm_node_host|	A comma-separated (,) list of swarm node IP addresses |	No|
|vault_postgres_exporter_password|	The postgres vault exporter password	|No|
|vault_proxy_prometheus_admin_creds|	The prometheus admin password	|No|
