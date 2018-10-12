---
title: Configure Keycloak to Generate Link for Required User Action
page_title: Configure Keycloak to Generate Link for Required User Action 
description: Configuration required in Keycloak to generate link for required user action for sign up
published: false
allowSearch: false
keywords: SSO, single sign on, single signon, singlesignon, link, user required action, set password link , verify email link, Keycloak
---
## Overview
A new user can be created in Sunbird in following two ways:
- Self signup using Sunbird Portal where user can provide email, phone and password at the time of user creation
- Bulk users creation by Organisation Admin where an initial password is not yet set

The Sunbird platform requires users to either verify email (when user is created by self sign up) or set password (when users are created by bulk upload) for the first time before they are able to log in to Sunbird.

The verify email and set password link is sent to newly created users via email and / or SMS. The generated link also consists of a redirect URI to which the user is redirected after completing the required action.

This document explains the configuration required in Keycloak to generate links for the required action to be performed by a new user.

## Configure Environment Variables

Following environment variables need to be configured in Sunbird LMS service for generating required action links:
- sunbird_sso_url
- sunbird_sso_username
- sunbird_sso_password
- sunbird_sso_realm
- sunbird_sso_client_id
- sunbird_url_shortner_enable
- sunbird_url_shortner_access_token
- sunbird_keycloak_required_action_link_expiration_seconds

> Note: For details on the environment variables, refer to [Sunbird LMS Service Environment Variables](http://docs.sunbird.org/latest/developer-docs/configuring_sunbird/env_variables_lms/).

## Configure Administrator Role 

It is mandatory to configure a user with administrator role permissions to be able to generate the required action link in Keycloak.

<table>
<tr>
<th style="width:35%;">Step</th>
<th style="width:65%;">Screen</th>
 </tr>
  
<tr>
  <td>
1. Enter your <b>Username or email</b> and <b>Password</b>.<br>Click <b>Log in</b>, to log into the Keycloak admin console.
</td>
<td><img src="https://github.com/project-sunbird/project-sunbird.github.io/blob/dev/pages/developer-docs/configuring_sunbird/images/keycloak_login.png"></td>
</tr>
 
<tr>
  <td> 
2. Click the <b>Realm Selector Dropdown</b> from the left corner of your screen and select the appropriate realm.<br>
<b>Note:</b> The <b>Master</b> realm is selected by default.
    </td>
    <td><img src="https://github.com/project-sunbird/project-sunbird.github.io/blob/dev/pages/developer-docs/configuring_sunbird/images/realm_select.png"></td>
    </tr>
    
  <tr>
  <td> 
3. Click <b>Roles</b> tab.
  </td>
  <td><img src="https://github.com/project-sunbird/sunbird.org-docs/blob/master/developer-docs/configuring_sunbird/images/settings/roles_selector.PNG"></td>
  </tr>
  
  <tr>
  <td> 
4. Go to <b>Realms Roles</b> tab, click <b>Add Role</b> if the administrator role is not available in the realm roles table. If the role is available, proceed to step 5. 
</td>
<td>
  <img src="https://github.com/project-sunbird/sunbird.org-docs/blob/master/developer-docs/configuring_sunbird/images/settings/add_admin_role.PNG">
  </td>
  </tr>
 <tr>
  <td>
5. Go to <b>Users</b> tab and search the user.
  </td>
  <td><img src="https://github.com/project-sunbird/sunbird.org-docs/blob/master/developer-docs/configuring_sunbird/images/settings/select_user_%20selector_and%20_search_for_%20admin_user.PNG"></td>
  </tr>
  
 
<tr>
<td> 
6. Click <b>Role Mappings</b> tab.
  </td>
  <td><img src="https://github.com/project-sunbird/sunbird.org-docs/blob/master/developer-docs/configuring_sunbird/images/settings/user_role_mapping.PNG"></td>
  </tr>
  <tr>
<td> 
7. Assign the admin role at realm level.
  </td>
  <td><img src="https://github.com/project-sunbird/sunbird.org-docs/blob/master/developer-docs/configuring_sunbird/images/settings/add_admin_role_to_user.PNG"></td>
  </tr>
  
  <tr>
<td> 
8. Select <b>Client Roles</b> from the drop down and select the client to which the user belongs and assign admin role at the client level.
  </td>
  <td><img src="https://github.com/project-sunbird/sunbird.org-docs/blob/master/developer-docs/configuring_sunbird/images/settings/admin_role_added.PNG"></td>
  </tr>
</table>

## Configure Redirect URI 

The redirect URI configuration is necessary to redirect user to Sunbird tenant specific home page after completing the required action.
<table>
<tr>
<th style="width:35%;">Step</th>
<th style="width:65%;">Screen</th>
 </tr>
  
<tr>
  <td>
1. Select <b>Clients</b> tab in left panel.
</td>
<td><img src="https://github.com/project-sunbird/sunbird.org-docs/blob/master/developer-docs/configuring_sunbird/images/settings/client_list.PNG"></td>
</tr>
 
<tr>
  <td> 
2. Click the <b>client</b> corresponding to the user configured in step 8 of above section.<br>
    </td>
    <td><img src="https://github.com/project-sunbird/sunbird.org-docs/blob/master/developer-docs/configuring_sunbird/images/settings/select_user_client.PNG"></td>
    </tr>
    
  <tr>
  <td> 
3. Select the <b>Settings</b> tab and click on <b>Implicit flow enabled </b> button. Once this button is enabled, you will get a screen to add Valid Redirect URIs.
  </td>
  <td><img src="https://github.com/project-sunbird/sunbird.org-docs/blob/master/developer-docs/configuring_sunbird/images/settings/in_settings_tab_%20enabl_implicit_%20flow_enabled.PNG"></td>
  </tr>
  
  <tr>
  <td> 
4. Add Root URL and Valid Redirect URIs.
</td>
<td>
  <img src="https://github.com/project-sunbird/sunbird.org-docs/blob/master/developer-docs/configuring_sunbird/images/settings/config-url.PNG">
  </td>
  </tr>
 
</table>
