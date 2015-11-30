/*
 Copyright 2009-2015 Urban Airship Inc. All rights reserved.

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:

 1. Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.

 2. Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.

 THIS SOFTWARE IS PROVIDED BY THE URBAN AIRSHIP INC ``AS IS'' AND ANY EXPRESS OR
 IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
 EVENT SHALL URBAN AIRSHIP INC OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import <XCTest/XCTest.h>
#import "UARetailEvent.h"
#import "UAAnalytics.h"
#import "UAirship.h"
#import <OCMock/OCMock.h>

@interface UARetailEventTest : XCTestCase
@property (nonatomic, strong) id analytics;
@property (nonatomic, strong) id airship;
@end

@implementation UARetailEventTest

- (void)setUp {
    self.analytics = [OCMockObject niceMockForClass:[UAAnalytics class]];
    self.airship = [OCMockObject mockForClass:[UAirship class]];
    [[[self.airship stub] andReturn:self.airship] shared];
    [[[self.airship stub] andReturn:self.analytics] analytics];

    [super setUp];
}

- (void)tearDown {
    [self.airship stopMocking];
    [self.analytics stopMocking];

    [super tearDown];
}

/**
 * Test basic browsed event.
 */
- (void)testBasicBrowsedEvent {
    UARetailEvent *event = [UARetailEvent browsedEvent];
    UACustomEvent *customEvent = [event track];

    XCTAssertEqualObjects(@"browsed", [customEvent.data objectForKey:@"event_name"], @"Unexpected event name.");
    XCTAssertEqualObjects(@"false", customEvent.data[@"properties"][@"ltv"], @"Unexpected ltv property.");
}

/**
 * Test browsed event with value.
 */
- (void)testBrowsedEventWithValue {
    UARetailEvent *event = [UARetailEvent browsedEventWithValue:@(INT32_MIN)];
    UACustomEvent *customEvent = [event track];

    XCTAssertEqualObjects(@"browsed", [customEvent.data objectForKey:@"event_name"], @"Unexpected event name.");
    XCTAssertEqualObjects(@(INT32_MIN * 1000000.0), [customEvent.data objectForKey:@"event_value"], @"Unexpected event value.");
    XCTAssertEqualObjects(@"true", customEvent.data[@"properties"][@"ltv"], @"Unexpected ltv property.");
}

/**
 * Test browsed event with value from string and properties.
 */
- (void)testBrowsedEventWithValueStringProperties {
    UARetailEvent *event = [UARetailEvent browsedEventWithValueFromString:@"100.00"];
    event.category = @"retail-category";
    event.identifier = @"12345";
    event.eventDescription = @"Browsed retail event.";
    event.transactionID = @"1122334455";
    event.brand = @"Urban Airship";
    event.isNewItem = YES;
    UACustomEvent *customEvent = [event track];

    XCTAssertEqualObjects(@"browsed", [customEvent.data objectForKey:@"event_name"], @"Unexpected event name.");
    XCTAssertEqualObjects(@(100.00), customEvent.eventValue, @"Event value should be set from a valid numeric string.");
    XCTAssertEqualObjects(@"true", customEvent.data[@"properties"][@"ltv"], @"Unexpected ltv property.");
    XCTAssertEqualObjects(@"1122334455", customEvent.transactionID, @"Unexpected transaction ID.");
    XCTAssertEqualObjects(@"\"retail-category\"", customEvent.data[@"properties"][@"category"], @"Unexpected category.");
    XCTAssertEqualObjects(@"\"12345\"", customEvent.data[@"properties"][@"id"], @"Unexpected ID.");
    XCTAssertEqualObjects(@"\"Browsed retail event.\"", customEvent.data[@"properties"][@"description"], @"Unexpected description.");
    XCTAssertEqualObjects(@"\"Urban Airship\"", customEvent.data[@"properties"][@"brand"], @"Unexpected category.");
    XCTAssertEqualObjects(@"true", customEvent.data[@"properties"][@"new_item"], @"Unexpected new item value.");
}

/**
 * Test added to cart event.
 */
- (void)testAddedToCartEvent {
    UARetailEvent *event = [UARetailEvent addedToCartEvent];
    UACustomEvent *customEvent = [event track];

    XCTAssertEqualObjects(@"added_to_cart", [customEvent.data objectForKey:@"event_name"], @"Unexpected event name.");
    XCTAssertEqualObjects(@"false", customEvent.data[@"properties"][@"ltv"], @"Unexpected ltv property.");
}

/**
 * Test added to cart event with value.
 */
