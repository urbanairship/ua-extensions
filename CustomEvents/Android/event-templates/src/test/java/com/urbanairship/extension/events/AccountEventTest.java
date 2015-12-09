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

package com.urbanairship.extension.events;

import com.urbanairship.UAirship;
import com.urbanairship.UrbanAirshipUtils;
import com.urbanairship.analytics.Analytics;
import com.urbanairship.analytics.CustomEvent;
import com.urbanairship.analytics.EventTestUtils;
import com.urbanairship.extension.BuildConfig;

import org.json.JSONException;
import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;
import org.junit.runner.RunWith;
import org.robolectric.RobolectricGradleTestRunner;
import org.robolectric.annotation.Config;

import java.math.BigDecimal;

import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

@RunWith(RobolectricGradleTestRunner.class)
@Config(sdk = 21, constants = BuildConfig.class)
public class AccountEventTest {

    @Rule
    public ExpectedException exception = ExpectedException.none();

    @Before
    public void setup() {
        UAirship airship = UrbanAirshipUtils.mockAirship();
        Analytics analytics = mock(Analytics.class);
        when(airship.getAnalytics()).thenReturn(analytics);
    }

    /**
     * Test basic AccountEvent with no optional value or properties.
     *
     * @throws JSONException
     */
    @Test
    public void testBasicAccountEvent() throws JSONException {
        CustomEvent event = AccountEvent.createRegisteredEvent().track();

        EventTestUtils.validateEventValue(event, "event_name", AccountEvent.REGISTERED_ACCOUNT_EVENT);
        EventTestUtils.validateNestedEventValue(event, "properties", "ltv", "false");
    }

    /**
     * Test AccountEvent with optional value and properties.
     * @throws JSONException
     */
    @Test
    public void testAccountEvent() throws JSONException {
        CustomEvent event = AccountEvent.createRegisteredEvent()
                                        .setValue(new BigDecimal(123))
                                        .setTransactionId("Wednesday 11/4/2015")
                                        .setCategory("Premium")
                                        .track();

        EventTestUtils.validateEventValue(event, "event_name", AccountEvent.REGISTERED_ACCOUNT_EVENT);
        EventTestUtils.validateEventValue(event, "event_value", 123000000L);
        EventTestUtils.validateEventValue(event, "transaction_id", "Wednesday 11/4/2015");
        EventTestUtils.validateNestedEventValue(event, "properties", "ltv", "true");
        EventTestUtils.validateNestedEventValue(event, "properties", "category", "\"Premium\"");
    }

}
