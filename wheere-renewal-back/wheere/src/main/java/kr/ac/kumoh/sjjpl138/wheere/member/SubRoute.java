package kr.ac.kumoh.sjjpl138.wheere.member;

import lombok.Data;

@Data
public class SubRoute {

    private int trafficType;
    private int sectionTime;
    private BusRoute busRoute;
}
