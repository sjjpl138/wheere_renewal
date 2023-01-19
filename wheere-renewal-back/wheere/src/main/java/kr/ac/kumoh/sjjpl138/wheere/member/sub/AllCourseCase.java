package kr.ac.kumoh.sjjpl138.wheere.member.sub;

import lombok.Data;

import java.util.List;

@Data
public class AllCourseCase {
    private int outTrafficCheck; // 직통 유무 (0: 직통 o, 1: 직통 x)
    private List<Course> courses; // 모든 경우의 수
}
