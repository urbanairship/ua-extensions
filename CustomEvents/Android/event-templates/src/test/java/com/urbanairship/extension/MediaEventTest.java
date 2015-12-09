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

package com.urbanairship.extension;

import com.urbanairship.UAirship;
import com.urbanairship.UrbanAirshipUtils;
import com.urbanairship.analytics.EventTestUtils;
import com.urbanairship.analytics.Analytics;
import com.urbanairship.analytics.CustomEvent;
import com.urbanairship.extension.events.MediaEvent;

import org.json.JSONException;
import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.runners.MockitoJUnitRunner;
import org.robolectric.RobolectricGradleTestRunner;
import org.robolectric.annotation.Config;

import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

@RunWith(RobolectricGradleTestRunner.class)
@Config(sdk = 21, constants = BuildConfig.class)
public class MediaEventTest {
    @Rule
    public ExpectedException exception = ExpectedException.none();

    @Before
    public void setup() {
        UAirship airship = UrbanAirshipUtils.mockAirship();
        Analytics analytics = mock(Analytics.class);
        when(airship.getAnalytics()).thenReturn(analytics);
    }

    /**
     * Test starred content event.
     *
     * @throws JSONException
     */
    @Test
    public void testStarredContentEventBasic() throws JSONException {
        CustomEvent event = MediaEvent.createStarredContentEvent().track();

        EventTestUtils.validateEventValue(event, "event_name", MediaEvent.STARRED_CONTENT_EVENT);
        EventTestUtils.validateNestedEventValue(event, "properties", "ltv", "false");
    }

    /**
     * Test starred content event with optional properties.
     *
     * @throws JSONException
     */
    @Test
    public void testStarredContentEvent() throws JSONException {
        CustomEvent event = MediaEvent.createStarredContentEvent()
                                      .setCategory("media-category")
                                      .setId("starred-content-ID 1")
                                      .setDescription("This is a starred content media event.")
                                      .setType("audio type")
                                      .setAuthor("The Cool UA")
                                      .setFeature(true)
                                      .setPublishedDate("November 4, 2015")
                                      .track();

        EventTestUtils.validateEventValue(event, "event_name", MediaEvent.STARRED_CONTENT_EVENT);
        EventTestUtils.validateNestedEventValue(event, "properties", "ltv", "false");
        EventTestUtils.validateNestedEventValue(event, "properties", "category", "\"media-category\"");
        EventTestUtils.validateNestedEventValue(event, "properties", "id", "\"starred-content-ID 1\"");
        EventTestUtils.validateNestedEventValue(event, "properties", "description", "\"This is a starred content media event.\"");
        EventTestUtils.validateNestedEventValue(event, "properties", "type", "\"audio type\"");
        EventTestUtils.validateNestedEventValue(event, "properties", "author", "\"The Cool UA\"");
        EventTestUtils.validateNestedEventValue(event, "properties", "feature", true);
        EventTestUtils.validateNestedEventValue(event, "properties", "published_date", "\"November 4, 2015\"");
    }

    /**
     * Test shared content event.
     *
     * @throws JSONException
     */
    @Test
    public void testSharedContentEventBasic() throws JSONException {
        CustomEvent event = MediaEvent.createSharedContentEvent().track();

        EventTestUtils.validateEventValue(event, "event_name", MediaEvent.SHARED_CONTENT_EVENT);
        EventTestUtils.validateNestedEventValue(event, "properties", "ltv", "false");
    }

    /**
     * Test shared content event with optional properties.
     *
     * @throws JSONException
     */
    @Test
    public void testSharedContentEvent() throws JSONException {
        CustomEvent event = MediaEvent.createSharedContentEvent("facebook", "social")
                                      .setCategory("media-category")
                                      .setId("shared-content-ID 2")
                                      .setDescription("This is a shared content media event.")
                                      .setType("video type")
                                      .setAuthor("The Cool UA")
                                      .setFeature(true)
                                      .setPublishedDate("November 4, 2015")
                                      .track();

        EventTestUtils.validateEventValue(event, "event_name", MediaEvent.SHARED_CONTENT_EVENT);
        EventTestUtils.validateNestedEventValue(event, "properties", "ltv", "false");
        EventTestUtils.validateNestedEventValue(event, "properties", "source", "\"facebook\"");
        EventTestUtils.validateNestedEventValue(event, "properties", "medium", "\"social\"");
        EventTestUtils.validateNestedEventValue(event, "properties", "category", "\"media-category\"");
        EventTestUtils.validateNestedEventValue(event, "properties", "id", "\"shared-content-ID 2\"");
        EventTestUtils.validateNestedEventValue(event, "properties", "description", "\"This is a shared content media event.\"");
        EventTestUtils.validateNestedEventValue(event, "properties", "type", "\"video type\"");
        EventTestUtils.validateNestedEventValue(event, "properties", "author", "\"The Cool UA\"");
        EventTestUtils.validateNestedEventValue(event, "properties", "feature", true);
        EventTestUtils.validateNestedEventValue(event, "properties", "published_date", "\"November 4, 2015\"");
    }

    /**
     * Test consumed content event.
     *
     * @throws JSONException
     */
    @Test
    public void testConsumedContentEventBasic() throws JSONException {
        CustomEvent event = MediaEvent.createConsumedContentEvent().track();

        EventTestUtils.validateEventValue(event, "event_name", MediaEvent.CONSUMED_CONTENT_EVENT);
        EventTestUtils.validateNestedEventValue(event, "properties", "ltv", "false");
    }

    /**
     * Test consumed content event with optional properties.
     *
     * @throws JSONException
     */
    @Test
    public void testConsumedContentEvent() throws JSONException {
        CustomEvent event = MediaEvent.createConsumedContentEvent(2.99)
                                      .setCategory("media-category")
                                      .setId("consumed-content-ID 1")
                                      .setDescription("This is a consumed content media event.")
                                      .setType("audio type")
                                      .setAuthor("The Cool UA")
                                      .setFeature(true)
                                      .setPublishedDate("November 4, 2015")
                                      .track();

        EventTestUtils.validateEventValue(event, "event_name", MediaEvent.CONSUMED_CONTENT_EVENT);
        EventTestUtils.validateEventValue(event, "event_value", 2990000.0);
        EventTestUtils.validateNestedEventValue(event, "properties", "ltv", "true");
        EventTestUtils.validateNestedEventValue(event, "properties", "category", "\"media-category\"");
        EventTestUtils.validateNestedEventValue(event, "properties", "id", "\"consumed-content-ID 1\"");
        EventTestUtils.validateNestedEventValue(event, "properties", "description", "\"This is a consumed content media event.\"");
        EventTestUtils.validateNestedEventValue(event, "properties", "type", "\"audio type\"");
        EventTestUtils.validateNestedEventValue(event, "properties", "author", "\"The Cool UA\"");
        EventTestUtils.validateNestedEventValue(event, "properties", "feature", true);
        EventTestUtils.validateNestedEventValue(event, "properties", "published_date", "\"November 4, 2015\"");
    }
}
