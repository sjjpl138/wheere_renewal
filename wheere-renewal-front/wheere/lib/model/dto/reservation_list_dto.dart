import 'package:wheere/model/dto/dtos.dart';

class ReservationListDTO{
  List<ReservationDTO>? reservationsList; //예약이 없을 수 있으므로 ? 처리..

  ReservationListDTO(this.reservationsList);

  factory ReservationListDTO.fromJson(Map<String, dynamic> json) {
    var list = json['reservations'] as List;
    List<ReservationDTO> getList = list.map((i) => ReservationDTO.fromJson(i)).toList();
    return ReservationListDTO(getList);
  }
}