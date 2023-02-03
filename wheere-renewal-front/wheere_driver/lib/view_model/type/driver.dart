import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wheere_driver/model/dto/dtos.dart';
import 'package:wheere_driver/model/dto/member_dto.dart';
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

  // TODO : 테스트 코드 삭제
  DriverDTO? _driverDTO = DriverDTO(
    dName: "dName",
    bId: "bId",
    vNo: "vNo",
    routeId: "routeId",
    bNo: "bNo",
    route: [
      StationDTO(sName: "sName1", sSeq: 5),
      StationDTO(sName: "sName2", sSeq: 6),
      StationDTO(sName: "sName3", sSeq: 7),
      StationDTO(sName: "sName4", sSeq: 8),
      StationDTO(sName: "sName5", sSeq: 9),
      StationDTO(sName: "sName6", sSeq: 10),
      StationDTO(sName: "sName7", sSeq: 11),
      StationDTO(sName: "sName8", sSeq: 12),
      StationDTO(sName: "sName9", sSeq: 13),
      StationDTO(sName: "sName10", sSeq: 14),
      StationDTO(sName: "sName11", sSeq: 15),
      StationDTO(sName: "sName12", sSeq: 16),
      StationDTO(sName: "sName13", sSeq: 17),
      StationDTO(sName: "sName14", sSeq: 18),
      StationDTO(sName: "sName15", sSeq: 19),
      StationDTO(sName: "sName16", sSeq: 20),
      StationDTO(sName: "sName17", sSeq: 21),
      StationDTO(sName: "sName18", sSeq: 22),
      StationDTO(sName: "sName19", sSeq: 23),
      StationDTO(sName: "sName20", sSeq: 24),
      StationDTO(sName: "sName21", sSeq: 25),
      StationDTO(sName: "sName22", sSeq: 26),
      StationDTO(sName: "sName23", sSeq: 27),
      StationDTO(sName: "sName24", sSeq: 28),
    ],
    reservations: [
      ReservationDTO(
        rId: "rId",
        startSeq: 10,
        endSeq: 11,
        member: MemberDTO(
          mId: "mId",
          mName: "mName",
          mSex: "mSex",
          mBirthDate: "mBirthDate",
          mNum: "mNum",
        ),
        bId: 'bId',
      ),
    ],
  );

  Future login(FirebaseLoginDTO firebaseLoginDTO) async {
    await _loginService.loginWithRemote(firebaseLoginDTO);
    notifyListeners();
  }

  Future logout() async {
    await _logoutService.logoutWithRemote().then((value) => _driverDTO = value);
    notifyListeners();
  }
}
