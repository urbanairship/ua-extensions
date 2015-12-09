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
#import "UAMediaEvent.h"
#import "AirshipKit/UAAnalytics.h"
#import "AirshipKit/UAirship.h"
#import <OCMock/OCMock.h>

@interface UAMediaEventTest : XCTestCase
@property (nonatomic, strong) id analytics;
@property (nonatomic, strong) id airship;
@end

@implementation UAMediaEventTest

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
 * Test basic browsedContentEvent.
 */
- (void)testBasicBrowsedContentEvent {
    UAMediaEvent *event = [UAMediaEvent browsedContentEvent];
    UACustomEvent *customEvent = [event track];

    XCTAssertEqualObjects(@"browsed_content", [customEvent.data objectForKey:@"event_name"], @"Unexpected event name.");
    XCTAssertEqualObjects(@"false", customEvent.data[@"properties"][@"ltv"], @"Property ltv should be NO.");
}

/**
 * Test browsedContentEvent with optional properties.
 */
- (void)testBrowsedContentEventWithProperties {
    UAMediaEvent *event = [UAMediaEvent browsedContentEvent];
    event.category = @"media-category";
    event.identifier = @"1234";
    event.eventDescription = @"Browsed content media event.";
    event.type = @"audio type";
    event.author = @"The Cool UA";
    event.isFeature = YES;
    event.publishedDate = @"November 13, 2015";

    UACustomEvent *customEvent = [event track];

    XCTAssertEqualObjects(@"browsed_content", [customEvent.data objectForKey:@"event_name"], @"Unexpected event name.");
    XCTAssertEqualObjects(@"false", customEvent.data[@"properties"][@"ltv"], @"Property ltv should be NO.");
    XCTAssertEqualObjects(@"\"media-category\"", customEvent.data[@"properties"][@"category"], @"Unexpected category.");
    XCTAssertEqualObjects(@"\"1234\"", customEvent.data[@"properties"][@"id"], @"Unexpected ID.");
    XCTAssertEqualObjects(@"\"Browsed content media event.\"", customEvent.data[@"properties"][@"description"], @"Unexpected description.");
    XCTAssertEqualObjects(@"\"audio type\"", customEvent.data[@"properties"][@"type"], @"Unexpected type.");
    XCTAssertEqualObjects(@"\"The Cool UA\"", customEvent.data[@"properties"][@"author"], @"Unexpected author.");
    XCTAssertEqualObjects(@"true", customEvent.data[@"properties"][@"feature"], @"Unexpected feature.");
    XCTAssertEqualObjects(@"\"November 13, 2015\"", customEvent.data[@"properties"][@"published_date"], @"Unexpected published date.");
}

/**
 * Test basic starredContentEvent.
 */
- (void)testBasicStarredContentEvent {
    UAMediaEvent *event = [UAMediaEvent starredContentEvent];
    UACustomEvent *customEvent = [event track];

    XCTAssertEqualObjects(@"starred_content", [customEvent.data objectForKey:@"event_name"], @"Unexpected event name.");
    XCTAssertEqualObjects(@"false", customEvent.data[@"properties"][@"ltv"], @"Property ltv should be NO.");
}

/**
 * Test starredContentEvent with optional properties.
 */
- (void)testStarredContentEventWithProperties {
    UAMediaEvent *event = [UAMediaEvent starredContentEvent];
    event.category = @"media-category";
    event.identifier = @"1234";
    event.eventDescription = @"Starred content media event.";
    event.type = @"audio type";
    event.author = @"The Cool UA";
    event.isFeature = YES;
    event.publishedDate = @"November 13, 2015";

    UACustomEvent *customEvent = [event track];

    XCTAssertEqualObjects(@"starred_content", [customEvent.data objectForKey:@"event_name"], @"Unexpected event name.");
    XCTAssertEqualObjects(@"false", customEvent.data[@"properties"][@"ltv"], @"Property ltv should be NO.");
    XCTAssertEqualObjects(@"\"media-category\"", customEvent.data[@"properties"][@"category"], @"Unexpected category.");
    XCTAssertEqualObjects(@"\"1234\"", customEvent.data[@"properties"][@"id"], @"Unexpected ID.");
    XCTAssertEqualObjects(@"\"Starred content media event.\"", customEvent.data[@"properties"][@"description"], @"Unexpected description.");
    XCTAssertEqualObjects(@"\"audio type\"", customEvent.data[@"properties"][@"type"], @"Unexpected type.");
    XCTAssertEqualObjects(@"\"The Cool UA\"", customEvent.data[@"properties"][@"author"], @"Unexpected author.");
    XCTAssertEqualObjects(@"true", customEvent.data[@"properties"][@"feature"], @"Unexpected feature.");
    XCTAssertEqualObjects(@"\"November 13, 2015\"", customEvent.data[@"properties"][@"published_date"], @"Unexpected published date.");
}

/**
 * Test basic sharedContentEvent.
 */
- (void)testBasicSharedContentEvent {
    UAMediaEvent *event = [UAMediaEvent sharedContentEvent];
    UACustomEvent *customEvent = [event track];

    XCTAssertEqualObjects(@"shared_content", [customEvent.data objectForKey:@"event_name"], @"Unexpected event name.");
    XCTAssertEqualObjects(@"false", customEvent.data[@"properties"][@"ltv"], @"Property ltv should be NO.");
}

