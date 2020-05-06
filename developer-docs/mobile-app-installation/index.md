---
title: Mobile App Installation Setup  
page_title: Mobile App Installation Setup
description: Setting Up and installing Mobile App
keywords: Setup, Sunbird Mobile App, Install, Configure, set up, Build APK
published: true
allowSearch: true
---

## Introduction

The Sunbird Mobile app provides mobility to its feature-rich learning platform. It provides learners with the flexibility to learn anywhere, anytime.

## Prerequisites
<br>1.To set up Sunbird mobile app, ensure you have installed the following:
<br>&emsp;a) NPM Version - 6.+
<br>&emsp;b) Node JS Version -  8.+
<br>&emsp;c) Cordova Version - 8.+
<br>&emsp;d) Ionic Version - 4.11.2
<br>2. Generate the key and secret for the mobile app user using the JWT token of the mobile admin user. Run the **OnboardConsumers** Jenkins Job and take the jwt token(**JWT token for mobile_admin**) from Jenkins Output.

**Generating Secret:**
Execute the listed API to generate the key and secret for the mobile app:

  curl -X POST \   &#60;your-sunbird-base-url&#62;/api/api-manager/v1/consumer/mobile_app/credential/register \
       -H 'authorization: Bearer &#60;mobile_admin_jwt_token_from_jenkins_job_output&#62;' \
       -H 'content-type: application/json' \
       -d '{
       "request": {
         "key": "&#60;implementation-name&#62;-mobile-app- &#60;version-number&#62;"
       }
     }'

**Response body:** 

{"result":{"key":"&#60;implementation-name&#62;-mobile-app-&#60;version-number&#62;","secret":"&#60;secret&#62;"}} 

Use the  key and secret from the response given for MOBILE_APP_KEY and MOBILE_APP_SECRET configuration in respective environments in gradle.properties file. Example:

**dev_mobile_app_key = "&#60;implementation-name&#62;-mobile-app-&#60;version-number&#62;"
dev_mobile_app_secret = "&#60;secret&#62;"**

**Producer Key**

Replace the producer id `PRODUCER_ID` for respective environments in sunbird.properties.

**Fabric credentials:**

