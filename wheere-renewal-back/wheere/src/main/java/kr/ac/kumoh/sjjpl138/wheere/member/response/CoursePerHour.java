package kr.ac.kumoh.sjjpl138.wheere.member.response;

import lombok.Data;

import java.util.List;

@Data
public class CoursePerHour {

    private int selectTime;
    private List<Route> routes;
}
