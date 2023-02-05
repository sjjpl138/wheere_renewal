package kr.ac.kumoh.sjjpl138.wheere.reservation.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import kr.ac.kumoh.sjjpl138.wheere.reservation.Reservation;
import kr.ac.kumoh.sjjpl138.wheere.reservation.ReservationStatus;
import lombok.Data;

import java.time.LocalDate;
import java.util.List;

@Data
public class ReservationListResponse {

    @JsonProperty("rId")
    private Long rId;
    @JsonProperty("rDate")
    private LocalDate rDate;
    @JsonProperty("rState")
    private ReservationStatus rState;
    private List<ReservationBus> buses;

    public ReservationListResponse(Reservation reservation) {
        this.rId = reservation.getId();
        this.rDate = reservation.getReservationDate();
        this.rState = reservation.getReservationStatus();
    }
}
