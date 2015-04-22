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

#import <Foundation/Foundation.h>
#import <WatchKit/WatchKit.h>

@interface UAWatchUtils : NSObject

/**
 * Runs an Urban Airship action.
 *
 * @param actionName The action's name in the UAActionRegistry.
 * @param value The action's value.
 */
+ (void)runActionWithName:(NSString *)actionName value:(id)value;

/**
 * Runs an Urban Airship action with a completion handler.
 *
 * @param actionName The action's name in the UAActionRegistry.
 * @param value The action's value.
 * @param completionHandler The completion handler with the action's result.
 */
+ (void)runActionWithName:(NSString *)actionName
                    value:(id)value
               completion:(void(^)(id value, NSString *errorMessage))completionHandler;

/**
 * Adds tags to the device.
 *
 * @param tags The tags to add.
 */
+ (void)addTags:(NSArray *)tags;

/**
 * Removes tags to the device.
 *
 * @param tags The tags to remove.
 */
+ (void)removeTags:(NSArray *)tags;

/**
 * Adds a custom event to Urban Airship analytics.
 *
 * @param name The event's name.
 * @param value The event's value.
 */
+ (void)addCustomEventWithName:(NSString *)name value:(NSNumber *)value;

/**
 * Adds a custom event to Urban Airship analytics.
 *
 * @param name The event's name.
 */
+ (void)addCustomEventWithName:(NSString *)name;

@end
