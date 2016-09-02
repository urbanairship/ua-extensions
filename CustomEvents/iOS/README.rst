This iOS Event Templates repo has been DEPRECATED and will be removed at a future date.

The iOS Event Templates has been moved into the Urban Airship iOS UA 7.3.0 SDK: https://github.com/urbanairship/ios-library

iOS Event Templates
===================

Overview
--------
The Urban Airship Event Templates provides a way to create custom events for
common account, media or retail related events. This framework is
a wrapper for UACustomEvent.

Resources
---------
- Custom Events Guide: http://docs.urbanairship.com/topic-guides/custom-events.html
- Custom Events Quickstart: http://docs.urbanairship.com/topic-guides/custom-events-quickstart.html
- Custom Events: http://docs.urbanairship.com/reference/libraries/ios/latest/Classes/UACustomEvent.html

Setup
-----

To begin using these event templates:

- Clone the latest version of ua-extensions
- Drag the UAEventTemplates.xcodeproj into your project.
  This project is located in /ua-extensions/CustomEvents/iOS/UAEventTemplates/
- Add the UAEventTemplates.framework to the Embedded Binaries section in the
  General tab for your target.

Required Dependencies
---------------------

The project must already contain AirshipKit version 7.0.2 or higher (UAEventTemplates.framework references it).

The project minimum deployment target is 8.0.

Analytics must be enabled to use this feature.

- Verify analytics is enabled ::

    BOOL analyticsEnabled = [UAirship shared].analytics.enabled;

- Enable analytics, if it isn't already enabled ::

    [UAirship shared].analytics.enabled = YES;

Quickstart
----------

UAAccountEvent
##############

This custom event is for account related events, such as a user registering for
a paid premium account.

To create and track the most minimal account registered event ::

    UAAccountEvent *event = [UAAccountEvent registeredEvent];
    [event track];

To create and track an account registered event with optional properties ::

    UAAccountEvent *event = [UAAccountEvent registeredEventWithValue:@(9.99)];
    event.transactionID = @"12345";
    event.category = @"Premium";
    [event track];

UAMediaEvent
############

This custom event is for media related events, such as a user playing a video,
listening to an audio track, reading an article, starring content as their
favorite or sharing content.

To create and track the most minimal consumed content event ::

    UAMediaEvent *event = [UAMediaEvent consumedEvent];
    [event track];

To create and track a consumed content event with optional value ::

    UAMediaEvent *event = [UAMediaEvent consumedEventWithValue:@(1.99)];
    [event track];

To create and track a consumed content event with optional properties ::

    UAMediaEvent *event = [UAMediaEvent consumedEventWithValue:@(2.99)];
    event.category = @"entertainment";
    event.identifier = @"12322";
    event.eventDescription = @"Watching latest entertainment news.";
    event.type = @"video";
    event.author = @"UA Enterprises";
    event.isFeature = YES;
    event.publishedDate = @"November 30, 2015";
    [event track];

To create and track the most minimal starred content event ::

    UAMediaEvent *event = [UAMediaEvent starredEvent];
    [event track];

To create and track a starred content event with optional properties ::

    UAMediaEvent *event = [UAMediaEvent starredEvent];
    event.category = @"entertainment";
    event.identifier = @"1234";
    event.eventDescription = @"Watching latest entertainment news.";
    event.type = @"video";
    event.author = @"UA Enterprises";
    event.isFeature = YES;
    event.publishedDate = @"November 30, 2015";
    [event track];

To create and track the most minimal browsed content event ::

    UAMediaEvent *event = [UAMediaEvent browsedEvent];
    [event track];

To create and track a browsed content event with optional properties ::

    UAMediaEvent *event = [UAMediaEvent browsedEvent];
    event.category = @"entertainment";
    event.identifier = @"1234";
    event.eventDescription = @"Browsed latest entertainment news.";
    event.type = @"video";
    event.author = @"UA Enterprises";
    event.isFeature = YES;
    event.publishedDate = @"November 30, 2015";
    [event track];

To create and track the most minimal shared content event ::

    UAMediaEvent *event = [UAMediaEvent sharedEvent];
    [event track];

To create and track a shared content event with optional facebook source and social medium ::

    UAMediaEvent *event = [UAMediaEvent sharedEventWithSource:@"facebook" withMedium:@"social"];
    [event track];

To create and track a shared content event with optional properties ::

    UAMediaEvent *event = [UAMediaEvent sharedEventWithSource:@"facebook" withMedium:@"social"];
    event.category = @"entertainment";
    event.identifier = @"1234";
    event.eventDescription = @"Watching latest entertainment news.";
    event.type = @"video";
    event.author = @"UA Enterprises";
    event.isFeature = YES;
    event.publishedDate = @"November 30, 2015";
    [event track];

UARetailEvent
#############

This custom event is for retail related events, such as a user browsing a product,
adding an item to a cart, purchasing an item, starring a product as their favorite
or sharing a product.

To create and track the most minimal purchased event ::

    UARetailEvent *event = [UARetailEvent purchasedEvent];
    event track];

To create and track a purchased event with optional properties ::

    UARetailEvent *event = [UARetailEvent purchasedEventWithValue:@(99.99)];
    event.category = @"mens shoes";
    event.identifier = @"12345";
    event.eventDescription = @"Low top";
    event.transactionID = @"13579";
    event.brand = @"SpecialBrand";
    event.isNewItem = YES;
    [event track];

To create and track the most minimal browsed event ::

    UARetailEvent *event = [UARetailEvent browsedEvent];
    [event track];;

To create and track a browsed event with optional properties ::

    UARetailEvent *event = [UARetailEvent browsedEventWithValue:@(99.99)];
    event.category = @"mens shoes";
    event.identifier = @"12345";
    event.eventDescription = @"Low top";
    event.transactionID = @"13579";
    event.brand = @"SpecialBrand";
    event.isNewItem = YES;
    [event track];

To create and track the most minimal added to cart event ::

    UARetailEvent *event = [UARetailEvent addedToCartEvent];
    [event track];

To create and track an added to cart event with optional properties ::

    UARetailEvent *event = [UARetailEvent addedToCartEventWithValue:@(INT32_MIN)];
    event.category = @"mens shoes";
    event.identifier = @"12345";
    event.eventDescription = @"Low top";
    event.transactionID = @"13579";
    event.brand = @"SpecialBrand";
    event.isNewItem = YES;
    [event track];

To create and track the most minimal starred product event ::

    UARetailEvent *event = [UARetailEvent starredProductEvent];
    [event track];

To create and track a starred product event with optional properties ::

    UARetailEvent *event = [UARetailEvent starredProductEventWithValue:@(99.99)];
    event.category = @"mens shoes";
    event.identifier = @"12345";
    event.eventDescription = @"Low top";
    event.transactionID = @"13579";
    event.brand = @"SpecialBrand";
    event.isNewItem = YES;
    [event track];

To create and track the most minimal shared product event ::

    UARetailEvent *event = [UARetailEvent sharedProductEvent];
    [event track];

To create and track a shared product event with optional facebook source and social medium ::

    UARetailEvent *event = [UARetailEvent sharedProductEventWithSource:@"facebook" withMedium:@"social"];
    [event track];

To create and track a shared product event with optional properties ::

    UARetailEvent *event = [UARetailEvent sharedProductEventWithSource:@"facebook" withMedium:@"social"];
    event.category = @"mens shoes";
    event.identifier = @"12345";
    event.eventDescription = @"Low top";
    event.transactionID = @"13579";
    event.brand = @"SpecialBrand";
    event.isNewItem = YES;
    [event track];
