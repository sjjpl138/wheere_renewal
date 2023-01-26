class RequestBusLocationDTO{
  String serviceKey = 'cmhgKqHo8LG79RiHLizHLSVvDD0XCwmUA/QuqTNvZyNwaFL7G1j86W6y2i+uTvkV/8RCLMMU96OEaQdoh32IWw==';
  int pageNo = 1; // 페이지 번호
  int numOfRows = 20; // 한 페이지 당 표츌 데이터 수
  // pageNo, numOfRows는 옵션..
  final String type = 'json';
  int cityCode = 22;
  String routeId;

  RequestBusLocationDTO({
    required this.routeId
  });
}