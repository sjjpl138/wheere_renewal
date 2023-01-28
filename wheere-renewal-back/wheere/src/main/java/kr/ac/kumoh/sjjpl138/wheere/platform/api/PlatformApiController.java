package kr.ac.kumoh.sjjpl138.wheere.platform.api;


import kr.ac.kumoh.sjjpl138.wheere.platform.Platform;
import kr.ac.kumoh.sjjpl138.wheere.platform.repository.PlatformRepository;
import kr.ac.kumoh.sjjpl138.wheere.station.Station;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/stations")
@RequiredArgsConstructor
public class PlatformApiController {
    private final PlatformRepository platformRepository;

    /**
     * 정류장 조회
     * @param bId
     * @return
     */
    @GetMapping
    public ResponseEntity<StationResponse> stationList(@RequestParam("bId") Long bId) {
        List<Station> stationList = new ArrayList<>();
        List<Platform> platformList = platformRepository.findPlatformByBusId(bId);
        for (Platform platform : platformList) {
            stationList.add(platform.getStation());
        }
        List<StationResponse> stationInfos = stationList.stream().map(s -> new StationResponse(s.getId(), s.getName())).collect(Collectors.toList());
        return new ResponseEntity(new Stations(stationInfos), HttpStatus.OK);
    }

    @Data
    @AllArgsConstructor
    static class StationResponse {
        private Long id;
        private String name;
    }

    @Data
    @AllArgsConstructor
    static class Stations<T> {
        private T stations;
    }
}
