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

#import "UAWatchAppDelegateUtils.h"
#import "UAActionRunner.h"

@implementation UAWatchAppDelegateUtils

+ (BOOL)handleUrbanAirshipWatchKitExtensionRequest:(NSDictionary *)userInfo reply:(void (^)(NSDictionary *replyInfo))reply {

    if (!userInfo[@"urbanairship_action"]) {
        return NO;
    }

    __block UIBackgroundTaskIdentifier backgroundTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        UA_LTRACE(@"Analytics background task expired.");
        if (backgroundTask != UIBackgroundTaskInvalid) {
            [[UIApplication sharedApplication] endBackgroundTask:backgroundTask];
            backgroundTask = UIBackgroundTaskInvalid;
        }
    }];

    if (backgroundTask == UIBackgroundTaskInvalid) {
        reply(@{@"error": @"unable to create a background task"});
        return YES;
    }

    NSString *actionName = userInfo[@"urbanairship_action"];
    id actionValue = userInfo[@"urbanairship_action_value"];

    [UAActionRunner runActionWithName:actionName
                                value:actionValue
                            situation:UASituationManualInvocation completionHandler:^(UAActionResult *actionResult) {
                                NSMutableDictionary *result = [NSMutableDictionary dictionary];

                                switch (actionResult.status) {
                                    case UAActionStatusActionNotFound:
                                        result[@"error"] = [NSString stringWithFormat:@"action %@ not found", actionName];
                                        break;
                                    case UAActionStatusArgumentsRejected:
                                        result[@"error"] = [NSString stringWithFormat:@"action %@ rejected arguments", actionName];
                                        break;
                                    case UAActionStatusError:
                                        result[@"error"] = [NSString stringWithFormat:@"action %@ error: %@", actionName, actionResult.error.localizedDescription];
                                        break;
                                    case UAActionStatusCompleted:
                                        if (actionResult.value) {
                                            result[@"value"] = actionResult.value;
                                        }
                                        break;
                                }

                                reply(result);
                                [[UIApplication sharedApplication] endBackgroundTask:backgroundTask];
                            }];

    return YES;
}

@end
