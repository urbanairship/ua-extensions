iOS Gimbal Adapter
==================

Overview
--------

The Urban Airship GimbalAdapter is a drop-in class that allows users to integrate Gimbal place events with 
Urban Airship's analytics system.

Resources
----------
- Gimbal Developer Guide: https://gimbal.com/doc/iosdocs/v2/devguide.html
- Gimbal Manager Portal: https://manager.gimbal.com
- Gimbal SDKs: https://manager.gimbal.com/sdk_downloads

Working with the Gimbal Adapter
-------------------------------

GimbalAdapter Installation
##########################

To install the GimbalAdapter:

- Clone the latest version of ua-extensions
- Import the GimbalAdapter class header and source file into your project. These files are located in /ua-extensions/GimbalAdapters/iOS/

Required Dependencies
#####################

The Gimbal adapter requires your application to link against the Gimbal V2 SDK ::

	Gimbal.framework
 
For framework installation instructions, see the Gimbal Developer Guide listed in the resources section above.

Quickstart
----------

Adding the Gimbal API Key
#########################

To receive place events from Gimbal, you must have a corresponding application in the Gimbal Manager and set its API key in your 
iOS application's AirshipConfig.plist. 

To set an API key in your AirshipConfig.plist:
- Open your application's AirshipConfig.plist
- Add a new row with the key 'gimbalApiKey' 
- Ensure that the row's type is set to 'String'
- Set the 'gimbalApiKey' row value to your corresponding Gimbal Manager application's API key.

Example plist contents: ::

	<?xml version="1.0" encoding="UTF-8"?>
	<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
	<plist version="1.0">
	<dict>
	  <key>inProduction</key>
	  <false/>
	  <key>developmentAppKey</key>
	  <string>Your Development App Key</string>
	  <key>developmentAppSecret</key>
	  <string>Your Development App Secret</string>
	  <key>productionAppKey</key>
	  <string>Your Production App Key</string>
	  <key>productionAppSecret</key>
	  <string>Your Production App Secret</string>
	  <key>gimbalApiKey</key>
	  <string>Your Gimbal Api Key</string>
	</dict>
	</plist>

Starting the iOS GimbalAdapter
##########################

To start listening for Gimbal Place events immediately after your iOS application is launched:

- Import GimbalAdapter class header into your AppDelegate ::

	#import GimbalAdaper.h

- Start the GimbalAdapter by setting gimbalAdapterEnabled to YES in your didFinishLaunchingWithOptions: method ::

	[[GimbalAdapter shared] setGimbalAdapterEnabled:YES]; 


Stopping the iOS GimbalAdapter
##########################

To stop listening for Gimbal Place events:

- Import GimbalAdapter class header where necessary
- Stop the GimbalAdapter by setting gimbalAdapterEnabled to NO ::

	[[GimbalAdapter shared] setGimbalAdapterEnabled:NO]; 


Enabling Bluetooth Warning
##########################

In the event that bluetooth is disabled during place monitoring, the GimbalAdapter can prompt users with an alert view
to enable bluetooth.  This functionality is disabled by default, but can be enabled by setting GimbalAdapter's bluetoothPoweredOffAlertEnabled 
property to YES ::

	[GimbalAdapter shared].bluetoothPoweredOffAlertEnabled = YES;