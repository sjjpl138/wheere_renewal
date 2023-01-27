import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/model/repository/local_data_sources/base_local_data_source.dart';
import 'dart:convert';

class LocalHasNewAlarmDataSource implements BaseLocalDataSource {
  Future<HasNewAlarmDTO?> readWithLocal() async {
    String? hasNewAlarmDTO = await BaseLocalDataSource.read(key: 'hasNewAlarm');
    if(hasNewAlarmDTO == null) return null;
    return HasNewAlarmDTO.fromJson(json.decode(hasNewAlarmDTO));
  }

  Future writeWithLocal(HasNewAlarmDTO value) async {
    await BaseLocalDataSource.write(
        key: 'hasNewAlarm', value: json.encode(value.toJson()));
  }
}
