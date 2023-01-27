import 'remote_data_sources/remote_data_sources.dart';
import 'package:wheere_driver/model/dto/dtos.dart';

class LoginRepository {
  final LoginDataSource _loginDataSource = LoginDataSource();

  Future<DriverDTO?> readMemberWithRemote(FirebaseLoginDTO firebaseLoginDTO) async {
    return await _loginDataSource.readWithRemote(firebaseLoginDTO);
  }
}