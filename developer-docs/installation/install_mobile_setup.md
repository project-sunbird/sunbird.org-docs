---
type: landing
directory: developer-docs/installation/
title: Setting Up Mobile App
page_title: Setting Up Mobile App
description: Setting Up Mobile App
keywords: Setup, Subird Mobile App, Install, Cofigure, set up,Build APK
published: true
allowSearch: true
---
## Introduction

The Sunbird Mobile app provides mobility to its feature-rich learning platform. It provides learners with the flexibility to learn anywhere, anytime.

## Prerequisites
<br>1.To set up Sunbird mobile app, ensure you have installed the following:
<br>&emsp;a) NPM Version - 3.8.+
<br>&emsp;b) Node JS Version -  6.+
<br>&emsp;c) Cordova Version - 8.0.0
<br>&emsp;d) Ionic Version - 3.20.0
<br>2. Generate the key and secret for the mobile app user using the JWT token of the mobile admin user. The JWT token for mobile admin user will be printed on the application:
 *server folder /where-you-cloned-sunbird-devops-repo/sunbird-devops/deploy/logs/apis.log.*

**Generating Secret:**
Execute the listed API to generate the key and secret for the mobile app:

  curl -X POST \   <your-sunbird-base-url>/api/api-manager/v1/consumer/mobile_app/credential/register \
       -H 'authorization: Bearer <mobile_admin_jwt_token_from_apis_log_file>' \
       -H 'content-type: application/json' \
       -d '{
       "request": {
         "key": "<implementation-name>-mobile-app-<version-number>"
       }
     }'

**Response body:** 

{"result":{"key":"<implementation-name>-mobile-app-<version-number>","secret":"<secret>"}} 

Use the  key and secret from the response given for MOBILE_APP_KEY and MOBILE_APP_SECRET configuration in respective environments in gradle.properties file. Example:

**dev_mobile_app_key = "<implementation-name>-mobile-app-<version-number>"
dev_mobile_app_secret = "<secret>"**

**Producer Key**

Replace the producer id `PRODUCER_ID` for respective environments in sunbird.properties.

**Fabric credentials:**