- (void)testAddedToCartEventWithValue {
    UARetailEvent *event = [UARetailEvent addedToCartEventWithValue:@(INT32_MIN)];
    UACustomEvent *customEvent = [event track];

    XCTAssertEqualObjects(@"added_to_cart", [customEvent.data objectForKey:@"event_name"], @"Unexpected event name.");
    XCTAssertEqualObjects(@(INT32_MIN * 1000000.0), [customEvent.data objectForKey:@"event_value"], @"Unexpected event value.");
    XCTAssertEqualObjects(@"true", customEvent.data[@"properties"][@"ltv"], @"Unexpected ltv property.");
}

/**
 * Test added to cart event with value from string and properties.
 */
- (void)testAddedToCartEventWithValueStringProperties {
    UARetailEvent *event = [UARetailEvent addedToCartEventWithValueFromString:@"100.00"];
    event.category = @"retail-category";
    event.identifier = @"12345";
    event.eventDescription = @"Added to cart retail event.";
    event.transactionID = @"1122334455";
    event.brand = @"Urban Airship";
    event.isNewItem = YES;
    UACustomEvent *customEvent = [event track];

    XCTAssertEqualObjects(@"added_to_cart", [customEvent.data objectForKey:@"event_name"], @"Unexpected event name.");
    XCTAssertEqualObjects(@(100.00), customEvent.eventValue, @"Event value should be set from a valid numeric string.");
    XCTAssertEqualObjects(@"true", customEvent.data[@"properties"][@"ltv"], @"Unexpected ltv property.");
    XCTAssertEqualObjects(@"1122334455", customEvent.transactionID, @"Unexpected transaction ID.");
    XCTAssertEqualObjects(@"\"retail-category\"", customEvent.data[@"properties"][@"category"], @"Unexpected category.");
    XCTAssertEqualObjects(@"\"12345\"", customEvent.data[@"properties"][@"id"], @"Unexpected ID.");
    XCTAssertEqualObjects(@"\"Added to cart retail event.\"", customEvent.data[@"properties"][@"description"], @"Unexpected description.");
    XCTAssertEqualObjects(@"\"Urban Airship\"", customEvent.data[@"properties"][@"brand"], @"Unexpected category.");
    XCTAssertEqualObjects(@"true", customEvent.data[@"properties"][@"new_item"], @"Unexpected new item value.");
}

/**
 * Test starred product event.
 */
- (void)testStarredProductEvent {
    UARetailEvent *event = [UARetailEvent starredProductEvent];
    UACustomEvent *customEvent = [event track];

    XCTAssertEqualObjects(@"starred_product", [customEvent.data objectForKey:@"event_name"], @"Unexpected event name.");
    XCTAssertEqualObjects(@"false", customEvent.data[@"properties"][@"ltv"], @"Unexpected ltv property.");
}

/**
 * Test starred product event with value.
 */
- (void)testStarredProductEventWithValue {
    UARetailEvent *event = [UARetailEvent starredProductEventWithValue:@(INT32_MIN)];
    UACustomEvent *customEvent = [event track];

    XCTAssertEqualObjects(@"starred_product", [customEvent.data objectForKey:@"event_name"], @"Unexpected event name.");
    XCTAssertEqualObjects(@(INT32_MIN * 1000000.0), [customEvent.data objectForKey:@"event_value"], @"Unexpected event value.");
    XCTAssertEqualObjects(@"true", customEvent.data[@"properties"][@"ltv"], @"Unexpected ltv property.");
}

/**
 * Test starred product event with value from string and properties.
 */
- (void)testStarredProductEventWithValueStringProperties {
    UARetailEvent *event = [UARetailEvent starredProductEventWithValueFromString:@"100.00"];
    event.category = @"retail-category";
    event.identifier = @"12345";
    event.eventDescription = @"Starred product retail event.";
    event.transactionID = @"1122334455";
    event.brand = @"Urban Airship";
    event.isNewItem = YES;
    UACustomEvent *customEvent = [event track];

    XCTAssertEqualObjects(@"starred_product", [customEvent.data objectForKey:@"event_name"], @"Unexpected event name.");
    XCTAssertEqualObjects(@(100.00), customEvent.eventValue, @"Event value should be set from a valid numeric string.");
    XCTAssertEqualObjects(@"true", customEvent.data[@"properties"][@"ltv"], @"Unexpected ltv property.");
    XCTAssertEqualObjects(@"1122334455", customEvent.transactionID, @"Unexpected transaction ID.");
    XCTAssertEqualObjects(@"\"retail-category\"", customEvent.data[@"properties"][@"category"], @"Unexpected category.");
    XCTAssertEqualObjects(@"\"12345\"", customEvent.data[@"properties"][@"id"], @"Unexpected ID.");
    XCTAssertEqualObjects(@"\"Starred product retail event.\"", customEvent.data[@"properties"][@"description"], @"Unexpected description.");
    XCTAssertEqualObjects(@"\"Urban Airship\"", customEvent.data[@"properties"][@"brand"], @"Unexpected category.");
    XCTAssertEqualObjects(@"true", customEvent.data[@"properties"][@"new_item"], @"Unexpected new item value.");
}

