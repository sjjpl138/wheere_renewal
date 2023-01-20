import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/model/repository/local_data_sources/local_data_sources.dart';

class AlarmRepository {
  final LocalAlarmDataSource _localAlarmDataSource = LocalAlarmDataSource();

  Future<AlarmListDTO?> readAlarmWithLocal() async {
    return await _localAlarmDataSource.readWithLocal();
  }

  Future writeAlarmWithLocal(AlarmListDTO value) async {
    await _localAlarmDataSource.writeWithLocal(value);
  }
}
