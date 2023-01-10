import  'package:wheere/model/repository/repositories.dart';
import 'package:wheere/model/dto/dtos.dart';

class LogoutService{
  final LogoutRepository _logoutRepository = LogoutRepository();

  Future<MemberDTO?> logout() async {
    return await _logoutRepository.logout();
  }
}