Replace `release_fabric_api_key` in `sunbird.properties` with your fabric API Key. Create an account in [fabric.io](https://get.fabric.io/) and register in the app to get the API key.

## Setup mobile app workspace from Git Repository
Sunbird mobile app can be built from the main source code which is available at  [SunbirdEd-mobile-app](https://github.com/Sunbird-Ed/SunbirdEd-mobile-app).

* Clone the [SunbirdEd-mobile-app](https://github.com/Sunbird-Ed/SunbirdEd-mobile-app) repo
* [Customising App Configuration](#customising-app-configuration) - sample.sunbird.properties file is located inside SunbirdEd-mobile-app > buildConfig folder. This has to be renamed to sunbird.properties and appropriate values should be provided.
* [Package the framework and form data](#package-the-framework-and-form-data).
* go to project folder and run **./build.sh**

### Customising App Configuration

Instance admin of Sunbird adopters can configure various aspects of the Sunbird mobile app based on the requirement of the the organization. The admin are able to configure various aspects such as:

* App name
* App logo
* Login/Guest page to new users
* Sign in footer card on the app
* Onboarding cards
* Categories in the profile page 

| S No. | Variable Name | Description | Purpose | Default Value
|-------|---------------|--------------|--------|--------------
| 1 | dev_app_id/staging_app_id/production_app_id | The app ID in the **SunbirdEd-mobile-app/buildConfig/sunbird.properties** file with the implementation-specific application ID | To change the app ID | appId: "org.sunbird.app"
| 2 | app name | Navigate to the **SunbirdEd-mobile-app/config.xml** file and enter the required app name | To change the app name | 
| 3 | app logo | Navigate to **SunbirdEd-mobile-app/resources/android/icon** | Replace the **ic_launcher.png** image with your desired logo in all the mipmap and drawable folders. The logo name should be **drawable-ldpi-icon.png** | To change the app logo 
| 4 | splash image | Navigate to **SunbirdEd-mobile-app/resources/android/splash** | Replace the **drawable-ldpi-icon.png, drawable-hdpi-icon.png, drawable-xhdpi-icon.png** image with your desired image. | To change the splash image 
| 5 | app | Set the configuration variable in the **SunbirdEd-mobile-app repo** file in the **buildConfig** folder | | 
| 6|  app version code | Version code for the app release | To customize the end points in the app | Replace redirect base url REDIRECT_BASE_URL and all other base urls with your respective domain name in sunbird.properties |
| 7 | deep link schema | This plugin handles deeplinks on iOS and Android for both custom URL scheme links and Universal App Links. Deep link schema can be changed from sunbird.properties | Change the "dev_deeplink_base_url = dev.open-sunbird.org" to the required name
| 8 | display_onboarding_page | set the configuration variable inside the <b>SunbirdEd-mobile-app repo</b> inside <b>buildConfig</b> folder | to display the onboarding page | false
| 9 | display_signin_footer_card_in_course_tab_for_teacher | set the <b>display_signin_footer_card_in_course_tab_for_teacher</b>variable as <b>true</b> in sunbird.properties file | to show the sign-in footer in the course tab for teachers | false
| 10 | display_signin_footer_card_in_library_tab_for_teacher | Set the <b>display_signin_footer_card_in_library_tab_for_teacher</b> variable <b>true</b> in sunbird.properties file | to show the sign-in footer in the library tab for teachers | false
| 11 | display_signin_footer_card_in_profile_tab_for_teacher | Set the <b>display_signin_footer_card_in_profile_tab_for_teacher</b>as <b>true</b> in sunbird.properties file | to show the sign-in footer in the profile tab for teachers | false
| 12 | display_signin_footer_card_in_profile_tab_for_student | Set the <b>display_signin_footer_card_in_profile_tab_for_student</b>as <b>true</b> in sunbird.properties file | to show the sign-in footer in the profile tab for students | false
| 13 | display_signin_footer_card_in_library_tab_for_student | Set the <b>display_signin_footer_card_in_library_tab_for_student</b>as <b>true</b> in sunbird.properties file | to show the sign-in footer in the profile tab for students | false
| 14 | display_onboarding_card | set the display__onboarding_cards as true in sunbird.properties file | to display the guest/login page | false
| 15 | display_framework_categories_in_profile | set the display_framework_categories_in_profile variable as true in sunbird.properties file | to display categories in the guest/login page | false
| 16 | track_user_telemetry | Variable used to track user telemetry.| Used to track telemetry that is missing at the device level so as to generate greater usage context within the instance. Set the variable as *true* in the **sunbird.properties** file to enable tracking.  | false
| 17 | content_streaming_enabled | Variable used to enable content streaming| Used to enable content streaming. Set the variable as *true* in the **sunbird.properties** file to enable content streaming | false
| 18 | open_rapdiscovery_enabled | Variable used to enable OPENRAP discovery| Used to enable OPENRAP discovery. Set the variable as *true* in the **sunbird.properties** file to enable OPENRAP discovery | false
| 19 | display_onboarding_category_page | Variable used to enable onboarding category selection page| Used to  onboarding category selection page in the onboarding process. Set the variable as *true* in the **sunbird.properties** file to enable onboarding category selection page.  | false
| 20 | display_onboarding_scan_page | Variable used to enable onboarding scan page.| Used to enable onboarding scan page in the onboarding process. Set the variable as *true* in the **sunbird.properties** file to onboarding scan page | false
| 21 | support_email | Variable used to set| Used to set the support email id. Set the variable as *&#60;valid_email_id&#62;* in the **sunbird.properties** file to set support email id | &#60;valid_email_id&#62;
| 22 | dev_custom_scheme/staging_custom_scheme/production_custom_scheme | Scheme used to redrirect chrome custom tab back to mobile app |  | "org.sunbird.app"

###  Packaging Framework and Form Data
Sunbird mobile app supports configuration of the app framework to enable offline usage of the app. To configure the app framework, adopter needs to package the channel for the respective framework. Details of the file naming convention and folder location are given below:

| S No. | Folder | File Name |  Purpose 
|-------|--------|-----------|-------------
| 1 | buildConfig/data/framework | framework-&#60;FRAMEWORK_IDENTIFIER&#60;.json | To package the channel for the respective framework. Same framework must be listed in the channel's suggestedFramework list
| 2 | buildConfig/data/channel | channel-&#60;CHANNEL_IDENTIFIER&#62;.json | To package the channel. To support offline usage custodianOrgId channel must be included in the bundle
| 3 | buildConfig/data/form | pageassemble_course_filter.json | Page assemble filter for course
| 4 | buildConfig/data/form | pageassemble_library_filter.json | Page assemble filter for library
| 5 | buildConfig/data/system | &#60;system-setting-custodianOrgId&#62;.json | custodianOrgId channelid for the mobile app
| 6 | buildConfig/data/system | system-setting-courseFrameworkId.json | courseFrameworkId for the TPD workflow
| 7 | buildConfig/data/notificationconfig | local_notofocation_config.json | Configuration for local Notification setup in mobile

### Installing the Mobile Application

  1.Create a workspace (Folder Hierarchy) and clone the Git repositories into this folder

  2.Execute the instructions mentioned for each cloned repository

  3.Open terminal and change the directory to "SunbirdEd-mobile-app" 

  4.Add one device to the system

  5.Run the command- **$ ionic cordova run android**
  
### Generate Multiple Sunbird Apps
As a Sunbird instance owner, owner  should be able to generate multiple apps for multiple environments(dev/qa/production)
so that user can use all the apps simultaneously.
For each app, user should be able to have different content stores (on the local device), fire telemetry from separate app identifiers and upload to playstore (if need be).
#### Configuration
Instance admin of Sunbird adopters can configure the appId in the following way to acheive the functionality
* dev_app_id = org.sample.app.dev
* staging_app_id = org.sample.app.staging
* production_app_id = org.sample.app
