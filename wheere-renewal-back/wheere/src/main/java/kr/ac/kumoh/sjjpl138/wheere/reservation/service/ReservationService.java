package kr.ac.kumoh.sjjpl138.wheere.reservation.service;

import kr.ac.kumoh.sjjpl138.wheere.bus.Bus;
import kr.ac.kumoh.sjjpl138.wheere.bus.repository.BusRepository;
import kr.ac.kumoh.sjjpl138.wheere.member.Member;
import kr.ac.kumoh.sjjpl138.wheere.member.repository.MemberRepository;
import kr.ac.kumoh.sjjpl138.wheere.platform.Platform;
import kr.ac.kumoh.sjjpl138.wheere.platform.repository.PlatformRepository;
import kr.ac.kumoh.sjjpl138.wheere.reservation.Reservation;
import kr.ac.kumoh.sjjpl138.wheere.reservation.ReservationStatus;
import kr.ac.kumoh.sjjpl138.wheere.reservation.dto.SaveResvDto;
import kr.ac.kumoh.sjjpl138.wheere.reservation.repository.ReservationRepository;
import kr.ac.kumoh.sjjpl138.wheere.seat.Seat;
import kr.ac.kumoh.sjjpl138.wheere.seat.repository.SeatRepository;
import kr.ac.kumoh.sjjpl138.wheere.station.Station;
import kr.ac.kumoh.sjjpl138.wheere.station.repository.StationRepository;
import kr.ac.kumoh.sjjpl138.wheere.transfer.Transfer;
import kr.ac.kumoh.sjjpl138.wheere.transfer.repository.TransferRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class ReservationService {

    private final ReservationRepository reservationRepository;
    private final MemberRepository memberRepository;
    private final BusRepository busRepository;
    private final TransferRepository transferRepository;
    private final PlatformRepository platformRepository;
    private final StationRepository stationRepository;
    private final SeatRepository seatRepository;

    /**
     * 예약 생성
     * @return 생성된 Reservation 객체??
     */
    @Transactional
    public Reservation saveReservation(String memberId, Long startStationId , Long endStationId,
                                       ReservationStatus resvStatus, LocalDate resvDate,  List<SaveResvDto> busInfo) {
        Member findMember = memberRepository.findById(memberId).get();

        int busCount = busInfo.size();

        // 출발 정류장, 도착 정류장 조회
        List<Long> stationIds = List.of(startStationId, endStationId);
        List<Station> stations = stationRepository.findStationByStationIds(stationIds);
        String startStation = stations.get(0).getName();
        String endStation = stations.get(1).getName();

        Map<Long, List<Platform>> platformMap = new HashMap<>(); // bId - 출발 정류장, 도착 정류장

        // 환승 플랫폼 조회
        for (SaveResvDto dto : busInfo) {
            Long bId = dto.getBId();
            List<Long> sIdList = List.of(dto.getSStationId(), dto.getEStationId());
            List<Platform> findPlatforms = getPlatformsBySIds(bId, sIdList);
            platformMap.put(bId, findPlatforms);
        }

        /*
        버스 제약 사항 추가
         */

        // 예약 생성
        Reservation reservation = Reservation.createReservation(findMember, resvStatus, startStation, endStation, resvDate, busCount);
        reservationRepository.save(reservation);

        // Transfer 생성
        List<Long> bIdList = new ArrayList<>(platformMap.keySet());
        for (Long bId : bIdList) {
            createTransferPerPlatform(platformMap, reservation, bId);
        }

        // 해당 버스 정류장별 좌석 차감 (마지막 정류장 제외)
        for (SaveResvDto saveDto : busInfo) {
            Long startSId = saveDto.getSStationId();
            Long endSId = saveDto.getEStationId();
            Long bId = saveDto.getBId();

            List<Integer> allocationList = platformRepository.findAllocationSeqByBusIdAndStationIdList(bId, List.of(startSId, endSId));
            List<Integer> seqList = new ArrayList<>();
            for (int i = allocationList.get(0); i <= allocationList.get(1); i++ ){
                seqList.add(i);
            }

            List<Seat> findSeats = seatRepository.findSeatByBIdAndDate(bId, resvDate, seqList);
            if (findSeats.isEmpty()) {
                createSeatPerPlatform(resvDate, bId);
                List<Seat> seatsList = seatRepository.findSeatByBIdAndDate(bId, resvDate, seqList);
                calcSubLeftSeats(seatsList);
            }
            else
                calcSubLeftSeats(findSeats);
        }

        return reservation;
    }

    private void calcSubLeftSeats(List<Seat> findSeats) {
        for (int i = 0; i < findSeats.size() - 1; i++) {
            findSeats.get(i).subSeats();
        }
    }

    private void createSeatPerPlatform(LocalDate resvDate, Long bId) {
        List<Platform> platformsByBusId = platformRepository.findPlatformByBusId(bId);
        int totalSeatsNum = 2;
        for (Platform platform : platformsByBusId) {
            Seat seat = Seat.createSeat(platform, totalSeatsNum, resvDate);
            seatRepository.save(seat);
        }
    }

    private void createTransferPerPlatform(Map<Long, List<Platform>> platformMap, Reservation reservation, Long bId) {
        List<Platform> platforms = platformMap.get(bId);
        Platform startPlatform = platforms.get(0);
        Platform endPlatform = platforms.get(1);

        List<Station> findStations = getStationsByPlatform(startPlatform, endPlatform);
        String boardStation = findStations.get(0).getName();
        String alightStation = findStations.get(1).getName();

        Bus findBus = busRepository.findById(bId).get();
        Transfer transfer = Transfer.createTransfer(reservation, findBus, boardStation, alightStation);
        transferRepository.save(transfer);
    }

    private List<Station> getStationsByPlatform(Platform startPlatform, Platform endPlatform) {
        return stationRepository.findStationByPlatformId(List.of(startPlatform.getId(), endPlatform.getId()));
    }

    private List<Platform> getPlatformsBySIds(Long bId, List<Long> stationIds) {
        return platformRepository.findPlatformByBusIdAndStationId(bId, stationIds);
    }


    /**
     * 예약 취소
     */
    @Transactional
    public void cancelReservation() {

    }

    /**
     * 예약 조회
     * 조회 후 찾고자 하는 예약이 없으면 예외 발생
     * @param reservationId 예약 PK
     * @return 조회된 Reservation
     */
    public Reservation findReservationById(Long reservationId) {

        return null;
    }

    /**
     * 사용자의 예약 정보 조회
     * 필터 조건에 따라 예약 보여주기
     * 조건: 정렬 기준, 예약 상태
     * @param memberId
     * @return
     */
    public List<Reservation> findPartForMemberByCond(String memberId) {

        return new ArrayList<Reservation>();
    }

    public List<Reservation> findPartForDriver() {

        return new ArrayList<Reservation>();
    }

}
