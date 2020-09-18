---
title: Keycloak lms Creation
page_title: Keycloak lms configuration
description: To create a new client in keycloak : lms
keywords: lms client creation
allowSearch: true
--- 

## Overview

After you create or remove folders for jenkins job, create a Keycloak User Federation.
 

## Deployment Steps for Keycloak User Federation

To create a Keycloak lms client follow the following steps:

1.Login to admin console

<img src='developer-docs/server-installation/images/keycloak_login_.png'>

2.Select the Realm

<img src='developer-docs/server-installation/images/keycloak_realm_setting.png'>

3.Go to Clients tab on left side of admin console 

<img src='developer-docs/server-installation/images/keycloak_admin_console.png'>

4.Click create button on left hand side of screen

<img src='developer-docs/server-installation/images/keycloak_admin_console.png'>

5.Fill the given details eg: client id and root url and save

<img src='developer-docs/server-installation/images/keycloak_client_create.png'>

6.Fill the given details As shown in screen

<img src='developer-docs/server-installation/images/keycloak_lms_setting.png'>

7.Go to service Account Roles tab  and add admin role in Realm Role Box as shown 

<img src='developer-docs/server-installation/images/keycloak_role_setting.png'>

8.In client role drop down , select realm-management and add manage-users role as shown

<img src='developer-docs/server-installation/images/keycloak_manage-users_setting.png'>
