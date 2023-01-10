import 'remote_data_sources/remote_data_sources.dart';
import 'package:wheere/model/dto/dtos.dart';

class LoginRepository {
  final LoginDataSource _loginDataSource = LoginDataSource();

  Future<MemberDTO?> login(FirebaseLoginDTO firebaseLoginDTO) async {
    return await _loginDataSource.login(firebaseLoginDTO);
  }
}