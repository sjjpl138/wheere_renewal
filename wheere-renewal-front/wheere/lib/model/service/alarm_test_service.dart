import 'package:wheere/model/dto/alarm_test_list_dto.dart';
import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/model/repository/alarm_test_repository.dart';

class AlarmTestService {
  final AlarmTestRepository _alarmRepository = AlarmTestRepository();

  Future<AlarmTestListDTO> getAlarmWithLocal() async {
    await _alarmRepository.writeHasNewAlarmWithLocal(HasNewAlarmDTO(
      hasNewAlarm: false,
    ));
    return await _alarmRepository.readAlarmWithLocal() ??
        AlarmTestListDTO(alarms: []);
  }

  Future addAlarmWithLocal(Map<String, dynamic> value) async {
    AlarmTestListDTO? alarmTestListDTO = await _alarmRepository.readAlarmWithLocal();
    if (alarmTestListDTO == null) {
      alarmTestListDTO = AlarmTestListDTO(alarms: [value.toString()]);
    } else {
      alarmTestListDTO.alarms.insert(0, value.toString());
    }
    await _alarmRepository.writeAlarmWithLocal(alarmTestListDTO);
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
