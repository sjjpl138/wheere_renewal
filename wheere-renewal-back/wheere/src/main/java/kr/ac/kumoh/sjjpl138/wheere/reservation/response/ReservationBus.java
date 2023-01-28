package kr.ac.kumoh.sjjpl138.wheere.reservation.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReservationBus {

    @JsonProperty("bId")
    private Long bId;
    @JsonProperty("bNo")
    private String bNo;
    private String routeId;
    @JsonProperty("vNo")
    private String vNo;

    @JsonProperty("sTime")
    private LocalTime sTime;
    @JsonProperty("sStationId")
    private Long sStationId;
    @JsonProperty("sStationName")
    private String sStationName;

    @JsonProperty("eTime")
    private LocalTime eTime;
    @JsonProperty("eStationId")
    private Long eStationId;
    @JsonProperty("eStationName")
    private String eStationName;
}
