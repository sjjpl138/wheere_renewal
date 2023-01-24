package kr.ac.kumoh.sjjpl138.wheere.member;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalTime;

@Data
public class BusRoute {
    private Long busId;
    private String bNo;
    private Integer sStationId;
    private String sStationName;
    @DateTimeFormat(pattern = "HH:mm:ss")
    private LocalTime sTime;
    private Integer eStationId;
    private String eStationName;
    @DateTimeFormat(pattern = "HH:mm:ss")
    private LocalTime eTime;
    private int leftSeats;
}
