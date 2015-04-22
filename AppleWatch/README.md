Urban Airship Watch Utils
=========================

Overview
--------

The Urban Airship Watch utilities allow developers to perform common operations from a WatchKit extension such as adding tags,
removing tags, tracking user interactions with custom events, and running any Urban Airship action.

Setup
-----

1. Add UAWatchUtils to the Watch extension

2. Add UAWatchAppDelegateUtils to main application

3. In the application's delegate:

```
    - (void)application:(UIApplication *)application
    handleWatchKitExtensionRequest:(NSDictionary *)userInfo
                  reply:(void (^)(NSDictionary *replyInfo))reply {

        if ([UAWatchAppDelegateUtils handleUrbanAirshipWatchKitExtensionRequest:userInfo reply:reply]) {
            return;
        }

        // Handle custom watch requests

        reply(nil);
    }
```

Quickstart
----------

Adding tags:

    [UAWatchUtils addTags:@["tagOne", "tagTwo"]];

Removing tags:

    [UAWatchUtils removeTags:@["tagOne", "tagTwo"]];

Adding custom events:
    
    [UAWatchUtils addCustomEventWithName:@"custom_event_name" value:100];

Running Urban Airship actions:

    [UAWatchUtils runActionWithName:@"action name" value:@"action value" completion:^(id value, NSString *errorMessage) {
        if (errorMessage) {
            NSLog(@"Failed to run action: %@", errorMessage);
        } else {
            NSLog(@"Action finished with result: %@", value);
        }
    }];

