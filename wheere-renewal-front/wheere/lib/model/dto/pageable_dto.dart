import 'sort_dto.dart';

class PageableDTO {
  SortDTO sort;
  int offset;
  int pageSize;
  int pageNumber;
  bool unpaged;
  bool paged;

  PageableDTO({
    required this.sort,
    required this.offset,
    required this.pageSize,
    required this.pageNumber,
    required this.unpaged,
    required this.paged
  });

  factory PageableDTO.fromJson(Map<String, dynamic> json) {
    return PageableDTO(
        sort: SortDTO.fromJson(json['sort']),
        offset: json['offset'],
        pageSize: json['pageSize'],
        pageNumber: json['pageNumber'],
        unpaged: json['unpaged'],
        paged: json['paged']
    );
  }
}