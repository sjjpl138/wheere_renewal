import 'package:wheere/model/repository/alarm_repository.dart';
import 'package:wheere/model/dto/dtos.dart';

class AlarmService {
  final AlarmRepository _alarmRepository = AlarmRepository();

  Future<AlarmListDTO> getAlarmWithLocal() async {
    await _alarmRepository.writeHasNewAlarmWithLocal(HasNewAlarmDTO(
      hasNewAlarm: false,
    ));
    return await _alarmRepository.readAlarmWithLocal() ??
        AlarmListDTO(alarms: []);
/*    AlarmListDTO alarmListDTO =
        await _alarmRepository.readAlarmWithLocal() ?? AlarmListDTO(alarms: []);
    return alarmListDTO
      ..alarms.sort((a, b) => dateTimeFormat
          .parse(b.aTime)
          .compareTo(dateTimeFormat.parse(a.aTime)));*/
  }

  Future addAlarmWithLocal(AlarmDTO value) async {
    AlarmListDTO? alarmListDTO = await _alarmRepository.readAlarmWithLocal();
    if (alarmListDTO == null) {
      alarmListDTO = AlarmListDTO(alarms: [value]);
    } else {
      alarmListDTO.alarms.insert(0, value);
    }
    await _alarmRepository.writeAlarmWithLocal(alarmListDTO);
    await _alarmRepository.writeHasNewAlarmWithLocal(HasNewAlarmDTO(
      hasNewAlarm: true,
    ));
  }

  Future<HasNewAlarmDTO> getHasNewAlarmWithLocal() async {
    HasNewAlarmDTO? hasNewAlarmDTO =
        await _alarmRepository.readHasNewAlarmWithLocal();
    return hasNewAlarmDTO ?? HasNewAlarmDTO(hasNewAlarm: false);
  }
}
