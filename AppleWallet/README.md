Urban Airship Wallet Action
===========================

Overview
--------

The Urban Airship Wallet Action allows users to save passes directly in the app without being redirected to Safari.

Setup
-----

1. Add UAWalletAction

2. In the application delegate register the `UAWalletAction` after `takeOff`:

```
   [UAirship takeOff];

   // Register the action after takeOff
   [[UAirship shared].actionRegistry registerAction:[[UAWalletAction alloc] init]
                                              names:@[kUAWalletActionDefaultRegistryName, kUAWalletActionDefaultRegistryAlias]];
```
