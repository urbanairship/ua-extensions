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

import AirshipKit

class GimbalAdapter: NSObject, GMBLPlaceManagerDelegate {

    // Set up the Gimbal Adapter singleton
    static let shared = GimbalAdapter()
    
    var started: Bool
    let placeManager: GMBLPlaceManager
    
    let source: String = "Gimbal"
    
    override init() {
        started = false
        placeManager = GMBLPlaceManager()
        
        // Hide the BLE power status alert to prevent duplicate alerts
        if (NSUserDefaults.standardUserDefaults().valueForKey("gmbl_hide_bt_power_alert_view") == nil) {
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "gmbl_hide_bt_power_alert_view")
        }
    }
    
    func startAdapter () {
    
        if (started) {
            return
        }
        
        //Set place manager delegate to self
        placeManager.delegate = self
        
        GMBLPlaceManager.startMonitoring()

        print("Started Gimbal Adapter");
        
    }
    
    func stopAdapter () {
        
        if (started) {
            GMBLPlaceManager.stopMonitoring()
            started = false
            
            print("Stopped Gimbal Adapter");
        }
        
    }
    
    func reportPlaceToAnalytics (place: GMBLPlace, boundaryEvent: UABoundaryEvent) {
        let regionEvent: UARegionEvent = UARegionEvent(regionID: place.identifier, source: source, boundaryEvent: boundaryEvent)!
        
        UAirship.shared().analytics.addEvent(regionEvent)
    }
    
    func setBluetoothPoweredOffAlertEnabled (bluetoothPoweredOffAlertEnabled: Bool) {
        NSUserDefaults.standardUserDefaults().setBool(!bluetoothPoweredOffAlertEnabled, forKey: "gmbl_hide_bt_power_alert_view");
    }
    
    func placeManager(manager: GMBLPlaceManager, didBeginVisit visit: GMBLVisit) {
        reportPlaceToAnalytics(visit.place, boundaryEvent: UABoundaryEvent.Enter)
    }
    
    func placeManager(manager: GMBLPlaceManager, didEndVisit visit: GMBLVisit) {
        reportPlaceToAnalytics(visit.place, boundaryEvent: UABoundaryEvent.Exit)
    }
    
}
