import 'dart:async';
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
import 'package:wheere_driver/model/service/bus_getoff_service.dart';
import 'package:wheere_driver/model/service/bus_location_service.dart';
import 'package:wheere_driver/view/common/commons.dart';
import 'package:wheere_driver/view/setting/setting_page.dart';
import '../styles/styles.dart';
import 'type/types.dart';

class MainViewModel extends ChangeNotifier {
  final BusLocationService _busLocationService = BusLocationService();
  final BusGetOffService _busGetOffService = BusGetOffService();
  late List<BusStationInfo> busStationInfoList;

  final ScrollController scrollController = ScrollController();

  Timer? _timer;
  int busCurrentLocationIndex = 0;
  double bodyHeight = 0.0;

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
    initReservationInfo();
  }

  void initReservationInfo() {
    _makeBusStationInfo();
    _timer?.cancel();
    for (var element in Driver().driver!.reservations) {
      busStationInfoList[element.startSeq - Driver().driver!.route.first.sSeq]
          .ridePeople
          .add(element);
      for (var i = element.startSeq; i < element.endSeq; i++) {
        busStationInfoList[i - Driver().driver!.route.first.sSeq].leftSeats--;
      }
      busStationInfoList[element.endSeq - Driver().driver!.route.first.sSeq]
          .quitPeople
          .add(element);
    }
    notifyListeners();
    _getBusCurrentLocation();
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

  void _addReservationInfo(ReservationDTO reservation) {
    Driver().driver!.reservations.add(reservation);
    busStationInfoList[reservation.startSeq - Driver().driver!.route.first.sSeq]
        .ridePeople
        .add(reservation);
    for (var i = reservation.startSeq; i < reservation.endSeq; i++) {
      busStationInfoList[i - Driver().driver!.route.first.sSeq].leftSeats--;
    }
    busStationInfoList[reservation.endSeq - Driver().driver!.route.first.sSeq]
        .quitPeople
        .add(reservation);
    notifyListeners();
  }

  void _deleteReservationInfo(CanceledReservationDTO reservation) {
    for (var element in Driver().driver!.reservations) {
      if (element.rId == reservation.rId) {
        Driver().driver!.reservations.remove(element);
        busStationInfoList[element.startSeq - Driver().driver!.route.first.sSeq]
            .ridePeople
            .remove(element);
        for (var i = element.startSeq; i < element.endSeq; i++) {
          busStationInfoList[i - Driver().driver!.route.first.sSeq].leftSeats++;
        }
        busStationInfoList[element.endSeq - Driver().driver!.route.first.sSeq]
            .quitPeople
            .remove(element);
        break;
      }
    }
    notifyListeners();
  }

  int testStationName = 0;

  void _getBusCurrentLocation() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      // TODO : 테스트 코드 삭제
      testStationName++;
      log("sName$testStationName");
      _updateBusCurrentLocation(
        BusLocationDTO(
          stationName: "sName$testStationName",
        ),
      );
/*      await _busLocationService
          .requestRoute(
            RequestBusLocationDTO(routeId: Driver().driver!.routeId),
            Driver().driver!.bId,
            Driver().driver!.vNo,
          )
          .then((value) => _updateBusCurrentLocation(
                value ??
                    BusLocationDTO(
                      stationName: "stationName",
                    ),
              ));*/
    });
  }

  void _updateBusCurrentLocation(BusLocationDTO busLocationDTO) {
    for (var i = busCurrentLocationIndex; i < busStationInfoList.length; i++) {
      if (busStationInfoList[i].stationName == busLocationDTO.stationName) {
        busStationInfoList[busCurrentLocationIndex].isCurrentStation = false;
        busCurrentLocationIndex = i;
        busStationInfoList[busCurrentLocationIndex].isCurrentStation = true;
        notifyListeners();
        focusListToCurrentLocation();
        return;
      }
    }
    notifyListeners();
    _timer?.cancel();
  }

  void focusListToCurrentLocation() {
    scrollController.animateTo(
      (busCurrentLocationIndex + 0.5) *
              (kPaddingMiddleSize * 2 +
                  kTextMiddleSize * kTextHeight +
                  kTextSmallSize * kTextHeight) -
          bodyHeight / 2,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.ease,
    );
  }

  void setBodyHeight(BuildContext context) {
    bodyHeight = MediaQuery.of(context).size.height -
        Scaffold.of(context).appBarMaxHeight!;
  }

  Future showMemberListDialog(
      BuildContext context, BusStationInfo busStationInfo) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => MembersDialog(
        busStationInfo: busStationInfo,
        showRideMemberDialog: (ReservationDTO reservationDTO) =>
            _showRideMemberDialog(context, reservationDTO),
        showQuitMemberDialog: (ReservationDTO reservationDTO) =>
            _showQuitMemberDialog(context, reservationDTO),
      ),
    );
  }

  Future _showRideMemberDialog(
      BuildContext context, ReservationDTO reservationDTO) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) =>
          RideMemberDialog(memberDTO: reservationDTO.member),
    ).then((value) {
      if (value) {
        // TODO : 승차 API 전송...?
        log(reservationDTO.toJson().toString());
      }
    });
  }

  Future _showQuitMemberDialog(
      BuildContext context, ReservationDTO reservationDTO) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) =>
          QuitMemberDialog(memberDTO: reservationDTO.member),
    ).then((value) {
      if (value) {
        _busGetOffService.sendReservationStateChange(BusGetOffDTO(
          bId: Driver().driver!.bId,
          rId: reservationDTO.rId,
        ));
        log(reservationDTO.toJson().toString());
      }
    });
  }

  Future logout() async {
    await Driver().logout();
    _timer?.cancel();
  }

  void navigateToSettingPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingPage()),
    );
  }
}