/**
 * Test purchased event.
 */
- (void)testPurchasedEvent {
    UARetailEvent *event = [UARetailEvent purchasedEvent];
    UACustomEvent *customEvent = [event track];

    XCTAssertEqualObjects(@"purchased", [customEvent.data objectForKey:@"event_name"], @"Unexpected event name.");
    XCTAssertEqualObjects(@"false", customEvent.data[@"properties"][@"ltv"], @"Unexpected ltv property.");
}

/**
 * Test purchased event with value.
 */
- (void)testPurchasedEventWithValue {
    UARetailEvent *event = [UARetailEvent purchasedEventWithValue:@(INT32_MIN)];
    UACustomEvent *customEvent = [event track];

    XCTAssertEqualObjects(@"purchased", [customEvent.data objectForKey:@"event_name"], @"Unexpected event name.");
    XCTAssertEqualObjects(@(INT32_MIN * 1000000.0), [customEvent.data objectForKey:@"event_value"], @"Unexpected event value.");
    XCTAssertEqualObjects(@"true", customEvent.data[@"properties"][@"ltv"], @"Unexpected ltv property.");
}

/**
 * Test purchased event with value from string and properties.
 */
- (void)testPurchasedEventWithValueStringProperties {
    UARetailEvent *event = [UARetailEvent purchasedEventWithValueFromString:@"100.00"];
    event.category = @"retail-category";
    event.identifier = @"12345";
    event.eventDescription = @"Purchased retail event.";
    event.transactionID = @"1122334455";
    event.brand = @"Urban Airship";
    event.isNewItem = YES;
    UACustomEvent *customEvent = [event track];

    XCTAssertEqualObjects(@"purchased", [customEvent.data objectForKey:@"event_name"], @"Unexpected event name.");
    XCTAssertEqualObjects(@(100.00), customEvent.eventValue, @"Event value should be set from a valid numeric string.");
    XCTAssertEqualObjects(@"true", customEvent.data[@"properties"][@"ltv"], @"Unexpected ltv property.");
    XCTAssertEqualObjects(@"1122334455", customEvent.transactionID, @"Unexpected transaction ID.");
    XCTAssertEqualObjects(@"\"retail-category\"", customEvent.data[@"properties"][@"category"], @"Unexpected category.");
    XCTAssertEqualObjects(@"\"12345\"", customEvent.data[@"properties"][@"id"], @"Unexpected ID.");
    XCTAssertEqualObjects(@"\"Purchased retail event.\"", customEvent.data[@"properties"][@"description"], @"Unexpected description.");
    XCTAssertEqualObjects(@"\"Urban Airship\"", customEvent.data[@"properties"][@"brand"], @"Unexpected category.");
    XCTAssertEqualObjects(@"true", customEvent.data[@"properties"][@"new_item"], @"Unexpected new item value.");
}

/**
 * Test shared product event.
 */
- (void)testSharedProductEvent {
    UARetailEvent *event = [UARetailEvent sharedProductEvent];
    UACustomEvent *customEvent = [event track];

    XCTAssertEqualObjects(@"shared_product", [customEvent.data objectForKey:@"event_name"], @"Unexpected event name.");
    XCTAssertEqualObjects(@"false", customEvent.data[@"properties"][@"ltv"], @"Unexpected ltv property.");
}

/**
 * Test shared product event with value.
 */
- (void)testSharedProductEventWithValue {
    UARetailEvent *event = [UARetailEvent sharedProductEventWithValue:@(INT32_MIN)];
    UACustomEvent *customEvent = [event track];

    XCTAssertEqualObjects(@"shared_product", [customEvent.data objectForKey:@"event_name"], @"Unexpected event name.");
    XCTAssertEqualObjects(@(INT32_MIN * 1000000.0), [customEvent.data objectForKey:@"event_value"], @"Unexpected event value.");
    XCTAssertEqualObjects(@"true", customEvent.data[@"properties"][@"ltv"], @"Unexpected ltv property.");
}

/**
 * Test shared product event with value from string and properties.
 */
