import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:wheere_driver/main.dart';
import 'package:wheere_driver/view/common/commons.dart';
import 'type/types.dart';

class MainViewModel extends ChangeNotifier {
  late List<BusStationInfo> busStationInfoList;

  MainViewModel() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      var androidNotifyDetails = AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: channel.description,
      );
      var iOSNotifyDetails = const DarwinNotificationDetails();
      var details = NotificationDetails(
          android: androidNotifyDetails, iOS: iOSNotifyDetails);
      if (notification != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          details,
        );

        print(json.encode(message.data));

        _getNewAlarm(message.data);
      }
    });
    _makeBusStationInfo();
  }

  void _makeBusStationInfo() {
    busStationInfoList = Driver()
            .driver
            ?.route
            .map((e) => BusStationInfo(
                  stationName: e.sName,
                ))
            .toList() ??
        [
          BusStationInfo(
            stationName: "stationName",
          ),
          BusStationInfo(
            stationName: "stationName",
          ),
          BusStationInfo(
            stationName: "stationName",
          ),
          BusStationInfo(
            stationName: "stationName",
          ),
        ];
  }

  Future _getNewAlarm(Map<String, dynamic> json) async {

  }

  Future logout() async {
    await Driver().logout();
  }
}
