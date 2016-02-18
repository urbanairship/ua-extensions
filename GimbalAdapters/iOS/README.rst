iOS Gimbal Adapter
==================

Overview
--------

The Urban Airship Gimbal Adapter is a drop-in class that allows users to integrate Gimbal place events with 
Urban Airship.

Resources
----------
- Gimbal Developer Guide: https://gimbal.com/doc/iosdocs/v2/devguide.html
- Gimbal Manager Portal: https://manager.gimbal.com
- Gimbal SDKs: https://manager.gimbal.com/sdk_downloads

Working with the Gimbal Adapter
-------------------------------

Gimbal Adapter Installation
###########################

To install the Gimbal Adapter:

- Clone the latest version of ua-extensions
- Import the Gimbal Adapter class header and source file into your project. These files are located in /ua-extensions/GimbalAdapters/iOS/

Required Dependencies
#####################

The Gimbal adapter requires your application to link against the Gimbal V2 SDK ::

	Gimbal.framework
 
For framework installation instructions, see the Gimbal Developer Guide listed in the resources section above.

Quickstart
----------

Setting the Gimbal API Key
#########################

To receive place events from Gimbal, you must have a corresponding application in the Gimbal Manager and set its API key within your iOS application. The API key needs to be set before starting the Gimbal Adapter.  

To set the Gimbal API key immediately after your iOS application has launched: 

- Import the Gimbal Adapter header file ::

	#import "GimbalAdapter.h"

- Make the following call in your AppDelegate's didFinishLaunchingWithOptions: method  :: 

	[Gimbal setAPIKey:<Your_Gimbal_API_key> options:nil];

Starting the iOS Gimbal Adapter
###############################

To start listening for Gimbal Place events immediately after your iOS application has launched:

- Import GimbalAdapter class header into your AppDelegate ::

	#import "GimbalAdapter.h"

- Start the Gimbal Adapter by calling startAdapter on the GimbalAdapter shared instance in your didFinishLaunchingWithOptions: method ::

	[[GimbalAdapter shared] startAdapter]; 

Stopping the iOS Gimbal Adapter
###############################

To stop listening for Gimbal Place events:

- Import GimbalAdapter class header where necessary
- Stop the Gimbal Adapter by calling stopAdapter on the GimbalAdapter shared instance ::

	[[GimbalAdapter shared] stopAdapter]; 


Enabling Bluetooth Warning
##########################

In the event that Bluetooth is disabled during place monitoring, the Gimbal Adapter can prompt users with an alert view
to enable Bluetooth.  This functionality is disabled by default, but can be enabled by setting GimbalAdapter's bluetoothPoweredOffAlertEnabled property to YES ::

	[GimbalAdapter shared].bluetoothPoweredOffAlertEnabled = YES;
