import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:wheere_driver/main.dart';
import 'package:wheere_driver/model/dto/alarm_dto/base_alarm_dto.dart';
import 'package:wheere_driver/model/dto/alarm_dto/canceled_reservation_alarm_dto.dart';
import 'package:wheere_driver/model/dto/alarm_dto/new_reservation_alarm_dto.dart';
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
        message.data["title"] = notification.title;
        message.data["body"] = notification.body;
        log(json.encode(message.data));
        _getNewAlarm(message.data);
      }
    });
    _makeBusStationInfo();
    _initReservationInfo();
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
    BaseAlarmDTO alarmDTO;
    switch ((alarmDTO = BaseAlarmDTO.fromJson(json)).runtimeType) {
      case NewReservationAlarmDTO:
        _addReservationInfo(
          (alarmDTO as NewReservationAlarmDTO).reservationDTO,
        );
        break;
      case CanceledReservationAlarmDTO:
        _deleteReservationInfo(
          (alarmDTO as CanceledReservationAlarmDTO).canceledReservationDTO,
        );
        break;
      default:
        break;
    }
  }

  void _initReservationInfo() {
    for (var element in Driver().driver!.reservations) {
      busStationInfoList[element.startSeq].ridePeople.add(element.member);
      for (var i = element.startSeq; i < element.endSeq; i++) {
        busStationInfoList[i].leftSeats--;
      }
      busStationInfoList[element.endSeq - 1].quitPeople.add(element.member);
    }
  }

  void _addReservationInfo(ReservationDTO reservation) {
    Driver().driver!.reservations.add(reservation);
    busStationInfoList[reservation.startSeq].ridePeople.add(reservation.member);
    for (var i = reservation.startSeq; i < reservation.endSeq; i++) {
      busStationInfoList[i].leftSeats--;
    }
    busStationInfoList[reservation.endSeq].quitPeople.add(reservation.member);
    notifyListeners();
  }

  void _deleteReservationInfo(CanceledReservationDTO reservation) {
    for (var element in Driver().driver!.reservations) {
      if (element.rId == reservation.rId) {
        Driver().driver!.reservations.remove(element);
        busStationInfoList[element.startSeq].ridePeople.remove(element.member);
        for (var i = element.startSeq; i < element.endSeq; i++) {
          busStationInfoList[i].leftSeats++;
        }
        busStationInfoList[element.endSeq].quitPeople.remove(element.member);
        break;
      }
    }
    notifyListeners();
  }

  Future showMemberListDialog(
      BuildContext context, BusStationInfo busStationInfo) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => MembersDialog(
        busStationInfo: busStationInfo,
        showRideMemberDialog: (MemberDTO memberDTO) =>
            _showRideMemberDialog(context, memberDTO),
        showQuitMemberDialog: (MemberDTO memberDTO) =>
            _showQuitMemberDialog(context, memberDTO),
      ),
    );
  }

  Future _showRideMemberDialog(
      BuildContext context, MemberDTO memberDTO) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => RideMemberDialog(memberDTO: memberDTO),
    ).then((value) {
      if(value) {
        // TODO : 승차 API 전송...?
        log(memberDTO.toJson().toString());
      }
    });
  }

  Future _showQuitMemberDialog(
      BuildContext context, MemberDTO memberDTO) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => QuitMemberDialog(memberDTO: memberDTO),
    ).then((value) {
      if(value) {
        // TODO : 하차 API 전송
        log(memberDTO.toJson().toString());
      }
    });
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
