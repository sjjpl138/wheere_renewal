import 'package:wheere/model/repository/alarm_repository.dart';
import 'package:wheere/model/dto/dtos.dart';

class AlarmService {
  final AlarmRepository _alarmRepository = AlarmRepository();

  Future<AlarmListDTO?> getAlarmWithLocal() async {
    return await _alarmRepository.readAlarmWithLocal();
  }

  Future<AlarmListDTO?> addAlarmWithLocal(AlarmDTO value) async {
    AlarmListDTO? alarmListDTO = await _alarmRepository.readAlarmWithLocal();
    if (alarmListDTO == null) {
      alarmListDTO = AlarmListDTO(alarms: [value]);
    } else {
      alarmListDTO.alarms.add(value);
    }
    return await _alarmRepository.writeAlarmWithLocal(alarmListDTO);
  }
}
