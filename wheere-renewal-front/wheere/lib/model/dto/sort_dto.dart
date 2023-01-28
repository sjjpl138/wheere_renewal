class SortDTO {
  bool empty;
  bool unsorted;
  bool sorted;

  SortDTO({
    required this.empty,
    required this.unsorted,
    required this.sorted
  });

  factory SortDTO.fromJson(Map<String, dynamic> json) {
    return SortDTO(
        empty: json['empty'],
        unsorted: json['unsorted'],
        sorted: json['sorted']
    );
  }
}