/*
 Copyright 2009-2014 Urban Airship Inc. All rights reserved.

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:

 1. Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.

 2. Redistributions in binaryform must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided withthe distribution.

 THIS SOFTWARE IS PROVIDED BY THE URBAN AIRSHIP INC``AS IS'' AND ANY EXPRESS OR
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

#import "GimbalAdapter.h"

#import "UAPush.h"
#import "UAirship.h"
#import "UARegionEvent.h"
#import "UAAnalytics.h"

#define kGimbalAdapterEnabled @"ua-gimbal-adapter-enabled"
#define kGimbalAPIKey @"gimbalApiKey"
#define kSource @"Gimbal"

@interface GimbalAdapter ()

@property (assign) BOOL started;
@property (nonatomic) GMBLPlaceManager *placeManager;

@end

@implementation GimbalAdapter

- (instancetype)init {
    self = [super init];
    if (self) {
        self.placeManager = [[GMBLPlaceManager alloc] init];
        self.placeManager.delegate = self;

        // hide the power alert by default
        if (![[NSUserDefaults standardUserDefaults] valueForKey:@"gmbl_hide_bt_power_alert_view"]) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"gmbl_hide_bt_power_alert_view"];
        }

    }
    return self;
}

- (void)dealloc {
    self.placeManager.delegate = nil;
}

+ (instancetype)shared {
    static dispatch_once_t p = 0;

    __strong static id _sharedObject = nil;

    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });

    return _sharedObject;
}

-(BOOL)isBluetoothPoweredOffAlertEnabled {
    return ![[NSUserDefaults standardUserDefaults] boolForKey:@"gmbl_hide_bt_power_alert_view"];
}

- (void)setBluetoothPoweredOffAlertEnabled:(BOOL) bluetoothPoweredOffAlertEnabled {
    [[NSUserDefaults standardUserDefaults] setBool:!bluetoothPoweredOffAlertEnabled
                                            forKey:@"gmbl_hide_bt_power_alert_view"];
}

- (BOOL)isGimbalAdapterEnabled {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kGimbalAdapterEnabled];
}

- (void)setGimbalAdapterEnabled:(BOOL)gimbalAdapterEnabled {
    [[NSUserDefaults standardUserDefaults] setBool:gimbalAdapterEnabled forKey:kGimbalAdapterEnabled];

    if (gimbalAdapterEnabled) {
        [self startAdapter];
    } else {
        [self stopAdapter];
    }
}

- (void)startAdapter{

    if (self.started) {
        return;
    }

    if (!self.gimbalAdapterEnabled) {
        UA_LDEBUG(@"Unable to start GimbalAdapter: Gimbal places not enabled.");
        return;
    }

    [GMBLPlaceManager startMonitoring];

    self.started = YES;

    UA_LDEBUG(@"Started Gimbal Adapter.");
}

- (void)stopAdapter {

    if (self.started) {

        [GMBLPlaceManager stopMonitoring];
        self.started = NO;

        UA_LDEBUG(@"Stopped Gimbal Adapter.");
    }
}

- (void)reportPlaceEventToAnalytics:(GMBLPlace *) place boundaryEvent:(UABoundaryEvent) boundaryEvent {
    UARegionEvent *regionEvent = [UARegionEvent regionEventWithRegionID:place.identifier source:kSource boundaryEvent:boundaryEvent];

    [[UAirship shared].analytics addEvent:regionEvent];
}

#pragma mark -
#pragma mark Gimbal places callbacks

- (void)placeManager:(GMBLPlaceManager *)manager didEnterPlace:(GMBLPlace *)place date:(NSDate *)date {
    UA_LDEBUG(@"Entered a Gimbal Place: %@ on the following date: %@", place.name, date);

    [self reportPlaceEventToAnalytics:place boundaryEvent:UABoundaryEventEnter];
}

- (void)placeManager:(GMBLPlaceManager *)manager didExitPlace:(GMBLPlace *)place date:(NSDate *)date {
    UA_LDEBUG(@"Exited a Gimbal Place: %@ on the following date: %@", place.name, date);

    [self reportPlaceEventToAnalytics:place boundaryEvent:UABoundaryEventExit];
}

@end
