package kr.ac.kumoh.sjjpl138.wheere.reservation.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import kr.ac.kumoh.sjjpl138.wheere.reservation.ReservationStatus;
import lombok.AllArgsConstructor;
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

    public ReservationListResponse(Long rId, LocalDate rDate, ReservationStatus rState) {
        this.rId = rId;
        this.rDate = rDate;
        this.rState = rState;
    }
}