/**
 * Test sharedContentEvent with optional properties.
 */
- (void)testSharedContentEvent {
    UAMediaEvent *event = [UAMediaEvent sharedContentEventWithSource:@"facebook" withMedium:@"social"];
    event.category = @"media-category";
    event.identifier = @"12345";
    event.eventDescription = @"Shared content media event.";
    event.type = @"video type";
    event.author = @"The Fun UA";
    event.isFeature = YES;
    event.publishedDate = @"November 13, 2015";
    UACustomEvent *customEvent = [event track];

    XCTAssertEqualObjects(@"shared_content", [customEvent.data objectForKey:@"event_name"], @"Unexpected event name.");
    XCTAssertEqualObjects(@"false", customEvent.data[@"properties"][@"ltv"], @"Property ltv should be NO.");
    XCTAssertEqualObjects(@"\"facebook\"", customEvent.data[@"properties"][@"source"], @"Unexpected source.");
    XCTAssertEqualObjects(@"\"social\"", customEvent.data[@"properties"][@"medium"], @"Unexpected medium.");
    XCTAssertEqualObjects(@"\"media-category\"", customEvent.data[@"properties"][@"category"], @"Unexpected category.");
    XCTAssertEqualObjects(@"\"12345\"", customEvent.data[@"properties"][@"id"], @"Unexpected ID.");
    XCTAssertEqualObjects(@"\"Shared content media event.\"", customEvent.data[@"properties"][@"description"], @"Unexpected description.");
    XCTAssertEqualObjects(@"\"video type\"", customEvent.data[@"properties"][@"type"], @"Unexpected type.");
    XCTAssertEqualObjects(@"\"The Fun UA\"", customEvent.data[@"properties"][@"author"], @"Unexpected author.");
    XCTAssertEqualObjects(@"true", customEvent.data[@"properties"][@"feature"], @"Unexpected feature.");
    XCTAssertEqualObjects(@"\"November 13, 2015\"", customEvent.data[@"properties"][@"published_date"], @"Unexpected published date.");
}

/**
 * Test basic consumedContentEvent.
 */
- (void)testBasicConsumedContentEvent {
    UAMediaEvent *event = [UAMediaEvent consumedContentEvent];
    UACustomEvent *customEvent = [event track];

    XCTAssertEqualObjects(@"consumed_content", [customEvent.data objectForKey:@"event_name"], @"Unexpected event name.");
    XCTAssertEqualObjects(@"false", customEvent.data[@"properties"][@"ltv"], @"Property ltv should be NO.");
}

/**
 * Test consumedContentEvent with optional value from string.
 */
- (void)testConsumedContentEventWithValueFromString {
    UAMediaEvent *event = [UAMediaEvent consumedContentEventWithValueFromString:@"100.00"];
    UACustomEvent *customEvent = [event track];

    XCTAssertEqualObjects(@"consumed_content", [customEvent.data objectForKey:@"event_name"], @"Unexpected event name.");
    XCTAssertEqualObjects(@(100.00), customEvent.eventValue, @"Event value should be set from a valid numeric string.");
    XCTAssertEqualObjects(@"true", customEvent.data[@"properties"][@"ltv"], @"Unexpected ltv property.");
}

/**
 * Test consumedContentEvent with optional value and properties.
 */
- (void)testConsumedContentEventWithValueProperties {
    UAMediaEvent *event = [UAMediaEvent consumedContentEventWithValue:@(INT32_MIN)];
    event.category = @"media-category";
    event.identifier = @"12322";
    event.eventDescription = @"Consumed content media event.";
    event.type = @"audio type";
    event.author = @"The Smart UA";
    event.isFeature = YES;
    event.publishedDate = @"November 13, 2015";
    UACustomEvent *customEvent = [event track];

    XCTAssertEqualObjects(@"consumed_content", [customEvent.data objectForKey:@"event_name"], @"Unexpected event name.");
    XCTAssertEqualObjects(@(INT32_MIN * 1000000.0), [customEvent.data objectForKey:@"event_value"], @"Unexpected event value.");
    XCTAssertEqualObjects(@"true", customEvent.data[@"properties"][@"ltv"], @"Unexpected ltv property.");
    XCTAssertEqualObjects(@"\"media-category\"", customEvent.data[@"properties"][@"category"], @"Unexpected category.");
    XCTAssertEqualObjects(@"\"12322\"", customEvent.data[@"properties"][@"id"], @"Unexpected ID.");
    XCTAssertEqualObjects(@"\"Consumed content media event.\"", customEvent.data[@"properties"][@"description"], @"Unexpected description.");
    XCTAssertEqualObjects(@"\"audio type\"", customEvent.data[@"properties"][@"type"], @"Unexpected type.");
    XCTAssertEqualObjects(@"\"The Smart UA\"", customEvent.data[@"properties"][@"author"], @"Unexpected author.");
    XCTAssertEqualObjects(@"true", customEvent.data[@"properties"][@"feature"], @"Unexpected feature.");
    XCTAssertEqualObjects(@"\"November 13, 2015\"", customEvent.data[@"properties"][@"published_date"], @"Unexpected properties.");
}

@end
