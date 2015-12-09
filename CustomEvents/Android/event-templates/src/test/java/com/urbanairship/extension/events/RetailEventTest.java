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
import org.mockito.Mock;
import org.robolectric.RobolectricGradleTestRunner;
import org.robolectric.annotation.Config;

import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

@RunWith(RobolectricGradleTestRunner.class)
@Config(sdk = 21, constants = BuildConfig.class)
public class RetailEventTest {

    @Rule
    public ExpectedException exception = ExpectedException.none();

    @Mock
    Analytics analytics;

    @Before
    public void setup() {
        UAirship airship = UrbanAirshipUtils.mockAirship();
        Analytics analytics = mock(Analytics.class);
        when(airship.getAnalytics()).thenReturn(analytics);
    }

    /**
     * Test browsed event.
     *
     * @throws JSONException
     */
    @Test
    public void testBrowsedEventBasic() throws JSONException {
        CustomEvent event = RetailEvent.createBrowsedEvent().track();

        EventTestUtils.validateEventValue(event, "event_name", RetailEvent.BROWSED_PRODUCT_EVENT);
        EventTestUtils.validateNestedEventValue(event, "properties", "ltv", "false");
    }

    /**
     * Test browsed event with optional properties.
     *
     * @throws JSONException
     */
    @Test
    public void testBrowsedEvent() throws JSONException {
        CustomEvent event = RetailEvent.createBrowsedEvent()
                                       .setCategory("retail-category")
                                       .setId("browsed-ID 1")
                                       .setDescription("This is a browsed retail event.")
                                       .setValue(99.99)
                                       .setTransactionId("123")
                                       .setBrand("nike")
                                       .setNewItem(true)
                                       .track();

        EventTestUtils.validateEventValue(event, "event_name", RetailEvent.BROWSED_PRODUCT_EVENT);
        EventTestUtils.validateEventValue(event, "event_value", 99990000);
        EventTestUtils.validateEventValue(event, "transaction_id", 123);
        EventTestUtils.validateNestedEventValue(event, "properties", "ltv", "true");
        EventTestUtils.validateNestedEventValue(event, "properties", "category", "\"retail-category\"");
        EventTestUtils.validateNestedEventValue(event, "properties", "id", "\"browsed-ID 1\"");
        EventTestUtils.validateNestedEventValue(event, "properties", "description", "\"This is a browsed retail event.\"");
        EventTestUtils.validateNestedEventValue(event, "properties", "brand", "\"nike\"");
        EventTestUtils.validateNestedEventValue(event, "properties", "new_item", true);
    }

    /**
     * Test added to cart event.
     *
     * @throws JSONException
     */
    @Test
    public void testAddedToCartEventBasic() throws JSONException {
        CustomEvent event = RetailEvent.createAddedToCartEvent().track();

        EventTestUtils.validateEventValue(event, "event_name", RetailEvent.ADDED_TO_CART_EVENT);
        EventTestUtils.validateNestedEventValue(event, "properties", "ltv", "false");
    }

    /**
     * Test added to cart event with optional properties.
     *
     * @throws JSONException
     */
    @Test
    public void testAddedToCartEvent() throws JSONException {
        CustomEvent event = RetailEvent.createAddedToCartEvent()
                                       .setCategory("retail-category")
                                       .setId("added-to-cart-ID 1")
                                       .setDescription("This is an added to cart retail event.")
                                       .setValue(1.99)
                                       .setTransactionId("123")
                                       .setBrand("columbia")
                                       .setNewItem(true)
                                       .track();

        EventTestUtils.validateEventValue(event, "event_name", RetailEvent.ADDED_TO_CART_EVENT);
        EventTestUtils.validateEventValue(event, "event_value", 1990000);
        EventTestUtils.validateEventValue(event, "transaction_id", 123);
        EventTestUtils.validateNestedEventValue(event, "properties", "ltv", "true");
        EventTestUtils.validateNestedEventValue(event, "properties", "category", "\"retail-category\"");
        EventTestUtils.validateNestedEventValue(event, "properties", "id", "\"added-to-cart-ID 1\"");
        EventTestUtils.validateNestedEventValue(event, "properties", "description", "\"This is an added to cart retail event.\"");
        EventTestUtils.validateNestedEventValue(event, "properties", "brand", "\"columbia\"");
        EventTestUtils.validateNestedEventValue(event, "properties", "new_item", true);
    }

    /**
     * Test starred event.
     *
     * @throws JSONException
     */
    @Test
    public void testStarredEventBasic() throws JSONException {
        CustomEvent event = RetailEvent.createStarredProduct().track();

        EventTestUtils.validateEventValue(event, "event_name", RetailEvent.STARRED_PRODUCT_EVENT);
        EventTestUtils.validateNestedEventValue(event, "properties", "ltv", "false");
    }