- (void)testSharedProductEventWithValueStringProperties {
    UARetailEvent *event = [UARetailEvent sharedProductEventWithValueFromString:@"100.00"];
    event.category = @"retail-category";
    event.identifier = @"12345";
    event.eventDescription = @"Shared product retail event.";
    event.transactionID = @"1122334455";
    event.brand = @"Urban Airship";
    event.isNewItem = YES;
    UACustomEvent *customEvent = [event track];

    XCTAssertEqualObjects(@"shared_product", [customEvent.data objectForKey:@"event_name"], @"Unexpected event name.");
    XCTAssertEqualObjects(@(100.00), customEvent.eventValue, @"Event value should be set from a valid numeric string.");
    XCTAssertEqualObjects(@"true", customEvent.data[@"properties"][@"ltv"], @"Unexpected ltv property.");
    XCTAssertEqualObjects(@"1122334455", customEvent.transactionID, @"Unexpected transaction ID.");
    XCTAssertEqualObjects(@"\"retail-category\"", customEvent.data[@"properties"][@"category"], @"Unexpected category.");
    XCTAssertEqualObjects(@"\"12345\"", customEvent.data[@"properties"][@"id"], @"Unexpected ID.");
    XCTAssertEqualObjects(@"\"Shared product retail event.\"", customEvent.data[@"properties"][@"description"], @"Unexpected description.");
    XCTAssertEqualObjects(@"\"Urban Airship\"", customEvent.data[@"properties"][@"brand"], @"Unexpected category.");
    XCTAssertEqualObjects(@"true", customEvent.data[@"properties"][@"new_item"], @"Unexpected new item value.");
}

/**
 * Test shared product event with source and medium.
 */
- (void)testSharedProductEventSourceMedium {
    UARetailEvent *event = [UARetailEvent sharedProductEventWithSource:@"facebook" withMedium:@"social"];
    UACustomEvent *customEvent = [event track];

    XCTAssertEqualObjects(@"shared_product", [customEvent.data objectForKey:@"event_name"], @"Unexpected event name.");
    XCTAssertEqualObjects(@"false", customEvent.data[@"properties"][@"ltv"], @"Unexpected ltv property.");
    XCTAssertEqualObjects(@"\"facebook\"", customEvent.data[@"properties"][@"source"], @"Unexpected source.");
    XCTAssertEqualObjects(@"\"social\"", customEvent.data[@"properties"][@"medium"], @"Unexpected medium.");
}

/**
 * Test shared product event with value, source and medium.
 */
- (void)testSharedProductEventWithValueSourceMedium {
    UARetailEvent *event = [UARetailEvent sharedProductEventWithValue:@(INT32_MIN) withSource:@"facebook" withMedium:@"social"];
    UACustomEvent *customEvent = [event track];

    XCTAssertEqualObjects(@"shared_product", [customEvent.data objectForKey:@"event_name"], @"Unexpected event name.");
    XCTAssertEqualObjects(@(INT32_MIN * 1000000.0), [customEvent.data objectForKey:@"event_value"], @"Unexpected event value.");
    XCTAssertEqualObjects(@"true", customEvent.data[@"properties"][@"ltv"], @"Unexpected ltv property.");
    XCTAssertEqualObjects(@"\"facebook\"", customEvent.data[@"properties"][@"source"], @"Unexpected source.");
    XCTAssertEqualObjects(@"\"social\"", customEvent.data[@"properties"][@"medium"], @"Unexpected medium.");
}

/**
 * Test shared product event with value from string, source and medium.
 */
- (void)testSharedProductEventWithValueStringPropertiesSourceMedium {
    UARetailEvent *event = [UARetailEvent sharedProductEventWithValueFromString:@"100.00" withSource:@"facebook" withMedium:@"social"];
    event.category = @"retail-category";
    event.identifier = @"12345";
    event.eventDescription = @"Shared product retail event.";
    event.transactionID = @"1122334455";
    event.brand = @"Urban Airship";
    event.isNewItem = YES;
    UACustomEvent *customEvent = [event track];

    XCTAssertEqualObjects(@"shared_product", [customEvent.data objectForKey:@"event_name"], @"Unexpected event name.");
    XCTAssertEqualObjects(@(100.00), customEvent.eventValue, @"Event value should be set from a valid numeric string.");
    XCTAssertEqualObjects(@"true", customEvent.data[@"properties"][@"ltv"], @"Unexpected ltv property.");
    XCTAssertEqualObjects(@"1122334455", customEvent.transactionID, @"Unexpected transaction ID.");
    XCTAssertEqualObjects(@"\"facebook\"", customEvent.data[@"properties"][@"source"], @"Unexpected source.");
    XCTAssertEqualObjects(@"\"social\"", customEvent.data[@"properties"][@"medium"], @"Unexpected medium.");
    XCTAssertEqualObjects(@"\"retail-category\"", customEvent.data[@"properties"][@"category"], @"Unexpected category.");
    XCTAssertEqualObjects(@"\"12345\"", customEvent.data[@"properties"][@"id"], @"Unexpected ID.");
    XCTAssertEqualObjects(@"\"Shared product retail event.\"", customEvent.data[@"properties"][@"description"], @"Unexpected description.");
    XCTAssertEqualObjects(@"\"Urban Airship\"", customEvent.data[@"properties"][@"brand"], @"Unexpected category.");
    XCTAssertEqualObjects(@"true", customEvent.data[@"properties"][@"new_item"], @"Unexpected new item value.");
}

@end
