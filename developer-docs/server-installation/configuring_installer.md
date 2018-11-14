---
title: Configuring the Installer
page_title: Configuring the Installer
description: Prerequisites for setting up Sunbird on a server
keywords: configuration, configure, installer, 
allowSearch: true
published: true
---

## Installation Procedure

To install Sunbird, **choose the app server as the installation server**, SSH to that server and execute the instructions explained in this section.

> In a two server setup, execute the following steps from the server designated to run the application server

## Getting the Installer (Please run this as the user that was setup for the install ~sunbird in our sample setup in pre-requisites

* Clone the installer repository from github.com and checkout the release branch using the following commands:

        git clone https://github.com/project-sunbird/sunbird-devops.git
        cd sunbird-devops
        git checkout tags/release-1.10.1
        cd deploy

> Note: Do not use 10.0.0.0 network subnet for your VMs. Docker uses this subnet for internal communications and thus this may result in a clash with the host IPs.

## Configuring the Installer

You can update the configuration parameters in the `sunbird-devops/deploy/config` file. The config file is a YAML file.

> **Note**: If you are running a two-server installation, you only need to fill in the BASIC section of the config file and can leave the advanced section as is.

The BASIC configuration parameters are explained in the following table: 

| Variable Name | Description   | Mandatory|
|:--------|:-------------------------|----------|
|env|	The environment type being setup. Typical examples are dev, test, qa, staging, performance, preprod, production etc.| Yes|
|implementation_name|	The name of your sunbird implementation. As a best practice, use the org name that is in the domain (dns) name that you are going to use for this sunbird instance |Yes|
|sudo_passwd |	This variable is not required if you have created a user with passwordless ssh as mentioned in the pre-requisites. This variable would be removed in a future release	| No|
|ssh_ansible_user|	The SSH user name that has sudo access to all servers. If you have followed the user creation sample in the pre-requisites, then this would be sunbird	|Yes|
|ansible_private_key_path|	The path of the private SSH key file for the ssh_ansible_user. Ansible uses this file to SSH to the servers. If you have followed the user creation sample in the pre-requisites, it would be /home/yourcurrentuser/key|	 Yes|
|application_host	|The private IP of the designated app server. Every cloud VM would have a private IP associated with it and it can be found by running ifconfig on the VM |	 Yes|
|app_address_space	|The application server address space in CIDR notation. This has to be calculated from the application_host private IP. For eg. if the application_host IP is 11.12.1.5, then the app_address_space would be 11.12.1.0/24 (derived by setting the last octet in the IP to 0, followed by /24)|	 Yes|
|dns_name|	The domain name or IP address of your installation. Provide the IP address, if want to access Sunbird over an IP address (http://x.y.z.a). It is best to use a domain name instead of the IP address.	| Yes|
|proto|	The protocol to be used, either http or https. Use http if the value of the dns_name variable is an IP address or if you have a domain but do not to enable SSL. Please note that the latest browsers would mark sites without https as insecure.	| Yes|
|cert_path	|Path to the .cert file in the SSL certificate for nginx. This variable is not mandatory, if the value of the proto variable is set to http |	No|
|key_path|	Path to .key file in the SSL certificate for nginx. This variable is not mandatory, if the value of the proto variable is set to http|	No|
|database_host |	The private IP address of the DB server	| Yes|
|database_password|	All the databases will be secured using this password. You will need to use the same password if you want to connect to the sunbird databases for running any queries directly. Please use an alphanumeric string that is atleast 8 characters long as a best practice. |	Yes |
|keycloak_admin_password|	The Keycloak admin user password. The default admin username is admin. You will need to use this password to login to keycloak for any administration.	Please use an alphanumeric string that is atleast 8 characters long as a best practice.| Yes|
|sso_password|	The password for the keycloak SSO user. The default username is user-manager. The sunbird backend uses this password to invoke keycloak APIs for user creation, authentication. Please use an alphanumeric string that is atleast 8 characters long as a best practice.	|Yes|
|trampoline_secret|	The trampoline secret for Keycloak. This secret is required only while setting up single sign on to sunbird. |No|
|backup_storage_key	|The storage key for the Elasticsearch backup|	 No|
|badger_admin_password|	The password for the Badgr administrator. The default username is admin. This password would be required if you want to invoke APIs on the badger service and is used by the sunbird backend.|	 Yes|
|badger_admin_email	|The email ID of the Badgr administrator|	 Yes|
|ekstep_api_base_url|	The base URL for all EkStep APIs. The URL for staging is: https://qa.ekstep.in/api and production is: https://api.ekstep.in	| Yes|
|ekstep_proxy_base_url|	The proxy URL for EkStep. The URL for staging is: https://qa.ekstep.in and production: https://community.ekstep.in	| Yes|
|ekstep_api_key|	The JWT token generated by the key,secret produced from Ekstep	| Yes|
|sunbird_image_storage_url|	The Azure image url for the badger service	|Yes
|sunbird_azure_storage_account|	The Azure storage account for the badger service|	Yes|
|sunbird_azure_storage_key	|The Azure storage key for the badger service	|Yes|
|sunbird_custodian_tenant_name|	The name of first tenant organisation	|Yes
|sunbird_custodian_tenant_description|	Description of first tenant organisation	|Yes
|sunbird_custodian_tenant_channel|	The channel value of first tenant organisation	|Yes
|sunbird_root_user_firstname|	The first name of first sunbird admin user|	Yes
|sunbird_root_user_lastname|	The last name of first sunbird admin user	|No
|sunbird_root_user_username|	User name of first sunbird admin user|	Yes
|sunbird_root_user_password|	The password of first sunbird admin user	|Yes
|sunbird_root_user_email|	The email of first sunbird admin user	|Yes
|sunbird_root_user_phone|	Contact number (without country code) of first sunbird admin user e.g. 9090909090	|Yes

The Advanced configuration parameters are explained in the following table: 

| Variable Name | Description   | Mandatory|
|:--------|:-------------------------|----------|
|cassandra_host|	The IP address of the Cassandra database |	No|
|elasticsearch_host|	A comma-separated (,) list of Elasticsearch database IP addresses.	| No|
|grafana_admin_password|	The password for grafana dashboard	|No|
|keycloak_host|	A comma-separated (,) list of Keycloak IP addresses|	No|
|mail_server_host|	The ID of the mail server host used to send alerts|	No|
|mail_server_password|	The password of mail|	No|
|mail_server_port|	The port used by mail server for alerting	| No|
|mail_server_username|	 Username of the account permitted to send Sunbird email alerts	|No|
|monitor_alerts_slack_channel|	List of SLACK channels which would like to receive Sunbird alert emails| No|
|monitor_alerts_slack_url|	SLACK application webhook URL |	No|
|postgres_master_host|	The IP address of the Postgres master database	|No|
|postgres_slave_host|	The IP address of the Postgres slave database. If you do not need a slave node, specify the IP address of the master	|No|
|proxy_prometheus|	Setting up Prometheus Proxy|	No|
|sunbird_installation_email|	The Sunbird installation email ID	|No
|sunbird_sso_publickey|	For creation of User, http://< dns_name >/auth -> realm settings -> keys -> public keys (click on public keys) and paste the value	|Yes|
|sunbird_telemetry_pdata_id|	The Sunbird telemetry pdata ID, for example {env}.{implimentation_name}.learning.service	|No|
|swarm_manager_host|	A comma-separated (,) list of the IP addresses of swarm managers	|No|
|swarm_node_host|	A comma-separated (,) list of swarm node IP addresses |	No|
|vault_postgres_exporter_password|	The postgres vault exporter password	|No|
|vault_proxy_prometheus_admin_creds|	The prometheus admin password	|No|
