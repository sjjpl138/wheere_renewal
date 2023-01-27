package kr.ac.kumoh.sjjpl138.wheere.member;

import lombok.Data;

import java.util.List;

@Data
public class RetrieveRoutesResult {

    private int outTrafficCheck;
    private List<CoursePerHour> selects;
}
