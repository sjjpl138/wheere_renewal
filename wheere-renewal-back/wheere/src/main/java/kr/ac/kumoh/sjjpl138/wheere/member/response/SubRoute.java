package kr.ac.kumoh.sjjpl138.wheere.member.response;

import kr.ac.kumoh.sjjpl138.wheere.member.response.BusRoute;
import lombok.Data;

@Data
public class SubRoute {

    private int trafficType;
    private int sectionTime;
    private BusRoute busRoute;
}
