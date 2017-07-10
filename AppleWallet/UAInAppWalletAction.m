/* Copyright 2017 Urban Airship and Contributors */

#import "UAInAppWalletAction.h"
#import "UAGlobal.h"
#import "UAURLProtocol.h"
#import "UAActionRegistry.h"
#import "UAUtils.h"

@interface UAInAppWalletAction ()

/**
 * The pass library.
 */
@property(nonatomic, strong) PKPassLibrary *passLibrary;

@end

@implementation UAInAppWalletAction

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
        default:
            return NO;
    }

    return NO;
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
