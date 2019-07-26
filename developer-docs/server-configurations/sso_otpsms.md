---
title: Configure OTP based SMS
page_title: Configure OTP based SMS 
description: How to set up the OTP for SMS
published: true
allowSearch: true
keywords: SSO, single sign on, single signon, singlesignon, sign in, SMS, sms, otp, OTP, Keycloak
---

## Overview
An OTP sent via SMS to the user's registered mobile number is one of the most secure and efficient ways to authenticate users for specific transactions. For example, if a user wants to reset the password, configure the text message to be sent via SMS along with the generated OTP in Keycloak. To configure the text messages, complete the following steps:


<table>
<tr>
  <th style="width:35%;">Step</th>
  <th style="width:65%;">Screen</th>
</tr>
<tr>
  <td>1. Enter your <b>Username or email</b> and <b>Password</b><br><br>2. Click <b>Log in</b> to log into the Keycloak admin console</td>
  <td><img src="images/keycloak_login.png"></td>
</tr>
<tr>
  <td> 3. Click the <b>Realm Selector dropdown</b> from the navigation pane and select an appropriate realm <br>
  <b>Note:</b> The <b>Master</b> realm is selected by default.</td>
	<td><img src="images/realm_select.png"></td>
</tr>
<tr>
  <td>4. Go to the <b>Configure</b> section and select the <b>Authentication</b> tab.</td>
  <td><img src="images/selectauthenticationsection.png"></td>
  </tr>
<tr>
  <td>5. Go to the <b>Flows </b> tab, select <b>Reset Credentials With SMS OTP</b> option from the drop-down list.</td>
  <td><img src="images/selectflows.png"></td>
</tr>
<tr>
<td>6. Select <b>Actions</b> as <i>Config</i> for <b>SMS Authentication (Reset credentials with SMS OTP)</b>.</td>
  <td><img src="images/selectconfig.png"></td>
  </tr>
<tr>
  <td>7. Change the text for <b> Template of text to send to the user </b> with the actual text of the message to be sent to users while sending the OTP SMS.</td>
  <td><img src="images/changesmsotp.png"></td>
  </tr>
</table>