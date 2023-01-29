import 'package:wheere/model/dto/alarm_test_list_dto.dart';
import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/model/repository/local_data_sources/local_has_new_alarm_data_source.dart';
import 'local_data_sources/local_alarm_test_data_source.dart';

class AlarmTestRepository {
  final LocalAlarmTestDataSource _localAlarmDataSource = LocalAlarmTestDataSource();
  final LocalHasNewAlarmDataSource _localHasNewAlarmDataSource = LocalHasNewAlarmDataSource();

  Future<AlarmTestListDTO?> readAlarmWithLocal() async {
    return await _localAlarmDataSource.readWithLocal();
  }

  Future writeAlarmWithLocal(AlarmTestListDTO value) async {
    await _localAlarmDataSource.writeWithLocal(value);
  }

  Future<HasNewAlarmDTO?> readHasNewAlarmWithLocal() async {
    return await _localHasNewAlarmDataSource.readWithLocal();
  }

  Future writeHasNewAlarmWithLocal(HasNewAlarmDTO value) async {
    await _localHasNewAlarmDataSource.writeWithLocal(value);
  }
}
