package kr.ac.kumoh.sjjpl138.wheere.member;

import lombok.Data;

import java.util.List;

@Data
public class Route {

    private int payment;
    private int busTransitCount;
    private List<SubRoute> subRoutes;
}
