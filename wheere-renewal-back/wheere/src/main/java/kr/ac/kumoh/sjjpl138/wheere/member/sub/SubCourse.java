package kr.ac.kumoh.sjjpl138.wheere.member.sub;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.Optional;

@Data
public class SubCourse {
    private int trafficType; // 이동 수단 종류 (1-지하철, 2-버스, 3-도보)
    private int sectionTime; // 이동 소요 시간
    private Optional<BusLane> busLane; // trafficType == 2인 경우
}
