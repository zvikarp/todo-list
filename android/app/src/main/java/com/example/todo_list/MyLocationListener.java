package com.example.todo_list;

import android.os.Bundle;
import android.location.LocationListener;
import android.location.Location;
import android.view.View;
import android.util.Log;
import android.location.Geocoder;
import android.location.Address;
import android.content.Context;
import android.app.Service;
import java.util.Locale;
import java.util.Map;
import java.util.HashMap;
import java.util.List;
import java.io.IOException;
import android.os.IBinder;
import android.content.Intent;

public class MyLocationListener extends Service implements LocationListener {
    static final String TAG = MainActivity.class.getCanonicalName();
    static String lat = "";
    static Map<Integer, Location> points = new HashMap<Integer, Location>();
    static Map<Integer, Boolean> notified = new HashMap<Integer, Boolean>();
    private static Context context;

    static public void addPoint(int id, Location point) {
        Log.d(TAG, "adding...");
        points.put(id, point);
        notified.put(id, false);
    }

    static public void removePoint(int id) {
        Log.d(TAG, "removing...");
        points.remove(id);
        notified.remove(id);
    }

    static private double degreesToRadians(double degrees) {
        return degrees * Math.PI / 180;
    }

    static private double distanceInKmBetweenCoordinates(Location point1, Location point2) {
        double earthRadiusKm = 6371.0;

        double dLat = degreesToRadians(point2.getLatitude() - point1.getLatitude());
        double dLon = degreesToRadians(point2.getLongitude() - point1.getLongitude());

        double lat1 = degreesToRadians(point1.getLatitude());
        double lat2 = degreesToRadians(point2.getLatitude());

        double a = Math.sin(dLat / 2) * Math.sin(dLat / 2)
                + Math.sin(dLon / 2) * Math.sin(dLon / 2) * Math.cos(lat1) * Math.cos(lat2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        return earthRadiusKm * c;
    }

    public void getLastKnownLocation(Location loc) {
        for (Map.Entry<Integer, Boolean> item : notified.entrySet()) {
            if (item.getValue())
                continue;
            double distance = distanceInKmBetweenCoordinates(loc, points.get(item.getKey()));
            if (distance <= 1)
                notified.put(item.getKey(), true);
            MainActivity.showNotification();
        }
    }

    @Override
    public void onLocationChanged(Location loc) {
        for (Map.Entry<Integer, Location> item : points.entrySet()) {
            double distance = distanceInKmBetweenCoordinates(loc, item.getValue());
            if (distance <= 1)
                MainActivity.showNotification();
        }
    }

    @Override
    public void onProviderDisabled(String provider) {
        // TODO Auto-generated method stub
    }

    @Override
    public void onProviderEnabled(String provider) {
        // TODO Auto-generated method stub
    }

    @Override
    public void onStatusChanged(String provider, int status, Bundle extras) {
        // TODO Auto-generated method stub
    }

    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

}