    /**
     * Test starred event with optional properties.
     *
     * @throws JSONException
     */
    @Test
    public void testStarredEvent() throws JSONException {
        CustomEvent event = RetailEvent.createStarredProduct()
                                       .setCategory("retail-category")
                                       .setId("starred-product-ID 1")
                                       .setDescription("This is a starred retail event.")
                                       .setValue(99.99)
                                       .setTransactionId("123")
                                       .setBrand("nike")
                                       .setNewItem(true)
                                       .track();

        EventTestUtils.validateEventValue(event, "event_name", RetailEvent.STARRED_PRODUCT_EVENT);
        EventTestUtils.validateEventValue(event, "event_value", 99990000);
        EventTestUtils.validateEventValue(event, "transaction_id", 123);
        EventTestUtils.validateNestedEventValue(event, "properties", "ltv", "true");
        EventTestUtils.validateNestedEventValue(event, "properties", "category", "\"retail-category\"");
        EventTestUtils.validateNestedEventValue(event, "properties", "id", "\"starred-product-ID 1\"");
        EventTestUtils.validateNestedEventValue(event, "properties", "description", "\"This is a starred retail event.\"");
        EventTestUtils.validateNestedEventValue(event, "properties", "brand", "\"nike\"");
        EventTestUtils.validateNestedEventValue(event, "properties", "new_item", true);
    }

    /**
     * Test shared event.
     *
     * @throws JSONException
     */
    @Test
    public void testSharedEventBasic() throws JSONException {
        CustomEvent event = RetailEvent.createSharedProduct().track();

        EventTestUtils.validateEventValue(event, "event_name", RetailEvent.SHARED_PRODUCT_EVENT);
        EventTestUtils.validateNestedEventValue(event, "properties", "ltv", "false");
    }

    /**
     * Test shared event with optional properties.
     *
     * @throws JSONException
     */
    @Test
    public void testSharedEvent() throws JSONException {
        CustomEvent event = RetailEvent.createSharedProduct("facebook", "social")
                                       .setCategory("retail-category")
                                       .setId("shared-product-ID 1")
                                       .setDescription("This is a shared retail event.")
                                       .setValue(49.99)
                                       .setTransactionId("123")
                                       .setBrand("nike")
                                       .setNewItem(true)
                                       .track();

        EventTestUtils.validateEventValue(event, "event_name", RetailEvent.SHARED_PRODUCT_EVENT);
        EventTestUtils.validateEventValue(event, "event_value", 49990000);
        EventTestUtils.validateEventValue(event, "transaction_id", 123);
        EventTestUtils.validateNestedEventValue(event, "properties", "source", "\"facebook\"");
        EventTestUtils.validateNestedEventValue(event, "properties", "medium", "\"social\"");
        EventTestUtils.validateNestedEventValue(event, "properties", "ltv", "true");
        EventTestUtils.validateNestedEventValue(event, "properties", "category", "\"retail-category\"");
        EventTestUtils.validateNestedEventValue(event, "properties", "id", "\"shared-product-ID 1\"");
        EventTestUtils.validateNestedEventValue(event, "properties", "description", "\"This is a shared retail event.\"");
        EventTestUtils.validateNestedEventValue(event, "properties", "brand", "\"nike\"");
        EventTestUtils.validateNestedEventValue(event, "properties", "new_item", true);
    }

    /**
     * Test purchased event.
     *
     * @throws JSONException
     */
    @Test
    public void testPurchasedEventBasic() throws JSONException {
        CustomEvent event = RetailEvent.createPurchasedEvent().track();

        EventTestUtils.validateEventValue(event, "event_name", RetailEvent.PURCHASED_EVENT);
        EventTestUtils.validateNestedEventValue(event, "properties", "ltv", "false");
    }

    /**
     * Test purchased event with optional properties.
     *
     * @throws JSONException
     */
    @Test
    public void testPurchasedEvent() throws JSONException {
        CustomEvent event = RetailEvent.createPurchasedEvent()
                                       .setCategory("retail-category")
                                       .setId("purchased-product-ID 1")
                                       .setDescription("This is a purchased retail event.")
                                       .setValue(99.99)
                                       .setTransactionId("123")
                                       .setBrand("nike")
                                       .setNewItem(true)
                                       .track();

        EventTestUtils.validateEventValue(event, "event_name", RetailEvent.PURCHASED_EVENT);
        EventTestUtils.validateEventValue(event, "event_value", 99990000);
        EventTestUtils.validateEventValue(event, "transaction_id", 123);
        EventTestUtils.validateNestedEventValue(event, "properties", "ltv", "true");
        EventTestUtils.validateNestedEventValue(event, "properties", "category", "\"retail-category\"");
        EventTestUtils.validateNestedEventValue(event, "properties", "id", "\"purchased-product-ID 1\"");
        EventTestUtils.validateNestedEventValue(event, "properties", "description", "\"This is a purchased retail event.\"");
        EventTestUtils.validateNestedEventValue(event, "properties", "brand", "\"nike\"");
    }
}
