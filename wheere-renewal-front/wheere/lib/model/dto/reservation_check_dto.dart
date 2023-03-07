import 'dtos.dart';

class ReservationCheckDTO {
  List<ReservationDTO> reservations;
  PageableDTO pageable;
  int size;
  int number;
  SortDTO sort;
  bool first;
  bool last;
  int numberOfElements;
  bool empty;

  ReservationCheckDTO({
    required this.reservations,
    required this.pageable,
    required this.size,
    required this.number,
    required this.sort,
    required this.first,
    required this.last,
    required this.numberOfElements,
    required this.empty
  });

  factory ReservationCheckDTO.fromJson(Map<String, dynamic> json) {
    var list = json['content'] as List;
    List<ReservationDTO> getList = list.map((i) => ReservationDTO.fromJson(i)).toList();
    return ReservationCheckDTO(
        reservations: getList,
        pageable: PageableDTO.fromJson(json['pageable']),
        size: json['size'],
        number: json['number'],
        sort: SortDTO.fromJson(json['sort']),
        first: json['first'],
        last: json['last'],
        numberOfElements: json['numberOfElements'],
        empty: json['empty']
    );
  }
}