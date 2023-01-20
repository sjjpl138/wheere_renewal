import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/model/repository/local_data_sources/base_local_data_source.dart';
import 'dart:convert';

class LocalLoginDataSource implements BaseLocalDataSource {
  Future<MemberDTO?> readWithLocal() async {
    String? memberDTO = await BaseLocalDataSource.read(key: 'member');
    if (memberDTO == null) return null;
    return MemberDTO.fromJson(json.decode(memberDTO));
  }

  Future writeWithLocal(MemberDTO value) async {
    await BaseLocalDataSource.write(
        key: 'member', value: json.encode(value.toJson()));
  }
}
