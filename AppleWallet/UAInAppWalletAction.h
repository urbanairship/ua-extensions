/* Copyright 2017 Urban Airship and Contributors */

#import <AirshipKit/AirshipKit.h>
#import <Passkit/Passkit.h>

/**
 * Downloads and displays a Passbook Pass in an 'Add Pass' alert dialog. It will download and cache a
 * pass if a background push is received.
 *
 * This action is registered under the names "wallet_action" and "^w".
 *
 * Expected argument value is an NSString.
 *
 * Valid situations: UASituationForegroundPush, UASituationLaunchedFromPush,
 * UASituationWebViewInvocation, UASituationManualInvocation,
 * and UASituationForegroundInteractiveButton
 *
 * Result value: nil
 *
 */
@interface UAInAppWalletAction : UAAction

@end

