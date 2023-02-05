package kr.ac.kumoh.sjjpl138.wheere.member.response;

import lombok.Data;

import java.util.List;

@Data
public class RetrieveRoutesResult {

    private int outTrafficCheck;
    private List<Route> routes;
}
