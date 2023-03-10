package kr.ac.kumoh.sjjpl138.wheere.driver.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import kr.ac.kumoh.sjjpl138.wheere.platform.dto.StationDto;
import kr.ac.kumoh.sjjpl138.wheere.reservation.dto.ResvDto;
import lombok.Data;

import java.util.List;

@Data
public class DriverLoginResponseDto {

    @JsonProperty("dName")
    private String dName;
    @JsonProperty("bId")
    private Long bId;
    @JsonProperty("vNo")
    private String vNo;
    @JsonProperty("bNo")
    private String bNo;
    private String routeId;
    private int totalSeats;
    private String fcmToken;

    private List<StationDto> route;
    private List<ResvDto> reservations;
}
