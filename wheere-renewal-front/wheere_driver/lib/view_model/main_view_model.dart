import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:wheere_driver/main.dart';
import 'package:wheere_driver/model/dto/alarm_dto/base_alarm_dto.dart';
import 'package:wheere_driver/model/dto/dtos.dart';
import 'package:wheere_driver/view/common/commons.dart';
import 'package:wheere_driver/view/setting/setting_page.dart';
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
    // 1. 서버에서 알람받기
    // 2. view에 반영하기?
  }

  void setReservationInfo(ReservationDTO reservation) {
    Driver().driver!.reservations.add(reservation);
  }

  Future showMemberDialogs(
      BuildContext context, BusStationInfo busStationInfo) async {
    for (var element in busStationInfo.ridePeople) {
      await showDialog(
        context: context,
        builder: (BuildContext context) => RideMemberDialog(memberDTO: element),
      );
    }
  }

  Future logout() async {
    await Driver().logout();
  }

  void navigateToSettingPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingPage()),
    );
  }
}
