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

#import "UAWatchUtils.h"
#import <WatchKit/WatchKit.h>

@implementation UAWatchUtils

+ (void)runActionWithName:(NSString *)actionName value:(id)value {
    NSDictionary *message = @{ @"urbanairship_action": actionName,
                               @"urbanairship_action_value": value };

    [WKInterfaceController openParentApplication:message
                                           reply:^(NSDictionary *replyInfo, NSError *error) {
                                               NSLog(@"Action %@ finished with result %@ error: %@", actionName, replyInfo,error);
                                           }];
}

+ (void)addTags:(NSArray *)tags {
    [UAWatchUtils runActionWithName:@"add_tags_action" value:tags];
}

+ (void)removeTags:(NSArray *)tags {
    [UAWatchUtils runActionWithName:@"remove_tags_action" value:tags];
}

+ (void)addCustomEventWithName:(NSString *)name {
    [UAWatchUtils addCustomEventWithName:name value:nil];
}

+ (void)addCustomEventWithName:(NSString *)name value:(NSNumber *)value {
    NSMutableDictionary *actionValue = [NSMutableDictionary dictionary];
    [actionValue setValue:name forKey:@"event_name"];
    [actionValue setValue:value forKey:@"event_value"];

    [UAWatchUtils runActionWithName:@"add_custom_event_action" value:actionValue];
}

@end
