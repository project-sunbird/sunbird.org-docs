---
type: landing
directory: developer-docs/telemetry
title: AuthToken Generation 
page_title: AuthToken generation
description: AuthToken generation
published: true
allowSearch: true
---

## How to generate authorization credentials

This section details the procedure to generate the AuthToken and secret key that is required to access any APIs and to configure the standalone telemetry JS library.

### Process

<img src="developer-docs/installation/images/telemetry_service2.png">

### Prerequisites

* Access to the Ekstep Community portal

### Procedure

<table>
  <tr>
    <td style="width:35%;">Step</td>
    <td style="width:65%;">Screen</td>
  </tr>
  <tr>
    <td><strong>Sign In</strong> <br>1. Sign in to  Ekstep QA portal (https://qa.ekstep.in) <br>2. Go to Resources > Developers <br> <strong>Note:</strong> If you have already created QA credentials and tested Sunbird, and are looking at acquiring production credentials, repeat the same steps on visit <a href="https://community.ekstep.in/api-credentials" target="_blank">https://community.ekstep.in/api-credentials</a> instead.</td>
    <td><img src="developer-docs/installation/images/telemetry_service3.png"></td>
  </tr>
  <tr>
    <td><strong>Request API Access</strong> <br>1. Select <strong>API credentials</strong> <br>2. The <strong>Manage Credentials</strong> page is displayed
<br>3. Click <strong>Request API access</strong> to request access for available API groups</td>
    <td><img src="developer-docs/installation/images/telemetry_service4.png"></td>
  </tr>
  <tr>
    <td><li>On successful submission of the API access request, the portal admin is notified. The admin either approves or rejects the request</li> <br><li> You are notified of the admin’s action through a mail to your registered mail ID </li> <br> <li>You can also view the action taken, by clicking the notification icon on the portal</li></td>
    <td><img src="developer-docs/installation/images/telemetry_service5.png"></td>
  </tr>
  <tr>
    <td><strong>Generate New Credentials</strong> <br>1. Enter the username <br>2. Enter notes, if any <br>3. The API groups that can be accessed with the created credentials are listed here <br>4. Click <strong>Generate credentials</strong> to generate key and secret</td>
    <td><img src="developer-docs/installation/images/telemetry_service6.png"></td>
  </tr>
  <tr>
    <td><strong>Note the Credentials</strong> <br>1. Ensure to copy the key and secret and confirm the same <br>2. Click <strong>Close</strong> after copying the Key and Secret
</td>
    <td><img src="developer-docs/installation/images/telemetry_service7.png"></td>
  </tr>
</table>

## Generating JWT

The key and secret issued in the above request can be used to create a JSON Web Token (JWT) for authorizing requests.
Request

The requests need to contain HS256 signed JSON Web Tokens (as specified in RFC 7519). Now that you have a credential, and since we want to sign it using HS256, the JWT should be crafted as follows (according to RFC 7519):
First, the header must be:

<pre>
{
    "typ": "JWT",
    "alg": "HS256"
}
</pre>


Secondly, the claims must contain the credential's key in the claim:

<pre>
{
    "iss": "8f00bc9585904d95e51cc4a1" \\ "key" of the credential  shared above.
}
</pre>

The remaining fields of the JWT can be filled based on the details of the request being sent. For example, for a request payload which accesses the content API, the claims created will look like

<pre>
{
   "iss": "8f00bc9585904d95e51cc4a1", // the issuer of the claim or the "key"
   "iat": "1442426231600", // epoch timestamp when JWT was created
   "id": "org.sunbird.api.contentAPI", // target API
   "qsh": "8063ff4ca1e41df0f6207d491cf6dad7c66ea797b4614b7", // hashed query string
   "version": "1.0",  // version of the API
   "params": { // contextual parameters from the API request
      "did": "ff305d54-85b4-341b-da2f-eb6b9e5460fa", 
      "msgid": "c3049b36249a3c9f8891cb1999777743c"
   }
}
</pre>

The generated JWT from the claims above will look like

<pre>
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJhMzZjMzA0OWIzNjI0OWEzYzlmODg5MWNiMTI3MjQzYyIsImlhdCI6IjE0NDI0MjYyMzE2MDAiLCJpZCI6Im9yZy5la3N0ZXAuYXBpLmRhdGFTZXQiLCJxc2giOiI4MDYzZmY0Y2ExZTQxZGYwZjYyMDdkNDkxY2Y2ZGFkN2M2NmVhNzk3YjQ2MTRiNyIsInZlcnNpb24iOiIxLjAiLCJwYXJhbXMiOnsiZGlkIjoiZmYzMDVkNTQtODViNC0zNDFiLWRhMmYtZWI2YjllNTQ2MGZhIiwibXNnaWQiOiJjMzA0OWIzNjI0OWEzYzlmODg5MWNiMTk5OTc3Nzc0M2MifX0.rww4BN-EfnAXKTRltQChYA3KM31GzyEF-YpYvIBzw1I
</pre>

Usually, the JWT will be created programmatically by your application. JWT libraries exist for all popular programming languages.

However, you may also use the web-based tool - http://jwtbuilder.jamiekurtz.com/ to generate the JWT. Note that when using this tool, the key should be set as the iss field in the claims section of the payload and the secret obtained should be set as the Key field in the Signed JWT section. The Key will be used to generate a signed JWT.
Response
If auth fails, the response code will be 401 or 403 and will also have the error metadata in the response payload. A normal response will be a 200. For clients which need to be protocol agnostic, the response payload has error metadata to extract the error code and message, if any.

<pre>
{
    "id": "", // unique API ID
    "ver": "", // API version
    "ets": "", // epoch timestamp 
    "params": {
        "resmsgid": "", // unique response message id (UUID)
        "msgid": "", // message id of the request
        "status": "", // status of request e.g: successful, failed etc
        "err": "", // error code if any
        "errmsg": "" // default English error message
    },
    // API specific JSON output goes here
}
</pre>
