import 'package:firebase_auth/firebase_auth.dart';
import 'package:wheere/model/dto/dtos.dart';
import 'base_remote_data_source.dart';

class RemoteSignUpDataSource implements BaseRemoteDataSource {
  @override
  String path = "/api/members";

  Future<SignUpDTO?> _firebaseSignUp(FirebaseSignUpDTO signUpDTO) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: signUpDTO.email,
        password: signUpDTO.password,
      );
      String? mId = FirebaseAuth.instance.currentUser?.uid;
      return mId != null
          ? SignUpDTO(
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
      SignUpDTO? signUpDTO = await _firebaseSignUp(firebaseSignUpDTO);
      if (signUpDTO != null) {
        await BaseRemoteDataSource.post(path, signUpDTO.toJson());
      }
    } catch (e) {
      return;
    }
  }
}
