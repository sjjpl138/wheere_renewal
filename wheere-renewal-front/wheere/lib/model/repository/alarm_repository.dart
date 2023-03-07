import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/model/repository/local_data_sources/local_data_sources.dart';
import 'package:wheere/model/repository/local_data_sources/local_has_new_alarm_data_source.dart';

class AlarmRepository {
  final LocalAlarmDataSource _localAlarmDataSource = LocalAlarmDataSource();
  final LocalHasNewAlarmDataSource _localHasNewAlarmDataSource = LocalHasNewAlarmDataSource();

  Future<AlarmListDTO?> readAlarmWithLocal() async {
    return await _localAlarmDataSource.readWithLocal();
  }

  Future writeAlarmWithLocal(AlarmListDTO value) async {
    await _localAlarmDataSource.writeWithLocal(value);
  }

  Future<HasNewAlarmDTO?> readHasNewAlarmWithLocal() async {
    return await _localHasNewAlarmDataSource.readWithLocal();
  }

  Future writeHasNewAlarmWithLocal(HasNewAlarmDTO value) async {
    await _localHasNewAlarmDataSource.writeWithLocal(value);
  }
}
