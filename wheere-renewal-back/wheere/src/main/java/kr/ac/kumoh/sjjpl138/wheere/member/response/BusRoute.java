package kr.ac.kumoh.sjjpl138.wheere.member.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalTime;
import java.util.List;

@Data
public class BusRoute {
    @JsonProperty("bNo")
    private String bNo;
    private List<Long> busId;
    @JsonProperty("sStationId")
    private int sStationId;
    @JsonProperty("sStationName")
    private String sStationName;
    @JsonProperty("sTime")
    @DateTimeFormat(pattern = "HH:mm:ss")
    private List<LocalTime> sTime;
    @JsonProperty("eStationId")
    private int eStationId;
    @JsonProperty("eStationName")
    private String eStationName;
    @JsonProperty("eTime")
    @DateTimeFormat(pattern = "HH:mm:ss")
    private List<LocalTime> eTime;

    private List<Integer> leftSeats;
}
