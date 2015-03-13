Android Gimbal Adapter
==================

Overview
--------

The Urban Airship Gimbal Adapter is a drop-in class that allows users to integrate Gimbal Place events with 
Urban Airship.

Resources
----------
- Gimbal Developer Guide: https://gimbal.com/doc/android/v2/devguide.html
- Gimbal Manager Portal: https://manager.gimbal.com
- Gimbal SDKs: https://manager.gimbal.com/sdk_downloads

Working with the Gimbal Adapter
-------------------------------

Gimbal Adapter Installation
##########################

To install the Gimbal Adapter:

- Clone the latest version of ua-extensions
- Import the GimbalAdapter class into your project. This file is located in /ua-extensions/GimbalAdapters/Android/

Required Dependencies
#####################

The Gimbal adapter requires the following dependencies ::

	gimbal-dev-logging.jar
	gimbal.jar
	spring-android-core-1.0.1.RELEASE.jar
	spring-android-rest-template-1.0.1.RELEASE.jar
 
For jar installation instructions, see the Gimbal Developer Guide listed in the resources section above.

Quickstart
----------

Setting the Gimbal API Key
#########################

To receive place events from Gimbal, you must have a corresponding application in the Gimbal Manager and set its API key within your Android application. The API key needs to be set before starting the Gimbal Adapter.  

To set the Gimbal API key immediately after your Android application has launched:

- Import the Gimbal package ::

	import com.gimbal.android.Gimbal;

- Set the Gimbal API key in your MainApplication's onCreate() method ::

	Gimbal.setApiKey(this, <your_gimbal_api_key>);

Starting the Gimbal Adapter
###########################

To start listening for Gimbal Place events immediately after your Android application has launched:

- Import the Gimbal package ::

	import com.gimbal.android.Gimbal;

- Start the Gimbal Adapter by calling start on the shared GimbalAdapter instance in your MainApplication's onCreate() method ::

	GimbalAdapter.shared().start();

Stopping the Gimbal Adapter
###########################

To stop listening for Gimbal Place events:

- Import the Gimbal package if necessary
- Stop the GimbalAdapter by calling stop on the shared GimbalAdapter instance ::

	GimbalAdapter.shared().stop();