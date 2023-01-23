class RequestBusLocationDTO{
  String serviceKey = 'cmhgKqHo8LG79RiHLizHLSVvDD0XCwmUA%2FQuqTNvZyNwaFL7G1j86W6y2i%2BuTvkV%2F8RCLMMU96OEaQdoh32IWw%3D%3D';
  int pageNo; // 페이지 번호
  int numOfRows; // 한 페이지 당 표츌 데이터 수
  // pageNo, numOfRows는 옵션..
  final String type = 'json';
  int cityCode = 22;
  String rId;

  RequestBusLocationDTO({
    required this.pageNo,
    required this.numOfRows,
    required this.cityCode,
    required this.rId
  });
}