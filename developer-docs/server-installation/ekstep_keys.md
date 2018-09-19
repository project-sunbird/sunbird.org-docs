---
title: Prerequisites
page_title: Server Installation Prerequisites
description: Setting up Sunbird on a server
allowSearch: true
---

## Methods

This section details the procedure to generate the AuthToken and secret key that is required to access any APIs

### Generate new AuthToken

  generate: function(key, secret){}

Request Arguments:

  key- "key" of the JWT Credential For ex: '398e54e888da42f8d089je28c298o42b'
  secret- "secret" of the JWT Credential For ex: '07c6e2t1rb92987fnrd705jkk8582p9e'

### Regenerate Expired AuthToken

  refresh: function(oldAuthToken) { }


### Generate JWT With Bash

Authtoken can be generated using the bash script also, for more details refer [blog](https://willhaley.com/blog/generate-jwt-with-bash/)

## Prerequisites

* Browse for [Ekstep Community Portal](https:// letsencrypt.org/)
* Login to the portal using your Google or Facebook account
 
## Requesting Access

<table>
  <tr>
    <td style="width:35%;">Step</td>
    <td style="width:65%;">Screen</td>
  </tr>
  <tr>
    <td>Go to Resources > Developers 
    <br> <b>Note:</b> If you have already created QA credentials and tested Sunbird, and are looking at acquiring production credentials, visit  <a href="https://community.ekstep.in/api-credentials" target="_blank">API Credential</a> page and follow the steps.</td>
    <td><img src="developer-docs/installation/images/telemetry_service3.png"></td>
  </tr>
  <tr>
    <td><b>Requesting API Access</b> <br>1. Select <b>API credentials</b> <br>2. The <b>Manage Credentials</b> page is displayed
<br>3. Click <b>Request API access</b> to request access for available API groups</td>
    <td><img src="developer-docs/installation/images/telemetry_service4.png"></td>
  </tr>
  <tr>
    <td><li>On successful submission of the API access request, the portal admin is notified. The admin either approves or rejects the request</li> <br><li> You are notified of the admin’s action through a mail to your registered mail ID </li> <br> <li>You can also view the action taken, by clicking the notification icon on the portal</li></td>
    <td><img src="developer-docs/installation/images/telemetry_service5.png"></td>
  </tr>
  <tr>
    <td><b>Generating New Credentials</b> <br>1. Enter the username <br>2. Enter notes, if any <br>3. The API groups that can be accessed with the created credentials are listed here <br>4. Click <b>Generate credentials</b> to generate key and secret</td>
    <td><img src="developer-docs/installation/images/telemetry_service6.png"></td>
  </tr>
  <tr>
    <td><b>Copying the Credentials</b> <br>1. Ensure to copy the key and secret and confirm the same <br>2. Click <b>Close</b> after copying the Key and Secret
</td>
    <td><img src="developer-docs/installation/images/telemetry_service7.png"></td>
  </tr>
</table>
