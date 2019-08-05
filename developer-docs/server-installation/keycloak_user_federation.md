---
title: Keycloak User Federation
page_title: Keycloak User Federation
description: Deployment steps for Keycloak user federation
keywords: Keycloak user federation
allowSearch: true
--- 

## Deployment Steps for Keycloak User Federation

To create a Keycloak user federation, ensure to take a backup of the Keycloak database and then complete the following steps:

1.	Log in to the admin console using admin account and click the User Federation tab in the navigation pane as shown here. The User Federation page opens. 

    <img src='developer-docs/server-installation/images/keycloak_user_federation.png'>

2.	Select the cassandra-storage-provider option from the Add provider drop-down list and the Add user storage provider page opens as shown here. 

    <img src='developer-docs/server-installation/images/keycloak_user_storage_provider.png'>

3.	Click the Save button and it generates a Provider ID as shown here.

    <img src='developer-docs/server-installation/images/keycloak_cassandra_storage_provider.png'>

4.	Copy the provider ID and update the private repository inventory under **Core/secrets.yml** for the variable. `core_vault_sunbird_keycloak_user_federation_provider_id`. 

