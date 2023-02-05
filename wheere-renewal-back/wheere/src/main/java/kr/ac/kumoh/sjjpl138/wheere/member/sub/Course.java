package kr.ac.kumoh.sjjpl138.wheere.member.sub;

import lombok.Data;

import java.util.List;

@Data
public class Course {
    private int busTransitCount; // 버스 환승 카운트
    private int payment; // 요금
    private String firstStartStation; // 최초 정류장
    private String lastEndStation; // 최종 정류장
    // subPaths.length() == 2 * busTransicCount + 1
    private List<SubCourse> subCourses;
}
