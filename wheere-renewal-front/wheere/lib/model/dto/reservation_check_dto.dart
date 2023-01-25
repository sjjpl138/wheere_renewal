import 'dtos.dart';

class ReservationCheckDTO {
  List<ReservationDTO> reservations;
  PageableDTO pageable;
  bool first;
  bool last;
  int size;
  int number;
  SortDTO sort;
  int numberOfElements;
  bool empty;

  ReservationCheckDTO({
    required this.reservations,
    required this.pageable,
    required this.first,
    required this.last,
    required this.size,
    required this.number,
    required this.sort,
    required this.numberOfElements,
    required this.empty
  });

  factory ReservationCheckDTO.fromJson(Map<String, dynamic> json) {
    var list = json['reservations'] as List;
    List<ReservationDTO> getList = list.map((i) => ReservationDTO.fromJson(i)).toList();
    return ReservationCheckDTO(
        reservations: getList,
        pageable: PageableDTO.fromJson(json['pageable']),
        first: json['first'],
        last: json['last'],
        size: json['size'],
        number: json['number'],
        sort: SortDTO.fromJson(json['sort']),
        numberOfElements: json['numberOfElements'],
        empty: json['empty']
    );
  }
}