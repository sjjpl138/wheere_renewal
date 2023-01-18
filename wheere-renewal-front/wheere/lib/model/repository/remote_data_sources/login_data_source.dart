import 'package:firebase_auth/firebase_auth.dart';
import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/model/repository/remote_data_sources/base_data_source.dart';

class LoginDataSource implements BaseRemoteDataSource {
  @override
  String path = "/api/members/login";

  Future<LoginDTO?> _firebaseLogin(FirebaseLoginDTO loginDTO) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: loginDTO.email,
        password: loginDTO.password,
      );
      String? mId = FirebaseAuth.instance.currentUser?.uid;
      return mId != null ? LoginDTO(mId: mId) : null;
    } catch (e) {
      return null;
    }
  }

  Future<MemberDTO?> login(FirebaseLoginDTO firebaseLoginDTO) async {
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
