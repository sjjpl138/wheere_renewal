package kr.ac.kumoh.sjjpl138.wheere.station.api;

import kr.ac.kumoh.sjjpl138.wheere.station.Station;
import kr.ac.kumoh.sjjpl138.wheere.station.service.StationService;
import lombok.AllArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/stations")
@RequiredArgsConstructor
public class StationApiController {
    private final StationService stationService;

    /**
     * 정류장 조회
     * @param bId
     * @return
     */
    @GetMapping
    public ResponseEntity<StationResponse> stationList(@RequestParam("bId") Long bId) {
        List<Station> stationList = stationService.findStationList(bId);
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
