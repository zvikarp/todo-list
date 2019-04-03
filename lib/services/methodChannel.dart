import 'dart:async';
import 'package:flutter/services.dart';

class MethodChannelService {
  static const methodChannel = const MethodChannel('com.example.todo_list/method_channel');

  Future<bool> getLocationUpdates() async {
    final success = await methodChannel.invokeMethod('getLocationUpdates');
    return success;
  }

  Future<bool> addPoint(int id, String point) async {
    final res = await methodChannel.invokeMethod('addPoint', {"id": id, "point": point});
    return res;
  }

  Future<bool> removePoint(int id) async {
    final res = await methodChannel.invokeMethod('removePoint', {"id": id});
    return res;
  }

}

final MethodChannelService methodChannelService = MethodChannelService();