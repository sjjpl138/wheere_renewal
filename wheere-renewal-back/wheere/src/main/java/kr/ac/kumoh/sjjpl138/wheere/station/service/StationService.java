package kr.ac.kumoh.sjjpl138.wheere.station.service;

import kr.ac.kumoh.sjjpl138.wheere.platform.Platform;
import kr.ac.kumoh.sjjpl138.wheere.platform.dto.StationInfo;
import kr.ac.kumoh.sjjpl138.wheere.station.Station;
import kr.ac.kumoh.sjjpl138.wheere.station.repository.StationRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class StationService {
    private final StationRepository stationRepository;

    /**
     * 버스 정류장 조회
     * @param bId
     * @return
     */
    public List<Station> findStationList(Long bId) {
        return stationRepository.findStationByBusId(bId);
    }

    public List<StationInfo> findStationByPlatformAndBus(List<Long> stationIds) {
        List<Platform> platforms = stationRepository.findStationByPlatformAndBus(stationIds);
        List<StationInfo> infoList = new ArrayList<>();
        for (Platform platform : platforms) {
            Station station = platform.getStation();
            StationInfo info = new StationInfo(station.getName(), platform.getArrivalTime());
            infoList.add(info);
        }

        return infoList;
    }
}
