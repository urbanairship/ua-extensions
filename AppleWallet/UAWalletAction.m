/*
 Copyright 2009-2016 Urban Airship Inc. All rights reserved.

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:

 1. Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.

 2. Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.

 THIS SOFTWARE IS PROVIDED BY THE URBAN AIRSHIP INC ''AS IS'' AND ANY EXPRESS OR
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

#import "UAWalletAction.h"
#import "UAGlobal.h"
#import "UAURLProtocol.h"
#import "UAActionRegistry.h"
#import "UAUtils.h"

@interface UAWalletAction ()

/**
 * The pass library.
 */
@property(nonatomic, strong) PKPassLibrary *passLibrary;

@end

@implementation UAWalletAction

- (BOOL)acceptsArguments:(UAActionArguments *)arguments {

    // If PassKit is missing, or if pass library isn't available reject all arguments
    if (![PKPass class] || ![PKPassLibrary isPassLibraryAvailable]) {
        UA_LDEBUG(@"Unable to perform wallet action on this device - pass library unavailable.");
        return NO;
    }

    switch (arguments.situation) {
        case UASituationForegroundPush:
        case UASituationLaunchedFromPush:
        case UASituationManualInvocation:
        case UASituationWebViewInvocation:
        case UASituationForegroundInteractiveButton:
            return [arguments.value isKindOfClass:[NSString class]];

        case UASituationBackgroundPush:
        case UASituationBackgroundInteractiveButton:
            return NO;
    }
}

- (void)performWithArguments:(UAActionArguments *)arguments
           completionHandler:(UAActionCompletionHandler)completionHandler {

    NSURL *passURL = [NSURL URLWithString:arguments.value];

    switch (arguments.situation) {

            // Foreground situations
        case UASituationForegroundPush:
        case UASituationLaunchedFromPush:
        case UASituationManualInvocation:
        case UASituationWebViewInvocation:
        case UASituationForegroundInteractiveButton:
            [self displayPass:passURL completionHandler:completionHandler];
            break;

            // Unhandled situations
        case UASituationBackgroundPush:
        case UASituationBackgroundInteractiveButton:
            // Should reject
            completionHandler([UAActionResult emptyResult]);
            break;
    }

}

/**
 * Retrieve a Passbook Pass displays it in the standard 'Add Pass' view controller.
 *
 * @param passURL The PKPass file URL
 * @param completionHandler The standard action completion handler. This must be called or scheduled
 *                          asynchronously from this method.
 *
 */
- (void)displayPass:(NSURL *)passURL completionHandler:(UAActionCompletionHandler)completionHandler {
    NSURLRequest *request = [NSURLRequest requestWithURL:passURL];

    void (^sessionCompletionHandler)(NSData *, NSURLResponse *, NSError *) = ^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            UA_LDEBUG(@"Failed to download a pass error: %@", error);
            completionHandler([UAActionResult resultWithError:error withFetchResult:UAActionFetchResultFailed]);
        }

        UA_LTRACE(@"Pass downloaded successfully url: %@", response.URL);

        NSError *passError = nil;
        PKPass *pass = [[PKPass alloc] initWithData:data error:&passError];

        if (passError) {
            UA_LDEBUG(@"Failed to initialize a pass %@", [passError description]);
            completionHandler([UAActionResult resultWithError:passError withFetchResult:UAActionFetchResultNewData]);
            return;
        }

        if (pass) {
            if ([self.passLibrary containsPass:pass]) {
                UA_LDEBUG(@"Passbook library already contains the pass %@, skipping add", pass.localizedName);
                completionHandler([UAActionResult resultWithValue:nil withFetchResult:UAActionFetchResultNewData]);
                return;
            }

            [self.passLibrary addPasses:@[pass] withCompletionHandler:^ (PKPassLibraryAddPassesStatus status) {
                if (status == PKPassLibraryShouldReviewPasses) {
                    PKAddPassesViewController *passController = [[PKAddPassesViewController alloc] initWithPass:pass];
                    UIViewController *topController = [UAUtils topController];

                    // Present on the top view controller
                    [topController presentViewController:passController animated:YES completion:nil];
                }
            }];
        }

        // Success - report that we have new data
        completionHandler([UAActionResult resultWithValue:nil withFetchResult:UAActionFetchResultNewData]);
        
    };

    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:sessionCompletionHandler];

    [task resume];
}



- (PKPassLibrary *)passLibrary {
    if (!_passLibrary && [PKPassLibrary isPassLibraryAvailable]) {
        _passLibrary = [[PKPassLibrary alloc] init];
    }
    return _passLibrary;
}

@end
