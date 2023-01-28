package kr.ac.kumoh.sjjpl138.wheere.reservation.api;

import com.fasterxml.jackson.annotation.JsonProperty;
import kr.ac.kumoh.sjjpl138.wheere.bus.Bus;
import kr.ac.kumoh.sjjpl138.wheere.bus.service.BusService;
import kr.ac.kumoh.sjjpl138.wheere.exception.NotEnoughSeatsException;
import kr.ac.kumoh.sjjpl138.wheere.platform.dto.StationInfo;
import kr.ac.kumoh.sjjpl138.wheere.reservation.Reservation;
import kr.ac.kumoh.sjjpl138.wheere.reservation.request.ReservationSearchCondition;
import kr.ac.kumoh.sjjpl138.wheere.reservation.ReservationStatus;
import kr.ac.kumoh.sjjpl138.wheere.reservation.dto.ReservationBusInfo;
import kr.ac.kumoh.sjjpl138.wheere.reservation.response.ReservationListResponse;
import kr.ac.kumoh.sjjpl138.wheere.reservation.service.ReservationService;
import kr.ac.kumoh.sjjpl138.wheere.station.service.StationService;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/api/resvs")
@RequiredArgsConstructor
public class ReservationApiController {

    private final ReservationService reservationService;
    private final BusService busService;
    private final StationService stationService;

    /**
     * 예약 조회
     *
     * @param mId       사용자ID (PK)
     * @param condition 검색 조건 (예약 상태)
     * @param pageable  (size, page, sort)
     * @return ReservationListDto
     */
    @GetMapping("/{mId}")
    public ResponseEntity<Slice<ReservationListResponse>> reservationList(
            @PathVariable("mId") String mId,
            ReservationSearchCondition condition,
            @PageableDefault(size = 10, sort = "reservationDate", direction = Sort.Direction.DESC) Pageable pageable) {

        Slice<ReservationListResponse> result = reservationService.findPartForMemberByCond(mId, condition, pageable);

        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    /**
     * 예약하기
     * @param request
     * @return
     */
    @PostMapping
    public ResponseEntity<SaveResvResponse> reservationSave(@RequestBody SaveResvRequest request) {
        String mId = request.getMId();
        Long startStationId = request.getStartStationId();
        Long endStationId = request.getEndStationId();
        ReservationStatus rState = request.getRState();
        LocalDate rDate = request.getRDate();
        List<ReservationBusInfo> buses = request.getBuses();

        try {
            Reservation reservation = reservationService.saveReservation(mId, startStationId, endStationId, rState, rDate, buses);

            Long rId = reservation.getId();

            List<SaveResvBusInfo> busInfos = new ArrayList<>();
            for (ReservationBusInfo bus : buses) {
                Long bId = bus.getBId();
                Bus findBus = busService.findBus(bId);
                String busNo = findBus.getBusNo();
                String vehicleNo = findBus.getVehicleNo();
                String routeId = findBus.getRouteId();

                Long sStationId = bus.getSStationId();
                Long eStationId = bus.getEStationId();
                List<StationInfo> stationInfos = stationService.findStationByPlatformAndBus(List.of(sStationId, eStationId));
                String sStationName = stationInfos.get(0).getSName();
                String eStationName = stationInfos.get(1).getSName();
                LocalTime sTime = stationInfos.get(0).getArrivalTime();
                LocalTime eTime = stationInfos.get(1).getArrivalTime();
                SaveResvBusInfo busInfo = new SaveResvBusInfo(busNo, routeId, vehicleNo, sTime, sStationId, sStationName, eTime, eStationId, eStationName);
                busInfos.add(busInfo);
            }
            SaveResvResponse response = new SaveResvResponse(rId, rDate, rState, busInfos);

            return new ResponseEntity<>(response, HttpStatus.OK);

        } catch (IllegalStateException | NotEnoughSeatsException e) {
            return new ResponseEntity(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    /**
     * 예약 취소
     * @param rId
     * @param request
     * @return
     */
    @DeleteMapping("/{rId}")
    public ResponseEntity reservationRemove(@PathVariable("rId") Long rId, @RequestBody RemoveResvRequest request) {
        List<Long> bIds = request.getBIds();
        reservationService.cancelReservation(rId, bIds);

        return new ResponseEntity(HttpStatus.OK);
    }

    @Data
    static class SaveResvRequest {
        @JsonProperty("mId")
        private String mId;
        private Long startStationId;
        private Long endStationId;
        private List<ReservationBusInfo> buses;
        @JsonProperty("rState")
        private ReservationStatus rState;
        @JsonProperty("rPrice")
        private int rPrice;
        @JsonProperty("rDate")
        private LocalDate rDate;
    }

    @Data
    @AllArgsConstructor
    static class SaveResvResponse {
        @JsonProperty("rId")
        private Long rId;
        @JsonProperty("rDate")
        private LocalDate rDate;
        @JsonProperty("rState")
        private ReservationStatus rState;
        private List<SaveResvBusInfo> buses;
    }

    @Data
    @AllArgsConstructor
    static class SaveResvBusInfo {
        @JsonProperty("bNo")
        private String bNo;
        private String routeId;
        @JsonProperty("vNo")
        private String vNo;
        @JsonProperty("sTime")
        private LocalTime sTime;
        @JsonProperty("sStationId")
        private Long sStationId;
        @JsonProperty("sStationName")
        private String sStationName;
        @JsonProperty("eTime")
        private LocalTime eTime;
        @JsonProperty("eStationId")
        private Long eStationId;
        @JsonProperty("eStationName")
        private String eStationName;
    }

    @Data
    static class RemoveResvRequest {
        @JsonProperty("rId")
        private Long rId;
        @JsonProperty("bIds")
        private List<Long> bIds;
    }
}