Replace `release_fabric_api_key` in `sunbird.properties` with your fabric API Key. Create an account in [fabric.io](https://get.fabric.io/) and register in the app to get the API key.

## Build APK from Git Repository
Sunbird mobile app can be built from the main source code which is available at [Sunbird-Ed](https://github.com/Sunbird-Ed)/[SunbirdEd-mobile](https://github.com/Sunbird-Ed/SunbirdEd-mobile).

Sample properties file is located inside buildConfig folder. This has to be renamed to sunbird.properties and appropriate values should be provided.

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
| 1 | dev_app_id/staging_app_id/production_app_id | The app ID in the **SunbirdEd-mobile/buildConfig/sunbird.properties** file with the implementation-specific application ID | To change the app ID | appId: "org.sunbird.app"
| 2 | app name | Navigate to the **SunbirdEd-mobile/config.xml** file and enter the required app name. | To change the app name | 
| 3 | app logo | Navigate to **SunbirdEd-mobile/resources/android/icon** and **SunbirdEd-mobile/resources/android/splash**. Replace the **ic_launcher.png** image with your desired logo in all the mipmap and drawable folders. The logo name should be **drawable-ldpi-icon.png** | To change the app logo |
| 4 | app | Set the configuration variable in the **SunbirdEd-mobile repo** file in the **buildConfig** folder | | 
| 5|  app version code | Version code for the app release | To customize the end points in the app | Replace redirect base url REDIRECT_BASE_URL and all other base urls with your respective domain name in sunbird.properties |
| 6 | deep link schema | This plugin handles deeplinks on iOS and Android for both custom URL scheme links and Universal App Links. Deep link schema can be changed from sunbird.properties | Change the "dev_deeplink_base_url = dev.open-sunbird.org" to the required name
| 7 | display_onboarding_page | set the configuration variable inside the <b>SunbirdEd-mobile repo</b> inside <b>buildConfig</b> folder | to display the onboarding page | false
| 8 | display_signin_footer_card_in_course_tab_for_teacher | set the <b>display_signin_footer_card_in_course_tab_for_teacher</b>variable as <b>true</b> in sunbird.properties file | to show the sign-in footer in the course tab for teachers | false
| 9 | display_signin_footer_card_in_library_tab_for_teacher | Set the <b>display_signin_footer_card_in_library_tab_for_teacher</b> variable <b>true</b> in sunbird.properties file | to show the sign-in footer in the library tab for teachers | false
| 10 | display_signin_footer_card_in_profile_tab_for_teacher | Set the <b>display_signin_footer_card_in_profile_tab_for_teacher</b>as <b>true</b> in sunbird.properties file | to show the sign-in footer in the profile tab for teachers | false
| 11 | display_signin_footer_card_in_profile_tab_for_student | Set the <b>display_signin_footer_card_in_profile_tab_for_student</b>as <b>true</b> in sunbird.properties file | to show the sign-in footer in the profile tab for students | false
| 12 | display_signin_footer_card_in_library_tab_for_student | Set the <b>display_signin_footer_card_in_library_tab_for_student</b>as <b>true</b> in sunbird.properties file | to show the sign-in footer in the profile tab for students | false
| 13 | display_onboarding_card | set the display__onboarding_cards as true in sunbird.properties file | to display the guest/login page | false
| 14 | display_framework_categories_in_profile | set the display_framework_categories_in_profile variable as true in sunbird.properties file | to display categories in the guest/login page | false
| 15 | track_user_telemetry | Variable used to track user telemetry.| Used to track telemetry that is missing at the device level so as to generate greater usage context within the instance. Set the variable as *true* in the **sunbird.properties** file to enable tracking.  | false
| 16 | content_streaming_enabled | Variable used to enable content streaming.| Used to enable content streaming. Set the variable as *true* in the **sunbird.properties** file to enable content streaming.  | false
| 17 | open_rapdiscovery_enabled | Variable used to enable OPENRAP discovery.| Used to enable OPENRAP discovery. Set the variable as *true* in the **sunbird.properties** file to enable OPENRAP discovery.  | false
| 18 | display_onboarding_category_page | Variable used to enable onboarding category selection page.| Used to  onboarding category selection page in the onboarding process. Set the variable as *true* in the **sunbird.properties** file to enable onboarding category selection page.  | false
| 19 | display_onboarding_scan_page | Variable used to enable onboarding scan page.| Used to enable onboarding scan page in the onboarding process. Set the variable as *true* in the **sunbird.properties** file to onboarding scan page.  | false
| 20 | support_email | Variable used to set.| Used to set the support email id. Set the variable as *<valid_email_id>* in the **sunbird.properties** file to set support email id.  | <valid_email_id>
| 21 | dev_custom_scheme/staging_custom_scheme/production_custom_scheme | Scheme used to redrirect chrome custom tab back to mobile app |  | "org.sunbird.app"

<b>Packaging Framework and Form Data</b>
Sunbird mobile app supports configuration of the app framework to enable offline usage of the app. To configure the app framework, adopter needs to package the channel for the respective framework. Details of the file naming convention and folder location are given below:

| S No. | Folder | File Name |  Purpose 
|-------|--------|-----------|-------------
| 1 | buildConfig/data/framework | framework-<FRAMEWORK_IDENTIFIER>.json | To package the channel for the respective framework. Same framework must be listed in the channel's suggestedFramework list.
| 2 | buildConfig/data/channel | channel-<CHANNEL_IDENTIFIER>.json | To package the channel. To support offline usage custodianOrgId channel must be included in the bundle.
| 3 | buildConfig/data/form | pageassemble_course_filter.json | Page assemble filter for course.
| 4 | buildConfig/data/form | pageassemble_library_filter.json | Page assemble filter for library.
| 5 | buildConfig/data/system | system-setting-custodianOrgId.json | custodianOrgId channelid for the mobile app.
| 6 | buildConfig/data/system | system-setting-courseFrameworkId.json | courseFrameworkId for the TPD workflow.
| 7 | buildConfig/data/notificationconfig | local_notofocation_config.json | Configuration for local Notification setup in mobile.

## Installing Individual Plugins
Sunbird is an open source, configurable, extendable, modular learning management platform architected for scale and designed to support multiple teaching and learning solutions supporting multiple languages and available for online and offline use. Various plugins are utilized to meet this objective. Adopters can choose and intall plugins to customize the application to suit their business needs. This ection details the procedure for installing inidividual plugins for the mobile application.

- Clone the SunbirdEd-mobile  repo using the following command: 

	git clone [https://github.com/Sunbird-Ed/SunbirdEd-mobile.git](https://github.com/Sunbird-Ed/SunbirdEd-mobile.git).
	go to project folder and run **./build.sh**
	**run** ionic cordova platform add android**

### Cordova-plugin-sunbirdsplash
This plugin displays and hides a splash screen during application launch. To change the splash screen and splash image, go to SunbirdEd-mobile/resources/android/splash and update the **drawable-ldpi-splash.png**

To update your required splash.png file and SunbirdEd-mobile/resources/android/icon update **drawable-ldpi-icon.png ** to your required **icon.png file ** in resource folder and  run **ionic cordova run android**. This generates the resource files for this platform and splash image and splash screen automatically changes and is added in config.xml file.

**App Name** is in **sunbird.properties**, change the app name to required name

- Run the following command to install this plugin in SunbirdEd-mobile:

    ionic Cordova plugin add [https://github.com/project-sunbird/cordova-plugin-sunbirdsplash.git](https://github.com/project-sunbird/cordova-plugin-sunbirdsplash.git)

This is installed with other npm packages.

### Cordova-plugin-geniecanvas
On clicking on  course material links, the course content is displayed in the inbuilt content player. The genie canvas renders the display of course materials in the inbuilt player.

- Run the following command to install this plugin in SunbirdEd-mobile:

    ionic cordova plugin add [https://github.com/project-sunbird/cordova-plugin-geniecanvas.git](https://github.com/project-sunbird/cordova-plugin-geniecanvas.git)

### Cordova-plugin-qr-scanner
This is a custom cordova plugin for the QR scanner.

- Run the following command to install this plugin in SunbirdEd-mobile:

    ionic cordova plugin add [https://github.com/project-sunbird/cordova-plugin-qr-scanner.git](https://github.com/project-sunbird/cordova-plugin-qr-scanner.git)

This is installed with other npm packages.

### Installing the Mobile Application

  1.Create a workspace  (i.e Folder Hierarchy ) and clone the Git repositories into this folder

  2.Execute the instructions mentioned for each cloned repository

  3.Open terminal and change the directory to "SunbirdEd-mobile" 

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
