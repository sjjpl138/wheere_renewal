package kr.ac.kumoh.sjjpl138.wheere.station.service;

import kr.ac.kumoh.sjjpl138.wheere.platform.dto.StationInfo;
import kr.ac.kumoh.sjjpl138.wheere.station.Station;
import kr.ac.kumoh.sjjpl138.wheere.station.repository.StationRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
        return stationRepository.findStationByPlatformAndBus(stationIds);
    }
}
