---
title: Configuration for SSO Public Key 
page_title: Configuration for SSO Public Key 
description: How to set up the SSO public key
published: true
allowSearch: true
keywords: SSO, Keys, Public key, user authentication, single sign on, single signon, singlesignon, sign in
---

Sunbird facilitates the use of Single SignOn (SSO) for user authentication. Technically, SSO uses a central service that orchestrates common authentication between multiple applications. Use of the SSO service eliminates the need for users to sign in to individual applications and hence removes separate authentication of the user for each application. It authenticates users only once, for the first time, when they sign in. Subsequently, users are automatically authenticated when they access other related applications. 

To provide access to users and enable them to perform API operations, you need to set up the SSO authentication key value in your environment.

## Setting Up the SSO Public Key

<table>

<tr>
<th style="width:35%;">Step</th>
<th style="width:65%;">Screen</th>
 </tr>
  
<tr>
<td>
1. Enter your <b>Username or email</b> and <b>Password</b><br>
2. Click <b>Log in</b> to log into the Keycloak admin console
</td>
<td><img src="developer-docs\configuring_sunbird\images\keycloak_login.png"></td>
</tr>
 
<tr>
  <td> 
3. Click the <b>Realm Selector Dropdown</b> from the left corner of your screen and select appropriate realm <br>
<b>Note:</b> The <b>Master</b> realm is selected by default.
	</td>
	<td><img src="developer-docs\configuring_sunbird\images\realm_select.png"></td>
	</tr>
	
  <tr>
  <td> 
  4. Click on the <b>Keys tab</b> from the menu bar
  </td>
  <td><img src="developer-docs\configuring_sunbird\images\select_key_tab.png"></td>
  </tr>
  
  <tr>
  <td> 
  5. Click on the <b>Public key</b> button from the table<br>
  <b>Note:</b> A text string is displayed as a popup 
  </td>
  <td>
  <img src="developer-docs\configuring_sunbird\images\public_key_btn.png">
  </td>
  </tr>
  
  <tr>
  <td> 
	  6.Copy the text string and paste it as a value for the <b>sunbird_sso_publickey</b> environment variable located inside the <b> https://github.com/project-sunbird/sunbird-lms-mw/blob/master/setup.md </b> file, while you are deploying Sunbird platform services 
  </td>
  <td><img src="developer-docs\configuring_sunbird\images\copy_token.png"></td>
  </tr>
  
</table>
