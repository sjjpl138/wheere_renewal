package kr.ac.kumoh.sjjpl138.wheere.member.sub;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.List;

@Data
@AllArgsConstructor
public class BusLane {
    private List<String> busNoList; // 버스 번호 리스트
    private int boardStationID; // 승차 정류장 ID
    private String boardStationName; // 승차 정류장 명칭
    private int alightStationID; // 하차 정류장 ID
    private String alightStationName; // 하차 정류장 명칭

    public static BusLane createBusLane(List<String> busNoList, int boardStationID, String boardStationName, int alightStationID, String alightStationName) {
        return new BusLane(busNoList, boardStationID, boardStationName, alightStationID, alightStationName);
    }
}
