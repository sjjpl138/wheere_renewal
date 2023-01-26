package kr.ac.kumoh.sjjpl138.wheere.reservation.service;

import kr.ac.kumoh.sjjpl138.wheere.bus.Bus;
import kr.ac.kumoh.sjjpl138.wheere.bus.repository.BusRepository;
import kr.ac.kumoh.sjjpl138.wheere.exception.ReservationException;
import kr.ac.kumoh.sjjpl138.wheere.reservation.dto.ResvDto;
import kr.ac.kumoh.sjjpl138.wheere.member.Member;
import kr.ac.kumoh.sjjpl138.wheere.member.repository.MemberRepository;
import kr.ac.kumoh.sjjpl138.wheere.platform.Platform;
import kr.ac.kumoh.sjjpl138.wheere.platform.repository.PlatformRepository;
import kr.ac.kumoh.sjjpl138.wheere.reservation.Reservation;
import kr.ac.kumoh.sjjpl138.wheere.reservation.ReservationSearchCondition;
import kr.ac.kumoh.sjjpl138.wheere.reservation.ReservationStatus;
import kr.ac.kumoh.sjjpl138.wheere.reservation.dto.ReservationBusInfo;
import kr.ac.kumoh.sjjpl138.wheere.reservation.repository.ReservationRepository;
import kr.ac.kumoh.sjjpl138.wheere.seat.Seat;
import kr.ac.kumoh.sjjpl138.wheere.seat.repository.SeatRepository;
import kr.ac.kumoh.sjjpl138.wheere.station.Station;
import kr.ac.kumoh.sjjpl138.wheere.station.repository.StationRepository;
import kr.ac.kumoh.sjjpl138.wheere.transfer.Transfer;
import kr.ac.kumoh.sjjpl138.wheere.transfer.dto.TransferDto;
import kr.ac.kumoh.sjjpl138.wheere.transfer.repository.TransferRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalTime;
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
     * @return 생성된 Reservation 객체
     */
    @Transactional
    public Reservation saveReservation(String memberId, Long startStationId, Long endStationId,
                                       ReservationStatus resvStatus, LocalDate resvDate, List<ReservationBusInfo> busInfo) {
        Member findMember = memberRepository.findById(memberId).get();

        int busCount = busInfo.size();

        // 출발 정류장, 도착 정류장 조회
        List<Long> stationIds = List.of(startStationId, endStationId);
        List<Station> stations = stationRepository.findStationByStationIds(stationIds);
        String startStation = stations.get(0).getName();
        String endStation = stations.get(1).getName();

        Map<Long, List<Platform>> platformMap = new HashMap<>(); // bId - 출발 정류장, 도착 정류장

        // 환승 플랫폼 조회
        for (ReservationBusInfo dto : busInfo) {
            Long bId = dto.getBId();
            List<Long> sIdList = List.of(dto.getSStationId(), dto.getEStationId());
            List<Platform> findPlatforms = getPlatformsBySIds(bId, sIdList);
            platformMap.put(bId, findPlatforms);

            Bus findBus = busRepository.findById(bId).get();
            // 예약하려는 버스 출발 시간이 현재 시간 이전이라면 예약 불가
            compareBusDepartureTime(findBus.getBusDate(), resvDate, findPlatforms);

            // 동일 버스에 대한 기존 예약이 존재하고 기존 예약의 상태가 취소 상태가 아니라면 예약 불가
            List<Transfer> transfers = transferRepository.findByReservation_Member_IdAndBus_IdAndReservation_ReservationDate(memberId, bId, resvDate);
            if (!transfers.isEmpty()) {
                for (Transfer transfer : transfers) {
                    List<Reservation> reservations = reservationRepository.findByTransferId(transfer.getId());
                    reservations.stream().forEach(r -> checkResvStatus(r));
                }
            }
        }

        // 예약 생성
        Reservation reservation = Reservation.createReservation(findMember, resvStatus, startStation, endStation, resvDate, busCount);
        reservationRepository.save(reservation);

        // Transfer 생성
        List<Long> bIdList = new ArrayList<>(platformMap.keySet());
        for (Long bId : bIdList) {
            createTransferPerPlatform(platformMap, reservation, bId);
        }

        // 해당 버스 정류장별 좌석 차감 (마지막 정류장 제외)
        for (ReservationBusInfo saveDto : busInfo) {
            Long bId = saveDto.getBId();
            Long startSId = saveDto.getSStationId();
            Long endSId = saveDto.getEStationId();

            List<Integer> seqList = getSeqList(bId, startSId, endSId);

            List<Seat> findSeats = seatRepository.findSeatByBIdAndDate(bId, resvDate, seqList);
            if (findSeats.isEmpty()) {
                createSeatPerPlatform(resvDate, bId);
                List<Seat> seatsList = seatRepository.findSeatByBIdAndDate(bId, resvDate, seqList);
                calcSubLeftSeats(seatsList);
            } else
                calcSubLeftSeats(findSeats);
        }

        return reservation;
    }

    private List<Integer> getSeqList(Long bId, Long startSId, Long endSId) {
        List<Integer> allocationList = platformRepository.findAllocationSeqByBusIdAndStationIdList(bId, List.of(startSId, endSId));
        List<Integer> seqList = new ArrayList<>();
        for (int i = allocationList.get(0); i <= allocationList.get(1); i++) {
            seqList.add(i);
        }
        return seqList;
    }

    private void checkResvStatus(Reservation r) {
        if (r.getReservationStatus() != ReservationStatus.CANCEL)
            throw new ReservationException("이미 해당 버스에 대한 예약이 존재합니다.");
    }

    private void compareBusDepartureTime(LocalDate busDate, LocalDate resvDate, List<Platform> findPlatforms) {
        if ((LocalTime.now().isAfter(findPlatforms.get(0).getArrivalTime()) && (!LocalDate.now().isBefore(resvDate))) || LocalDate.now().isAfter(resvDate)
                || busDate.isBefore(resvDate))
            throw new ReservationException("해당 버스에 대해 예약이 불가능합니다.");
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
    public void cancelReservation(Long rId, List<Long> bIds) {
        Reservation findResv = reservationRepository.findResvById(rId);
        findResv.changeResvStatus(ReservationStatus.CANCEL);

        // 버스 좌석 증가
        LocalDate resvDate = findResv.getReservationDate();
        for (Long bId : bIds) {
            List<Transfer> transfers = transferRepository.findByBus_IdAndReservation_Id(bId, rId);

            List<String> stationList = List.of(transfers.get(0).getBoardStation(), transfers.get(0).getAlightStation());
            List<Long> sIds = stationRepository.findStationByNames(stationList);
            
            List<Integer> allocationList = getSeqList(bId, sIds.get(0), sIds.get(1));

            List<Seat> findSeats = seatRepository.findSeatByBIdAndDate(bId, resvDate, allocationList);
            for (int i = 0; i < findSeats.size() - 1; i++) {
                findSeats.get(i).addSeats();
            }
        }
    }

    /**
     * 예약 조회
     * 조회 후 찾고자 하는 예약이 없으면 예외 발생
     * @param reservationId 예약 PK
     * @return 조회된 Reservation
     */
    public Reservation findReservationById(Long reservationId) {
        Reservation findResv = reservationRepository.findResvById(reservationId);
        if (findResv == null) {
            throw new ReservationException("예약이 존재하지 않습니다.");
        }
        return findResv;
    }

    /**
     * 사용자의 예약 정보 조회
     * 필터 조건에 따라 예약 보여주기
     * 조건: 정렬 기준, 예약 상태
     * @param memberId
     * @return
     */
    public Slice<Reservation> findPartForMemberByCond(String memberId, ReservationSearchCondition condition, Pageable pageable) {

        return reservationRepository.searchSlice(memberId, condition, pageable);
    }

    public List<ResvDto> findPartForDriver(Bus findBus) {
        List<ResvDto> resvDtoList = new ArrayList<>();
        Long bId = findBus.getId();
        List<TransferDto> transfers = transferRepository.findTransferByBusId(bId);
        for (TransferDto transfer : transfers) {
            List<Integer> allocSeqList = platformRepository.findAllocationSeqByBusIdAndStationNameList(bId, List.of(transfer.getBoardStation(), transfer.getAlightStation()));
            ResvDto resvDto = new ResvDto(transfer.getRId(), allocSeqList.get(0), allocSeqList.get(1));

            // 예약 상태가 RESERVED 혹은 PAID 인 예약만 보여줌
            ReservationStatus status = transfer.getStatus();
            if (status == ReservationStatus.RESERVED || status == ReservationStatus.PAID)
                resvDtoList.add(resvDto);
        }
        return resvDtoList;
    }
}