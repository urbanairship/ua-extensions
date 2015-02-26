/*
 * Copyright 2015 Urban Airship and Contributors
 */

package com.urbanairship.goat;

import android.util.Log;

import com.gimbal.android.Place;
import com.gimbal.android.PlaceEventListener;
import com.gimbal.android.PlaceManager;
import com.urbanairship.UAirship;
import com.urbanairship.analytics.RegionEvent;

/**
 * GimbalAdapter interfaces Gimbal SDK functionality with Urban Airship services.
 */
public class GimbalAdapter {

    /**
     * GimbalAdapter logging tag.
     */
    private static final String TAG = "GimbalAdapter ";

    /**
     * GimbalAdapter shared instance.
     */
    private static GimbalAdapter instance;

    /**
     * Analytics event source.
     */
    private static final String SOURCE = "Gimbal";

    /**
     * Boolean representing the started state of the GimbalAdapter.
     */
    private boolean isStarted = false;

    /**
     * Listener for Gimbal place events. Creates an analytics event
     * corresponding to boundary event type.
     */
    private PlaceEventListener placeEventListener = new PlaceEventListener() {
        @Override
        public void onEntry(Place place, long timestamp) {
            Log.i(TAG, "Enter: " + place.getName());
            RegionEvent enter = new RegionEvent(place.getIdentifier(), SOURCE, RegionEvent.BOUNDARY_EVENT_ENTER);
            UAirship.shared().getAnalytics().addEvent(enter);
        }

        @Override
        public void onExit(Place place, long entryTimestamp, long exitTimestamp) {
            Log.i(TAG, "Exit: " + place.getName());
            RegionEvent exit = new RegionEvent(place.getIdentifier(), SOURCE, RegionEvent.BOUNDARY_EVENT_EXIT);
            UAirship.shared().getAnalytics().addEvent(exit);
        }
    };

    /**
     * Hidden to support the singleton pattern.
     */
    GimbalAdapter() {}

    /**
     * GimbalAdapter shared instance.
     */
    public synchronized static GimbalAdapter shared() {
        if (instance == null) {
            instance = new GimbalAdapter();
        }

        return instance;
    }

    /**
     * Starts tracking places.
     */
    public void start() {
        if (isStarted) {
            return;
        }

        isStarted = true;

        PlaceManager.getInstance().addPlaceEventListener(placeEventListener);
        PlaceManager.getInstance().startMonitoring();
        Log.i(TAG, "Adapter Started");
    }

    /**
     * Stops tracking places.
     */
    public void stop() {
        if (!isStarted) {
            return;
        }
        isStarted = false;

        PlaceManager.getInstance().stopMonitoring();
        PlaceManager.getInstance().removePlaceEventListener(placeEventListener);

        Log.i(TAG, "Adapter Stopped");
    }
}
