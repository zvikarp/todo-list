package com.example.todo_list;

import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.EventChannel.EventSink;
import io.flutter.plugin.common.EventChannel.StreamHandler;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import android.os.Build;
import android.location.LocationListener;
import android.location.Location;
import android.location.LocationManager;
import android.view.View;
import android.util.Log;
import android.Manifest;
import android.location.Geocoder;
import android.location.Address;
import android.content.Context;
import android.app.Notification;
import android.app.NotificationManager;
import java.util.Locale;
import java.util.List;
import java.io.IOException;
import android.content.pm.PackageManager;

public class MainActivity extends FlutterActivity {

  private static final String METHOD_CHANNEL = "com.example.todo_list/method_channel";
  static final String TAG = MainActivity.class.getCanonicalName();
  private LocationManager locationManager = null;
  private LocationListener locationListener = new MyLocationListener();
  private static final int ACCESS_FINE_LOCATION = 1;
  private static final int ACCESS_COARSE_LOCATION = 1;
  private static final int FOREGROUND_SERVICE = 1;
  private static Context context;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    MainActivity.context = getApplicationContext();

    locationManager = (LocationManager) getSystemService(Context.LOCATION_SERVICE);
    new MethodChannel(getFlutterView(), METHOD_CHANNEL).setMethodCallHandler(new MethodCallHandler() {
      @Override
      public void onMethodCall(MethodCall call, Result result) {

        if (call.method.equals("addPoint")) {
          int id = call.argument("id");
          String point = call.argument("point");
          boolean res = addPoint(id, point);
          result.success(res);
        }

        if (call.method.equals("removePoint")) {
          int id = call.argument("id");
          boolean res = removePoint(id);
          result.success(res);
        }

        if (call.method.equals("getLocationUpdates")) {
          getLocation();
        }
      }
    });
  }

  static public void showNotification() {
    NotificationManager notif = (NotificationManager)MainActivity.context.getSystemService(Context.NOTIFICATION_SERVICE);
    Notification notify = new Notification.Builder(MainActivity.context.getApplicationContext()).setContentTitle("Time Todo!")
        .setContentText("Hey! you have a todo around you, open your app to check it.")
        .setSmallIcon(R.drawable.icon).build();
    notif.notify(0, notify);
  }
  
  private void getLocation() {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
      if (checkSelfPermission(Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
        String[] permissionRequested = { Manifest.permission.ACCESS_FINE_LOCATION };
        requestPermissions(permissionRequested, ACCESS_FINE_LOCATION);
      }
    }
  
    locationManager.getLastKnownLocation(LocationManager.GPS_PROVIDER);
    locationManager.requestLocationUpdates(LocationManager.GPS_PROVIDER, 5000, 10, locationListener);
  }

  private boolean addPoint(int id, String point) {
    String[] pointCoordinates = point.split(",");
    Location location = new Location("");
    location.setLatitude(Double.parseDouble(pointCoordinates[0]));
    location.setLongitude(Double.parseDouble(pointCoordinates[1]));
    MyLocationListener.addPoint(id, location);
    return true;
  }

  private boolean removePoint(int id) {
    MyLocationListener.removePoint(id);
    return true;
  }
    

}