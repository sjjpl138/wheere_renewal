class RequestReservationCheckDTO {
  String mId;
  String order;
  String rState;
  int size;
  int page;

  RequestReservationCheckDTO({
    required this.mId,
    required this.order,
    required this.rState,
    required this.size,
    required this.page
  });
}