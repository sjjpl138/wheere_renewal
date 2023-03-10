package kr.ac.kumoh.sjjpl138.wheere.reservation.service;

import com.fasterxml.jackson.annotation.JsonProperty;
import kr.ac.kumoh.sjjpl138.wheere.bus.Bus;
import kr.ac.kumoh.sjjpl138.wheere.bus.repository.BusRepository;
import kr.ac.kumoh.sjjpl138.wheere.exception.NotExistMemberException;
import kr.ac.kumoh.sjjpl138.wheere.exception.PlatformException;
import kr.ac.kumoh.sjjpl138.wheere.exception.ReservationException;
import kr.ac.kumoh.sjjpl138.wheere.reservation.dto.ResvDto;
import kr.ac.kumoh.sjjpl138.wheere.member.Member;
import kr.ac.kumoh.sjjpl138.wheere.member.repository.MemberRepository;
import kr.ac.kumoh.sjjpl138.wheere.platform.Platform;
import kr.ac.kumoh.sjjpl138.wheere.platform.repository.PlatformRepository;
import kr.ac.kumoh.sjjpl138.wheere.reservation.Reservation;
import kr.ac.kumoh.sjjpl138.wheere.reservation.dto.ResvRequestMemberInfo;
import kr.ac.kumoh.sjjpl138.wheere.reservation.request.ReservationSearchCondition;
import kr.ac.kumoh.sjjpl138.wheere.reservation.ReservationStatus;
import kr.ac.kumoh.sjjpl138.wheere.reservation.dto.ReservationBusInfo;
import kr.ac.kumoh.sjjpl138.wheere.reservation.repository.ReservationRepository;
import kr.ac.kumoh.sjjpl138.wheere.reservation.request.SaveResvRequest;
import kr.ac.kumoh.sjjpl138.wheere.reservation.response.ReservationBus;
import kr.ac.kumoh.sjjpl138.wheere.reservation.response.ReservationListResponse;
import kr.ac.kumoh.sjjpl138.wheere.seat.Seat;
import kr.ac.kumoh.sjjpl138.wheere.seat.repository.SeatRepository;
import kr.ac.kumoh.sjjpl138.wheere.station.Station;
import kr.ac.kumoh.sjjpl138.wheere.station.repository.StationRepository;
import kr.ac.kumoh.sjjpl138.wheere.transfer.Transfer;
import kr.ac.kumoh.sjjpl138.wheere.transfer.repository.TransferRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.*;
import java.util.stream.Collectors;

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
     * ?????? ??????
     * @return ????????? Reservation ??????
     */
    @Transactional
    public Reservation saveReservation(SaveResvRequest request) {

        String memberId = request.getMId();
        Long startStationId = request.getStartStationId();
        Long endStationId = request.getEndStationId();
        ReservationStatus resvStatus = request.getRState();
        LocalDate resvDate = request.getRDate();
        List<ReservationBusInfo> busInfo = request.getBuses();

        Optional<Member> findMemberOptional = memberRepository.findById(memberId);
        if (findMemberOptional.isEmpty()) {
            throw new NotExistMemberException("???????????? ?????? ??????????????????.");
        }

        Member findMember = findMemberOptional.get();
        int busCount = busInfo.size();

        // ?????? ?????? ?????????, ?????? ?????? ????????? ??????
        List<Long> stationIds = List.of(startStationId, endStationId);
        List<Station> stations = stationRepository.findStationByIdIn(stationIds);
        String startStationName = stations.get(0).getName();
        String endStationName = stations.get(1).getName();

        Map<Long, List<Platform>> platformMap = new HashMap<>(); // bId - ?????? ?????????, ?????? ?????????

        // ?????? ????????? ??????
        for (ReservationBusInfo dto : busInfo) {
            Long bId = dto.getBId();
            List<Long> sIdList = List.of(dto.getSStationId(), dto.getEStationId());
            List<Platform> findPlatforms = getPlatformsBySIds(bId, sIdList);

            // ??????????????? ?????? ?????? ????????? ?????? ?????? ??????????????? ?????? ??????
            compareNowWithReservationDateTime(resvDate, findPlatforms.get(0));

            // ?????? ????????? ???????????? ?????? Reservation ????????? ????????? ?????? ?????? - ?????? ????????? ????????????
            // memberId, resvStatus resvDate????????? ?????? ????????? ?????? Reservation ?????? ??? ?????? Reservation ????????? ?????? transfer ?????? -> ????????? ??????????????? ?????? bId??? ???????????? ????????? ?????? ??????
            List<Reservation> findReservations = reservationRepository.findCancelReservation(memberId, resvDate);
            for (Reservation findReservation : findReservations) {

                transferRepository.findByReservation(findReservation).forEach(transfer -> {
                    existThenThrowException(bId, transfer.getBus().getId());
                });
            }

            platformMap.put(bId, findPlatforms);
        }

        // ?????? ??????
        Reservation reservation = Reservation.createReservation(findMember, resvStatus, startStationName, endStationName, resvDate, busCount);
        reservationRepository.save(reservation);

        // Transfer ??????
        List<Long> bIdList = new ArrayList<>(platformMap.keySet());
        for (Long bId : bIdList) {
            createTransferPerPlatform(platformMap, reservation, bId);
        }

        // ?????? ?????? ???????????? ?????? ?????? (????????? ????????? ??????)
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

    private void existThenThrowException(Long bId, Long findBId) {
        if (bId == findBId) {
            throw new ReservationException("?????? ?????? ????????? ?????? ????????? ???????????????.");
        }
    }

    private List<Integer> getSeqList(Long bId, Long startSId, Long endSId) {
        List<Integer> allocationList = platformRepository.findAllocationSeqByBusIdAndStationIdList(bId, List.of(startSId, endSId));
        List<Integer> seqList = new ArrayList<>();
        for (int i = allocationList.get(0); i <= allocationList.get(1); i++) {
            seqList.add(i);
        }
        return seqList;
    }

    private void compareNowWithReservationDateTime(LocalDate resvDate, Platform platform) {
        if ((isNowAfterArrivalTime(platform) && isNotNowAfterResvDate(resvDate)) || isNowAfterResvDate(resvDate))
            throw new ReservationException("?????? ????????? ?????? ????????? ??????????????????.");
    }

    private boolean isNowAfterResvDate(LocalDate resvDate) {
        return LocalDate.now().isAfter(resvDate);
    }

    private boolean isNotNowAfterResvDate(LocalDate resvDate) {
        return !LocalDate.now().isAfter(resvDate); // ??????????????? ????????? ??????
    }

    private boolean isNowAfterArrivalTime(Platform platform) {
        return LocalTime.now().isAfter(platform.getArrivalTime());
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
        List<Platform> platforms = platformRepository.findPlatformByIdIn(List.of(startPlatform.getId(), endPlatform.getId()));
        return platforms.stream().map(p ->p.getStation()).collect(Collectors.toList());
    }

    private List<Platform> getPlatformsBySIds(Long bId, List<Long> stationIds) {
        List<Platform> platformList = platformRepository.findPlatformWithStationByBusIdAndStationId(bId, stationIds);
        if (platformList.size() != 2)
            throw new PlatformException("?????? ????????? ????????? ?????? ??????????????????.");
        return platformList;
    }


    /**
     * ?????? ??????
     */
    @Transactional
    public void cancelReservation(Long rId, List<Long> bIds) {
        Reservation findResv = reservationRepository.findResvById(rId);
        findResv.changeStatusToCANCEL();

        // ?????? ?????? ??????
        LocalDate resvDate = findResv.getReservationDate();
        for (Long bId : bIds) {
            List<Transfer> transfers = transferRepository.findByBusIdAndReservationId(bId, rId);

            List<String> stationList = List.of(transfers.get(0).getBoardStation(), transfers.get(0).getAlightStation());
            List<Station> findStations = stationRepository.findStationByNameIn(stationList);

            List<Integer> allocationList = getSeqList(bId, findStations.get(0).getId(), findStations.get(1).getId());

            List<Seat> findSeats = seatRepository.findSeatByBIdAndDate(bId, resvDate, allocationList);
            for (int i = 0; i < findSeats.size() - 1; i++) {
                findSeats.get(i).addSeats();
            }
        }
    }

    /**
     * ?????? ??????
     * ?????? ??? ????????? ?????? ????????? ????????? ?????? ??????
     * @param reservationId ?????? PK
     * @return ????????? Reservation
     */
    public Reservation findReservationById(Long reservationId) {
        Reservation findResv = reservationRepository.findResvById(reservationId);
        if (findResv == null) {
            throw new ReservationException("????????? ???????????? ????????????.");
        }
        return findResv;
    }

    /**
     * ???????????? ?????? ?????? ??????
     * ?????? ????????? ?????? ?????? ????????????
     * ??????: ?????? ??????, ?????? ??????
     * @param memberId
     * @return
     */
    public Slice<ReservationListResponse> findPartForMemberByCond(String memberId, ReservationSearchCondition condition, Pageable pageable) {

        Slice<Reservation> findReservations = reservationRepository.searchSlice(memberId, condition, pageable);

        Slice<ReservationListResponse> result = findReservations.map(r -> {
            ReservationListResponse reservationListResponse = new ReservationListResponse(r);

            List<ReservationBus> buses = new ArrayList<>();

            List<Transfer> findTransferList = transferRepository.findWithBusByReservation(r);
            for (Transfer transfer : findTransferList) {

                Bus findBus = transfer.getBus();

                String boardStation = transfer.getBoardStation();
                String alightStation = transfer.getAlightStation();

                List<String> stationNames = Arrays.asList(boardStation, alightStation);
                List<Platform> findPlatformList = platformRepository.findByStationNameAndBusId(stationNames, findBus.getId());

                ReservationBus reservationBus = ReservationBus.createReservationBus(findBus, findPlatformList);

                buses.add(reservationBus);
            }

            reservationListResponse.setBuses(buses);

            return reservationListResponse;
        });

        return result;
    }

    public List<ResvDto> findPartForDriver(Bus findBus) {
        List<ResvDto> resvDtoList = new ArrayList<>();
        Long bId = findBus.getId();
        List<Transfer> transfers = transferRepository.findTransferByBusId(bId);
        for (Transfer transfer : transfers) {
            List<Integer> allocSeqList = platformRepository.findAllocationSeqByBusIdAndStationNameList(bId, List.of(transfer.getBoardStation(), transfer.getAlightStation()));
            Reservation reservation = transfer.getReservation();
            Member reservedMember = reservation.getMember();
            ResvRequestMemberInfo memberInfo = new ResvRequestMemberInfo(reservedMember.getId(), reservedMember.getUsername(), reservedMember.getSex(), reservedMember.getBirthDate(), reservedMember.getPhoneNumber());
            ResvDto resvDto = new ResvDto(reservation.getId(), allocSeqList.get(0), allocSeqList.get(1), bId, memberInfo);

            // ?????? ????????? RESERVED ?????? PAID ??? ????????? ?????????
            ReservationStatus status = reservation.getReservationStatus();
            if (status == ReservationStatus.RESERVED || status == ReservationStatus.PAID)
                resvDtoList.add(resvDto);
        }
        return resvDtoList;
    }

    /**
     * ????????? ?????? ??? ?????? ??????
     *  - ?????? ?????? ??????
     */
    @Transactional
    public void changeReservationStationToRVW_WAIT(Long rId) {
        Reservation findResv = reservationRepository.findResvById(rId);
        findResv.changeStatusToRVW_WAIT();
    }
}