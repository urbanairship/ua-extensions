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

#import "UAMediaEvent.h"
#import "AirshipKit/AirshipLib.h"

#define kUABrowsedContentEvent @"browsed_content"
#define kUAConsumedContentEvent @"consumed_content"
#define kUAStarredContentEvent @"starred_content"
#define kUASharedContentEvent @"shared_content"
#define kUAMediaEventLifetimeValue @"ltv"
#define kUAMediaEventIdentifier @"id"
#define kUAMediaEventCategory @"category"
#define kUAMediaEventDescription @"description"
#define kUAMediaEventType @"type"
#define kUAMediaEventFeature @"feature"
#define kUAMediaEventAuthor @"author"
#define kUAMediaEventPublishedDate @"published_date"
#define kUAMediaEventSource @"source"
#define kUAMediaEventMedium @"medium"

@interface UAMediaEvent()
@property (nonatomic, copy) NSString *eventName;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *medium;
@property (nonatomic, strong) NSDecimalNumber *eventValue;
@property (nonatomic, assign) BOOL featureSet;
@end

@implementation UAMediaEvent

- (instancetype)initWithName:(NSString *)name
                   withValue:(NSDecimalNumber *)eventValue
                  withSource:(NSString *)source
                  withMedium:(NSString *)medium {
    self = [super init];
    if (self) {
        self.eventName = name;
        self.eventValue = eventValue;
        self.source = source;
        self.medium = medium;
    }

    return self;
}

+ (instancetype)browsedEvent {
    return [[self alloc] initWithName:kUABrowsedContentEvent
                            withValue:nil
                           withSource:nil
                           withMedium:nil];
}

+ (instancetype)starredEvent {
    return [[self alloc] initWithName:kUAStarredContentEvent
                            withValue:nil
                           withSource:nil
                           withMedium:nil];
}

+ (instancetype)sharedEventWithSource:(NSString *)source
                                  withMedium:(NSString *)medium {
    return [[self alloc] initWithName:kUASharedContentEvent
                            withValue:nil
                           withSource:source
                           withMedium:medium];
}

+ (instancetype)sharedEvent {
    return [self sharedEventWithSource:nil withMedium:nil];
}

+ (instancetype)consumedEvent {
    return [self consumedEventWithValue:nil];
}

+ (instancetype)consumedEventWithValueFromString:(NSString *)eventValue {
    NSDecimalNumber *decimalValue = eventValue ? [NSDecimalNumber decimalNumberWithString:eventValue] : nil;
    return [self consumedEventWithValue:decimalValue];
}

+ (instancetype)consumedEventWithValue:(NSDecimalNumber *)eventValue {
    return [[self alloc] initWithName:kUAConsumedContentEvent
                            withValue:eventValue
                           withSource:nil
                           withMedium:nil];
}

- (void)setIsFeature:(BOOL)isFeature {
    self.featureSet = YES;
    _isFeature = isFeature;
}

- (UACustomEvent *)track {
    UACustomEvent *event = [UACustomEvent eventWithName:self.eventName];

    if (self.eventValue) {
        [event setEventValue:self.eventValue];
        [event setBoolProperty:YES forKey:kUAMediaEventLifetimeValue];
    } else {
        [event setBoolProperty:NO forKey:kUAMediaEventLifetimeValue];
    }

    if (self.identifier) {
        [event setStringProperty:self.identifier forKey:kUAMediaEventIdentifier];
    }

    if (self.category) {
        [event setStringProperty:self.category forKey:kUAMediaEventCategory];
    }

    if (self.eventDescription) {
        [event setStringProperty:self.eventDescription forKey:kUAMediaEventDescription];
    }

    if (self.type) {
        [event setStringProperty:self.type forKey:kUAMediaEventType];
    }

    if (self.featureSet) {
        [event setBoolProperty:self.isFeature forKey:kUAMediaEventFeature];
    }

    if (self.author) {
        [event setStringProperty:self.author forKey:kUAMediaEventAuthor];
    }

    if (self.publishedDate) {
        [event setStringProperty:self.publishedDate forKey:kUAMediaEventPublishedDate];
    }

    if (self.source) {
        [event setStringProperty:self.source forKey:kUAMediaEventSource];
    }

    if (self.medium) {
        [event setStringProperty:self.medium forKey:kUAMediaEventMedium];
    }

    [[UAirship shared].analytics addEvent:event];

    return event;
}

@end
