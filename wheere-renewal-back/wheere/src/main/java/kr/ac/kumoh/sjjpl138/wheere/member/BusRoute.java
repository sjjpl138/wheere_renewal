package kr.ac.kumoh.sjjpl138.wheere.member;

import lombok.Data;

import java.time.LocalTime;

@Data
public class BusRoute {
    private Long busId;
    private String bNo;
    private Integer sStationId;
    private String sStationName;
    private LocalTime sTime;
    private Integer eStationId;
    private String eStationName;
    private LocalTime eTime;
    private int leftSeats;
}
