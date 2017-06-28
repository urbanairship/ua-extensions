Urban Airship In App Wallet Action
==================================

Overview
--------

The Urban Airship In App Wallet Action allows users to save passes directly in the app without being redirected to Safari.

This drop in class is intended to replace the functionality of the standard UAWalletAction - this requires the UAInAppWalletAction to be registered under `kUAWalletActionDefaultRegistryName` and `kUAWalletActionDefaultRegistryAlias`.

Setup
-----

1. Add UAInAppWalletAction header and source file to your project.

2. In the application delegate register the `UAInAppWalletAction` after `takeOff` under the default Wallet Action name `kUAWalletActionDefaultRegistryName` and alias `kUAWalletActionDefaultRegistryAlias`:

Obj-C:

```
   [UAirship takeOff];

   // Register the action after takeOff
   [[UAirship shared].actionRegistry registerAction:[[UAInAppWalletAction alloc] init]
                                              names:@[kUAWalletActionDefaultRegistryName, kUAWalletActionDefaultRegistryAlias]];
```

Swift:

```
    UAirship.takeOff(config)

    // Register the action after takeOff
    UAirship.shared().actionRegistry.register(UAInAppWalletAction(), names:[kUAWalletActionDefaultRegistryName, kUAWalletActionDefaultRegistryAlias]);

```
