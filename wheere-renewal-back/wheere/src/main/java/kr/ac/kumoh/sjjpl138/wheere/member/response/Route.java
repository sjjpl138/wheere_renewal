package kr.ac.kumoh.sjjpl138.wheere.member.response;

import lombok.Data;

import java.util.List;

@Data
public class Route {

    private int payment;
    private int busTransitCount;
    private String firstStartStation;
    private String lastEndStation;
    private List<SubRoute> subRoutes;
}
