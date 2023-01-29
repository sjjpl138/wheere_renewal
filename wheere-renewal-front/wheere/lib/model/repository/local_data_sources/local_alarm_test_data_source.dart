import 'package:wheere/model/dto/alarm_test_list_dto.dart';
import 'package:wheere/model/repository/local_data_sources/base_local_data_source.dart';
import 'dart:convert';

class LocalAlarmTestDataSource implements BaseLocalDataSource {
  Future<AlarmTestListDTO?> readWithLocal() async {
    String? alarmTestList = await BaseLocalDataSource.read(key: 'alarm');
    if (alarmTestList == null) return null;
    return AlarmTestListDTO.fromJson(json.decode(alarmTestList));
  }

  Future writeWithLocal(AlarmTestListDTO value) async {
    await BaseLocalDataSource.write(
      key: 'alarm',
      value: json.encode(value.toJson()),
    );
  }
}
