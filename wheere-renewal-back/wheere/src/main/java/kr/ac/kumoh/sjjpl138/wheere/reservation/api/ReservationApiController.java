package kr.ac.kumoh.sjjpl138.wheere.reservation.api;

import com.fasterxml.jackson.annotation.JsonProperty;
import kr.ac.kumoh.sjjpl138.wheere.bus.Bus;
import kr.ac.kumoh.sjjpl138.wheere.bus.repository.BusRepository;
import kr.ac.kumoh.sjjpl138.wheere.bus.service.BusService;
import kr.ac.kumoh.sjjpl138.wheere.exception.*;
import kr.ac.kumoh.sjjpl138.wheere.fcm.service.FcmService;
import kr.ac.kumoh.sjjpl138.wheere.member.Member;
import kr.ac.kumoh.sjjpl138.wheere.platform.Platform;
import kr.ac.kumoh.sjjpl138.wheere.platform.repository.PlatformRepository;
import kr.ac.kumoh.sjjpl138.wheere.reservation.Reservation;
import kr.ac.kumoh.sjjpl138.wheere.reservation.repository.ReservationRepository;
import kr.ac.kumoh.sjjpl138.wheere.reservation.request.ReservationSearchCondition;
import kr.ac.kumoh.sjjpl138.wheere.reservation.ReservationStatus;
import kr.ac.kumoh.sjjpl138.wheere.reservation.dto.ReservationBusInfo;
import kr.ac.kumoh.sjjpl138.wheere.reservation.request.SaveResvRequest;
import kr.ac.kumoh.sjjpl138.wheere.reservation.response.ReservationListResponse;
import kr.ac.kumoh.sjjpl138.wheere.reservation.service.ReservationService;
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

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.*;

@RestController
@RequestMapping("/api/resvs")
@RequiredArgsConstructor
public class ReservationApiController {

    private final ReservationService reservationService;
    private final BusService busService;
    private final PlatformRepository platformRepository;

    private final FcmService fcmService;
    private final BusRepository busRepository;

    private final ReservationRepository reservationRepository;

    /**
     * 예약 조회
     *
     * @param mId       사용자ID (PK)
     * @param condition 검색 조건 (예약 상태)
     * @param pageable  (size, page, sort)
     * @return ReservationListDto
     */
    @ResponseStatus(HttpStatus.OK)
    @GetMapping("/{mId}")
    public Slice<ReservationListResponse> reservationList(
            @PathVariable("mId") String mId,
            ReservationSearchCondition condition,
            @PageableDefault(size = 10, sort = "reservationDate", direction = Sort.Direction.DESC) Pageable pageable) {

        return reservationService.findPartForMemberByCond(mId, condition, pageable);
    }

    /**
     * 예약하기
     *
     * @param request
     * @return
     */
    @PostMapping
    public ResponseEntity<SaveResvResponse> reservationSave(@RequestBody SaveResvRequest request) {

        String mId = request.getMId();
        ReservationStatus rState = request.getRState();
        LocalDate rDate = request.getRDate();
        List<ReservationBusInfo> reservationBusInfo = request.getBuses();

        try {
            // 예약 생성
            Reservation reservation = reservationService.saveReservation(request);

            Long rId = reservation.getId();

            List<SaveResvBusInfo> resvBusInfos = new ArrayList<>(); // 예약한 버스 정보
            for (ReservationBusInfo busInfo : reservationBusInfo) {
                Long bId = busInfo.getBId();

                Bus findBus = busService.findBus(bId);

                String busNo = findBus.getBusNo();
                String vehicleNo = findBus.getVehicleNo();
                String routeId = findBus.getRouteId();

                Long sStationId = busInfo.getSStationId();
                Long eStationId = busInfo.getEStationId();
                List<Platform> platforms = platformRepository.findPlatformByStationIds(List.of(sStationId, eStationId));

                String findBusDriverToken = findBus.getToken();

                // 버스 기사에게 예약 생성 알림 보내기
                if (findBusDriverToken != null) {

                    Platform startPlatform = platforms.get(0);
                    Platform endPlatform = platforms.get(1);

                    int startSeq = startPlatform.getStationSeq();
                    int endSeq = endPlatform.getStationSeq();

                    fcmService.sendNewReservationMessageToDriver(findBusDriverToken, mId, rId, bId, startSeq, endSeq);
                }

                String sStationName = platforms.get(0).getStation().getName();
                String eStationName = platforms.get(1).getStation().getName();
                LocalTime sTime = platforms.get(0).getArrivalTime();
                LocalTime eTime = platforms.get(1).getArrivalTime();

                SaveResvBusInfo saveResvBusInfo = new SaveResvBusInfo(busNo, routeId, vehicleNo, sTime, sStationId, sStationName, eTime, eStationId, eStationName);
                resvBusInfos.add(saveResvBusInfo);
            }
            SaveResvResponse response = new SaveResvResponse(rId, rDate, rState, resvBusInfos);

            return new ResponseEntity<>(response, HttpStatus.OK);

        } catch (ReservationException | NotEnoughSeatsException | IOException | NotExistMemberException | NotExistBusException e) {
            return new ResponseEntity(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    /**
     * 예약 취소
     *
     * @param rId
     * @param request
     * @return
     */
    @ResponseStatus(HttpStatus.OK)
    @PostMapping("/{rId}")
    public void reservationCancel(@PathVariable("rId") Long rId, @RequestBody RemoveResvRequest request) {
        List<Long> bIds = request.getBIds();
        reservationService.cancelReservation(rId, bIds);

        String mId = request.getMId();
        List<Bus> findBusList = busRepository.findByIdIn(bIds);
        for (Bus findBus : findBusList) {
            String findBusDriverToken = findBus.getToken();

            try {
                if (findBusDriverToken != null) {

                    fcmService.sendCancelReservationMessage(findBusDriverToken, mId, rId);
                }
            } catch (IOException e) {
                e.printStackTrace();
            }

        }
    }

    /**
     * 예약 상태 변경 및 사용자에게 평점 알림 보내기
     */
    @PostMapping("/{rId}/get-off-bus")
    public ResponseEntity<?> getOffBus(@PathVariable Long rId, @RequestBody Map<String, Long> messageBody) {

        // 예약 상태 변경 (RESERVED | PAID) -> RVW_WAIT
        reservationService.changeReservationStationToRVW_WAIT(rId);

        Long bId = messageBody.get("bId");
        Optional<Bus> optionalBus = busRepository.findById(bId);

        Optional<Reservation> optionalReservation = reservationRepository.findReservationWithMemberById(rId);

        if (optionalBus.isEmpty() || optionalReservation.isEmpty()) {
            return new ResponseEntity(HttpStatus.BAD_REQUEST);
        }

        Bus findBus = optionalBus.get();
        Reservation findReservation = optionalReservation.get();

        Member member = findReservation.getMember();
        String memberToken = member.getToken();

        String startStationName = findReservation.getStartStation();
        String endStationName = findReservation.getEndStation();
        List<String> stationNameList = Arrays.asList(startStationName, endStationName);
        List<Platform> findPlatforms = platformRepository.findPlatformByStationNameIn(stationNameList);

        try {
            if (memberToken != null) {
                // 사용자에게 평점 알림 보내기
                // reservation
                // bus
                // platform (start, end) - station 페치 조인
                fcmService.sendRatingMessage(memberToken, findBus, findReservation, findPlatforms);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return new ResponseEntity(HttpStatus.OK);
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
        @JsonProperty("mId")
        private String mId;
        @JsonProperty("bIds")
        private List<Long> bIds;
    }
}