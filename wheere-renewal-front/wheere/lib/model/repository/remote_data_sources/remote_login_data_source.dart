import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/model/repository/remote_data_sources/base_remote_data_source.dart';

class RemoteLoginDataSource implements BaseRemoteDataSource {
  @override
  String path = "/api/members/login";

  Future<LoginDTO?> _firebaseLogin(FirebaseLoginDTO loginDTO) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: loginDTO.email,
        password: loginDTO.password,
      );
      String? mId = FirebaseAuth.instance.currentUser?.uid;
      var fcmToken = await FirebaseMessaging.instance
          .getToken(vapidKey: dotenv.env['FIREBASE_WEB_PUSH']);
      log(fcmToken ?? "null");
      if (fcmToken == null) throw Exception();
      return mId != null ? LoginDTO(mId: mId, fcmToken: fcmToken) : null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<MemberDTO?> readWithRemote(FirebaseLoginDTO firebaseLoginDTO) async {
    try {
      LoginDTO? loginDTO = await _firebaseLogin(firebaseLoginDTO);
      Map<String, dynamic>? res = loginDTO != null
          ? await BaseRemoteDataSource.post(path, loginDTO.toJson())
          : null;
      return res != null ? MemberDTO.fromJson(res) : null;
    } catch (e) {
      return null;
    }
  }
}
