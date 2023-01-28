package kr.ac.kumoh.sjjpl138.wheere.reservation.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import java.time.LocalTime;

@Data
public class ReservationBusDto {

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
