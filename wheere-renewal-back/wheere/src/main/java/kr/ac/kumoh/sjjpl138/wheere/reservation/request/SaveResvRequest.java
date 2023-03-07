package kr.ac.kumoh.sjjpl138.wheere.reservation.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import kr.ac.kumoh.sjjpl138.wheere.reservation.ReservationStatus;
import kr.ac.kumoh.sjjpl138.wheere.reservation.dto.ReservationBusInfo;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SaveResvRequest {

    @JsonProperty("mId")
    private String mId;
    private Long startStationId;
    private Long endStationId;
    private List<ReservationBusInfo> buses;
    @JsonProperty("rState")
    private ReservationStatus rState;
    @JsonProperty("rPrice")
    private int rPrice;
    @JsonProperty("rDate")
    private LocalDate rDate;
}
