package kr.ac.kumoh.sjjpl138.wheere.member.response;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalTime;
import java.util.List;

@Data
public class BusRoute {
    private String bNo;
    private List<Long> busId;
    private int sStationId;
    private String sStationName;
    @DateTimeFormat(pattern = "HH:mm:ss")
    private List<LocalTime> sTime;
    private int eStationId;
    private String eStationName;
    @DateTimeFormat(pattern = "HH:mm:ss")
    private List<LocalTime> eTime;
    private List<Integer> leftSeats;
}
