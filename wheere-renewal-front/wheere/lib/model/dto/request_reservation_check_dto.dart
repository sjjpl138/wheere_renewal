class RequestReservationCheckDTO {
  String mId;
  String rState;
  int size;
  int page;

  RequestReservationCheckDTO({
    required this.mId,
    required this.rState,
    required this.size,
    required this.page
  });
}