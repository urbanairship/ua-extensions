Android Event Templates
=======================

Overview
--------
The Urban Airship Event Templates provides a way to create custom events for
common account, media or retail related events. This library is a wrapper
for the CustomEvent class.

Resources
---------
- Custom Events Guide: http://docs.urbanairship.com/topic-guides/custom-events.html
- Custom Events Quickstart: http://docs.urbanairship.com/topic-guides/custom-events-quickstart.html
- Custom Events: http://docs.urbanairship.com/reference/libraries/android/latest/reference/com/urbanairship/analytics/CustomEvent.html

Setup
-----

Include the Urban Airship maven repository in the project's build.gradle file: ::

    repositories {
       maven {
          url  "https://urbanairship.bintray.com/android"
       }
    }

    dependencies {
       compile 'com.urbanairship.android:event-templates:1.1.+'
    }

Required Dependencies
---------------------

The project must already be integrated with the Urban Airship SDK version 7.0.2 or higher.

Analytics must be enabled to use this feature.

- Verify analytics is enabled ::

    boolean analyticsEnabled = UAirship.shared().getAnalytics().isEnabled();

- Enable analytics, if it isn't already enabled ::

    UAirship.shared().getAnalytics().setEnabled(true);

Quickstart
----------

AccountEvent
############

This custom event is for account related events, such as a user registering for
a paid premium account.

To create and track the most minimal account registered event ::

    AccountEvent.createRegisteredEvent().track();

To create and track an account registered event with optional properties ::

    AccountEvent.createRegisteredEvent()
                .setValue(9.99)
                .setCategory("premium")
                .setTransactionId("12345")
                .track();

MediaEvent
##########

This custom event is for media related events, such as a user playing a video,
listening to an audio track, reading an article, starring content as their
favorite or sharing content.

To create and track the most minimal consumed content event ::

    MediaEvent.createConsumedEvent().track();

To create and track a consumed content event with optional value ::

    MediaEvent.createConsumedEvent(1.99).track();

To create and track a consumed content event with optional properties ::

    MediaEvent.createConsumedEvent(2.99)
              .setCategory("entertainment")
              .setId("12345")
              .setDescription("Watching latest entertainment news.")
              .setType("video")
              .setAuthor("UA Enterprises")
              .setFeature(true)
              .setPublishedDate("November 4, 2015")
              .track();

To create and track the most minimal starred content event ::

    MediaEvent.createStarredEvent().track();

To create and track a starred content event with optional properties ::

    MediaEvent.createStarredEvent()
              .setCategory("entertainment")
              .setId("12345")
              .setDescription("Watching latest entertainment news.")
              .setType("video")
              .setAuthor("UA Enterprises")
              .setFeature(true)
              .setPublishedDate("November 4, 2015")
              .track();

To create and track the most minimal browsed content event ::

    MediaEvent.createBrowsedEvent().track();

To create and track a browsed content event with optional properties ::

    MediaEvent.createBrowsedEvent()
              .setCategory("entertainment")
              .setId("12345")
              .setType("video")
              .setAuthor("UA Enterprises")
              .setFeature(true)
              .setPublishedDate("November 4, 2015")
              .track();

To create and track the most minimal shared content event ::

    MediaEvent.createSharedEvent().track();

To create and track a shared content event with optional facebook source and social medium ::

    MediaEvent.createSharedEvent("facebook", "social").track();

To create and track a shared content event with optional properties ::

    MediaEvent.createSharedEvent("facebook", "social")
              .setCategory("entertainment")
              .setId("12345")
              .setDescription("Watching latest entertainment news.")
              .setType("video")
              .setAuthor("UA Enterprises")
              .setFeature(true)
              .setPublishedDate("November 4, 2015")
              .track();

RetailEvent
###########

This custom event is for retail related events, such as a user browsing a product,
adding an item to a cart, purchasing an item, starring a product as their favorite
or sharing a product.

To create and track the most minimal purchased event ::

    RetailEvent.createPurchasedEvent().track();

To create and track a purchased event with optional properties ::

    RetailEvent.createPurchasedEvent()
               .setCategory("mens shoes")
               .setId("12345")
               .setDescription("Low top")
               .setValue(99.99)
               .setTransactionId("13579")
               .setBrand("SpecialBrand")
               .setNewItem(true)
               .track();

To create and track the most minimal browsed event ::

    RetailEvent.createBrowsedEvent().track();

To create and track a browsed event with optional properties ::

    RetailEvent.createBrowsedEvent()
               .setCategory("mens shoes")
               .setId("12345")
               .setDescription("Low top")
               .setValue(99.99)
               .setTransactionId("13579")
               .setBrand("SpecialBrand")
               .setNewItem(true)
               .track();

To create and track the most minimal added to cart event ::

    RetailEvent.createAddedToCartEvent().track();

To create and track an added to cart event with optional properties ::

    RetailEvent.createAddedToCartEvent()
               .setCategory("mens shoes")
               .setId("12345")
               .setDescription("Low top")
               .setValue(99.99)
               .setTransactionId("13579")
               .setBrand("SpecialBrand")
               .setNewItem(true)
               .track();

To create and track the most minimal starred product event ::

    RetailEvent.createStarredProduct().track();

To create and track a starred product event with optional properties ::

    RetailEvent.createStarredProduct()
               .setCategory("mens shoes")
               .setId("12345")
               .setDescription("Low top")
               .setValue(99.99)
               .setTransactionId("13579")
               .setBrand("SpecialBrand")
               .setNewItem(true)
               .track();

To create and track the most minimal shared product event ::

    RetailEvent.createSharedProduct().track();

To create and track a shared product event with optional facebook source and social medium ::

    RetailEvent.createSharedProduct("facebook", "social").track();

To create and track a shared product event with optional properties ::

    RetailEvent.createSharedProduct("facebook", "social")
               .setCategory("mens shoes")
               .setId("12345")
               .setDescription("Low top")
               .setValue(99.99)
               .setTransactionId("13579")
               .setBrand("SpecialBrand")
               .setNewItem(true)
               .track();
