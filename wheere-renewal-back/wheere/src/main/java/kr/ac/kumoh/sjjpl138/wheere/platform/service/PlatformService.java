package kr.ac.kumoh.sjjpl138.wheere.platform.service;

import kr.ac.kumoh.sjjpl138.wheere.platform.Platform;
import kr.ac.kumoh.sjjpl138.wheere.platform.repository.PlatformRepository;
import kr.ac.kumoh.sjjpl138.wheere.platform.dto.StationDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class PlatformService {

    private final PlatformRepository platformRepository;

    /**
     * 버스 번호, 차량 번호로 버스 노선 조회
     * 버스 기사 로그인 시 버스 노선 반환할 때 사용
     * @param busNo
     * @param vehicleNo
     * @return
     */
    public List<StationDto> findRoute(String busNo, String vehicleNo) {
        List<Platform> platforms = platformRepository.findPlatformsByBus(busNo, vehicleNo);
        List<StationDto> route = platforms.stream().map(s -> new StationDto(s)).collect(Collectors.toList());
        return route;
    }
    
}
