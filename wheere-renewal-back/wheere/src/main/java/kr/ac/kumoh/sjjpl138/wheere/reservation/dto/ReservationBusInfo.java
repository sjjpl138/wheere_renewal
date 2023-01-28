package kr.ac.kumoh.sjjpl138.wheere.reservation.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReservationBusInfo {
    @JsonProperty("bId")
    private Long bId;
    @JsonProperty("sStationId")
    private Long sStationId;
    @JsonProperty("eStationId")
    private Long eStationId;
}
