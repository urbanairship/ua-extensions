package com.urbanairship;

import android.app.Application;

import com.urbanairship.analytics.Analytics;

import org.mockito.Mockito;


import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

public class UrbanAirshipUtils {

    public static UAirship mockAirship() {
        Application application = mock(Application.class, Mockito.RETURNS_DEEP_STUBS);
        when(application.getApplicationContext()).thenReturn(application);
        when(application.getPackageName()).thenReturn("test");


        UAirship.application = application;
        UAirship.isFlying = true;
        UAirship.isTakingOff = false;
        UAirship.sharedAirship = mock(UAirship.class, Mockito.RETURNS_MOCKS);

        return  UAirship.sharedAirship;
    }
}
