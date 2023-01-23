import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wheere_driver/model/dto/dtos.dart';
import 'package:wheere_driver/model/service/login_service.dart';
import 'package:wheere_driver/model/service/logout_service.dart';

class Driver extends ChangeNotifier {
  final LoginService _loginService = LoginService();
  final LogoutService _logoutService = LogoutService();

  Driver._privateConstructor();

  static final Driver _instance = Driver._privateConstructor();

  factory Driver() {
    return _instance;
  }

  DriverDTO? get driver => _driverDTO;
  DriverDTO? _driverDTO;

  Future login(FirebaseLoginDTO firebaseLoginDTO) async {
    var fcmToken = await FirebaseMessaging.instance
        .getToken(vapidKey: dotenv.env['FIREBASE_WEB_PUSH']);
    _driverDTO = DriverDTO(
      dName: "dName",
      bId: 1,
      vNo: "vNo",
      routeId: "routeId",
      bNo: "bNo",
      route: [
        StationDTO(sId: 1, sName: "sName", sSeq: 1),
        StationDTO(sId: 2, sName: "sName", sSeq: 2),
      ],
      reservations: [
        ReservationDTO(rId: 1, startSeq: 1, endSeq: 2),
      ],
    );

    //await _loginService.loginWithRemote(firebaseLoginDTO);
    notifyListeners();
  }

  Future logout() async {
    await _logoutService.logoutWithRemote().then((value) => _driverDTO = value);
    notifyListeners();
  }
}
