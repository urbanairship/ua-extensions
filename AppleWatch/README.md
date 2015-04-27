Urban Airship Watch Utils
=========================

Overview
--------

The Urban Airship Watch utilities allow developers to perform common operations from a WatchKit extension such as adding tags,
removing tags, and tracking user interactions with custom events.

Setup
-----

1. Add UAWatchUtils to the Watch extension

2. Add UAWatchAppDelegateUtils to main application

3. In the iPhone application's delegate:

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
    
    [UAWatchUtils addCustomEventWithName:@"custom_event_name" value:@100];
