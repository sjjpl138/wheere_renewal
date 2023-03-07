import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/model/repository/local_data_sources/base_local_data_source.dart';
import 'dart:convert';

class LocalAlarmDataSource implements BaseLocalDataSource {
  Future<AlarmListDTO?> readWithLocal() async {
    String? alarmListDTO = await BaseLocalDataSource.read(key: 'alarm');
    if (alarmListDTO == null) return null;
    return AlarmListDTO.fromJson(json.decode(alarmListDTO));
  }

  Future writeWithLocal(AlarmListDTO value) async {
    await BaseLocalDataSource.write(
      key: 'alarm',
      value: json.encode(value.toJson()),
    );
  }
}
