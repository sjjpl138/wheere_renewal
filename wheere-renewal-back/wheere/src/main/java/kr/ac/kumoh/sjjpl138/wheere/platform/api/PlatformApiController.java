package kr.ac.kumoh.sjjpl138.wheere.platform.api;


import kr.ac.kumoh.sjjpl138.wheere.exception.PlatformException;
import kr.ac.kumoh.sjjpl138.wheere.platform.Platform;
import kr.ac.kumoh.sjjpl138.wheere.platform.service.PlatformService;
import kr.ac.kumoh.sjjpl138.wheere.station.Station;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/stations")
@RequiredArgsConstructor
public class PlatformApiController {
    private final PlatformService platformService;

    /**
     * 정류장 조회
     * @param busId
     * @param stationName
     * @return
     */
    @GetMapping("/{bId}")
    public ResponseEntity<StationResponse> stationList(@PathVariable("bId") Long busId, @RequestParam("sName")String stationName) {
       try{
           List<Station> stationList = new ArrayList<>();
           List<Platform> platformList = platformService.findStationNamesByStationName(busId, stationName);
           for (Platform platform : platformList) {
               stationList.add(platform.getStation());
           }
           List<StationResponse> stationInfos = stationList.stream().map(s -> new StationResponse(s.getId(), s.getName())).collect(Collectors.toList());
           return new ResponseEntity(new Stations(stationInfos), HttpStatus.OK);
       } catch (PlatformException e) {
           return new ResponseEntity(e.getMessage(), HttpStatus.BAD_REQUEST);
       }
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
