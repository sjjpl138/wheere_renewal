import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:wheere/model/dto/dtos.dart';
import 'base_remote_data_source.dart';

class RemoteSignUpDataSource implements BaseRemoteDataSource {
  @override
  String path = "/api/members";

  Future<MemberInfoDTO?> _firebaseSignUp(FirebaseSignUpDTO signUpDTO) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: signUpDTO.email,
        password: signUpDTO.password,
      );
      String? mId = FirebaseAuth.instance.currentUser?.uid;
      return mId != null
          ? MemberInfoDTO(
        mId: mId,
        mName: signUpDTO.mName,
        mSex: signUpDTO.mSex,
        mBirthDate: signUpDTO.mBirthDate,
        mNum: signUpDTO.mNum,
      )
          : null;
    } catch (e) {
      return null;
    }
  }

  Future writeWithRemote(FirebaseSignUpDTO firebaseSignUpDTO) async {
    try {
      MemberInfoDTO? signUpDTO = await _firebaseSignUp(firebaseSignUpDTO);
      log("remote_sign_up_data_source ${signUpDTO?.mId ?? "null"}");
      if (signUpDTO != null) {
        return await BaseRemoteDataSource.post(path, signUpDTO.toJson());
      }
    } catch (e) {
      log("remote_sign_up_data_source $e");
      return;
    }
  }
}
