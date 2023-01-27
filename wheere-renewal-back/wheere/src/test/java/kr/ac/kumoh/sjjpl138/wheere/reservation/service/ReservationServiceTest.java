package kr.ac.kumoh.sjjpl138.wheere.reservation.service;

import kr.ac.kumoh.sjjpl138.wheere.bus.Bus;
import kr.ac.kumoh.sjjpl138.wheere.driver.Driver;
import kr.ac.kumoh.sjjpl138.wheere.exception.NotEnoughSeatsException;
import kr.ac.kumoh.sjjpl138.wheere.exception.PlatformException;
import kr.ac.kumoh.sjjpl138.wheere.member.Member;
import kr.ac.kumoh.sjjpl138.wheere.platform.Platform;
import kr.ac.kumoh.sjjpl138.wheere.reservation.Reservation;
import kr.ac.kumoh.sjjpl138.wheere.reservation.request.ReservationSearchCondition;
import kr.ac.kumoh.sjjpl138.wheere.reservation.ReservationStatus;
import kr.ac.kumoh.sjjpl138.wheere.reservation.dto.ReservationBusInfo;
import kr.ac.kumoh.sjjpl138.wheere.reservation.repository.ReservationRepository;
import kr.ac.kumoh.sjjpl138.wheere.reservation.response.ReservationListResponse;
import kr.ac.kumoh.sjjpl138.wheere.seat.Seat;
import kr.ac.kumoh.sjjpl138.wheere.seat.repository.SeatRepository;
import kr.ac.kumoh.sjjpl138.wheere.station.Station;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Slice;
import org.springframework.data.domain.Sort;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

import static org.assertj.core.api.Assertions.*;
import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
@Transactional
class ReservationServiceTest {

    @PersistenceContext
    EntityManager em;

    @Autowired
    ReservationService reservationService;

    @Autowired
    ReservationRepository reservationRepository;

    @Autowired
    SeatRepository seatRepository;

    @BeforeEach
    public void before() {
        Member member1 = new Member("member1", "사용자1", LocalDate.of(2000, 8, 26), "F", "01012342345");
        Member member2 = new Member("member2", "사용자2", LocalDate.of(2003, 3, 5), "M", "01023331111");
        Member member3 = new Member("member3", "사용자3", LocalDate.of(1999, 11, 14), "F", "01012345678");
        Member member4 = new Member("member4", "사용자4", LocalDate.of(1986, 9, 25), "M", "01009251986");
        Member member5 = new Member("member5", "사용자5", LocalDate.of(1986, 9, 25), "M", "01009251986");

        em.persist(member1);
        em.persist(member2);
        em.persist(member3);
        em.persist(member4);
        em.persist(member5);

        Station station1 = new Station(1L, "조야동");
        Station station2 = new Station(2L, "사월동");
        Station station3 = new Station(3L, "수성교");
        Station station4 = new Station(4L, "노원네거리");

        Station station5 = new Station(5L, "사월역(4번출구)");
        Station station6 = new Station(6L, "경산시장");
        Station station7 = new Station(7L, "금구동(진량방향)");
        Station station8 = new Station(8L, "경일대종점건너");

        Station station9 = new Station(9L, "신흥버스");
        Station station10 = new Station(10L, "대구가톨릭대학병원앞");
        Station station11 = new Station(11L, "엑스코앞");
        Station station12 = new Station(12L, "두류역(달성고둥학교앞)");
        em.persist(station1);
        em.persist(station2);
        em.persist(station3);
        em.persist(station4);

        em.persist(station5);
        em.persist(station6);
        em.persist(station7);
        em.persist(station8);

        em.persist(station9);
        em.persist(station10);
        em.persist(station11);
        em.persist(station12);

        LocalDate busDate1 = LocalDate.now().plusDays(3);
        LocalDate busDate2 = LocalDate.now().minusDays(3);
        LocalDate resvDate = LocalDate.now();
        Bus bus = new Bus(1L,  "route1", "138안 1234", 1, "430", busDate1);
        Bus bus2 = new Bus(2L, "route2", "139안 5678", 1, "840", busDate1);
        Bus bus3 = new Bus(3L, "route3", "555안 8989", 2, "509", resvDate);
        Bus bus4 = new Bus(4L, "route3", "777안 1212", 3, "509", busDate2);
        em.persist(bus);
        em.persist(bus2);
        em.persist(bus3);
        em.persist(bus4);

        LocalTime arrivalTime1 = LocalTime.now().plusMinutes(5);
        LocalTime arrivalTime2 = LocalTime.now().minusHours(1);
        Platform platform1 = new Platform(1L, station1, bus, arrivalTime1, 1);
        Platform platform2 = new Platform(2L, station2, bus, arrivalTime1.plusMinutes(10), 2);
        Platform platform3= new Platform(3L, station3, bus, arrivalTime1.plusMinutes(20), 3);
        Platform platform4 = new Platform(4L, station4, bus, arrivalTime1.plusMinutes(30), 4);

        Platform platform5 = new Platform(5L, station5, bus2, arrivalTime1, 1);
        Platform platform6 = new Platform(6L, station6, bus2, arrivalTime1.plusMinutes(5), 2);
        Platform platform7 = new Platform(7L, station7, bus2, arrivalTime1.plusMinutes(10), 3);
        Platform platform8 = new Platform(8L, station8, bus2, arrivalTime1.plusMinutes(15), 4);

        Platform platform9 = new Platform(9L, station9, bus3, arrivalTime2, 1);
        Platform platform10 = new Platform(10L, station10, bus3, arrivalTime2.plusMinutes(10), 2);
        Platform platform11 = new Platform(11L, station11, bus3, arrivalTime2.plusMinutes(20), 3);
        Platform platform12 = new Platform(12L, station12, bus3, arrivalTime2.plusMinutes(30), 4);

        Platform platform13 = new Platform(13L, station9, bus4, arrivalTime1, 1);
        Platform platform14 = new Platform(14L, station10, bus4, arrivalTime1.plusMinutes(1), 2);
        Platform platform15 = new Platform(15L, station11, bus4, arrivalTime1.plusMinutes(3), 3);
        Platform platform16 = new Platform(16L, station12, bus4, arrivalTime1.plusMinutes(5), 4);

        em.persist(platform1);
        em.persist(platform2);
        em.persist(platform3);
        em.persist(platform4);

        em.persist(platform5);
        em.persist(platform6);
        em.persist(platform7);
        em.persist(platform8);

        em.persist(platform9);
        em.persist(platform10);
        em.persist(platform11);
        em.persist(platform12);

        em.persist(platform13);
        em.persist(platform14);
        em.persist(platform15);
        em.persist(platform16);

        Driver driver = new Driver("driver1", bus, "버스기사1" , 0, 0);
        Driver driver2 = new Driver("driver2", bus2, "버스기사2", 0, 0);
        Driver driver3 = new Driver("driver3", bus3, "버스기사3", 0, 0);
        Driver driver4 = new Driver("driver4", bus4, "버스기사4", 0, 0);
        em.persist(driver);
        em.persist(driver2);
        em.persist(driver3);
        em.persist(driver4);
    }

    @Test
    void 예약하기() {
        // given
        ReservationBusInfo save1 = new ReservationBusInfo(1L, 1L, 3L);
        List<ReservationBusInfo> busInfo1= new ArrayList<>();
        busInfo1.add(save1);

        ReservationBusInfo save2 = new ReservationBusInfo(1L, 2L, 4L);
        List<ReservationBusInfo> busInfo2 = new ArrayList<>();
        busInfo2.add(save2);

        LocalDate resvDate = LocalDate.now().plusDays(1);

        // when
        Reservation reservation1 = reservationService.saveReservation("member1", 1L, 3L, ReservationStatus.PAID, resvDate, busInfo1);
        Reservation reservation2 = reservationService.saveReservation("member2", 2L, 4L, ReservationStatus.PAID, resvDate, busInfo2);

        Reservation findResv1 = reservationRepository.findResvById(reservation1.getId());
        Reservation findResv2 = reservationRepository.findResvById(reservation2.getId());

        em.flush();
        em.clear();

        // then
        assertThat(findResv1.getStartStation()).isEqualTo("조야동");
        assertThat(findResv1.getEndStation()).isEqualTo("수성교");
        assertThat(findResv1.getReservationStatus()).isEqualTo(ReservationStatus.PAID);
        assertThat(findResv1.getReservationDate()).isEqualTo(resvDate);

        assertThat(findResv2.getStartStation()).isEqualTo("사월동");
        assertThat(findResv2.getEndStation()).isEqualTo("노원네거리");
        assertThat(findResv2.getReservationStatus()).isEqualTo(ReservationStatus.PAID);
        assertThat(findResv2.getReservationDate()).isEqualTo(resvDate);

        // 좌석 차감 테스트
        List<Seat> seats = seatRepository.findAll();
        assertThat(seats).extracting("leftSeatsNum").containsExactly(1,0,1,2);
    }

    @Test
    void 예약하기_환승() {
        // given
        List<ReservationBusInfo> busInfo= new ArrayList<>();
        ReservationBusInfo save1 = new ReservationBusInfo(1L, 1L, 2L);
        ReservationBusInfo save2 = new ReservationBusInfo(2L, 5L, 8L);
        busInfo.add(save1);
        busInfo.add(save2);

        List<ReservationBusInfo> busInfo2= new ArrayList<>();
        ReservationBusInfo saveA = new ReservationBusInfo(1L, 1L, 2L);
        ReservationBusInfo saveB = new ReservationBusInfo(2L, 5L, 6L);
        busInfo2.add(saveA);
        busInfo2.add(saveB);

        LocalDate resvDate = LocalDate.now().plusDays(1);

        // when
        Reservation reservation = reservationService.saveReservation("member3", 1L, 8L, ReservationStatus.PAID, resvDate, busInfo);
        Reservation reservation2 = reservationService.saveReservation("member4", 1L, 6L, ReservationStatus.RVW_WAIT, resvDate, busInfo2);

        Reservation findResv = reservationRepository.findResvById(reservation.getId());
        Reservation findResv2 = reservationRepository.findResvById(reservation2.getId());

        em.flush();
        em.clear();

        // then
        assertThat(findResv.getMember().getId()).isEqualTo("member3");
        assertThat(findResv.getReservationStatus()).isEqualTo(ReservationStatus.PAID);
        assertThat(findResv.getReservationDate()).isEqualTo(resvDate);
        assertThat(findResv.getBusCount()).isEqualTo(2);

        assertThat(findResv2.getMember().getId()).isEqualTo("member4");
        assertThat(findResv2.getReservationStatus()).isEqualTo(ReservationStatus.RVW_WAIT);
        assertThat(findResv2.getReservationDate()).isEqualTo(resvDate);
        assertThat(findResv2.getBusCount()).isEqualTo(2);

        List<Seat> seats = seatRepository.findAll();
        assertThat(seats).extracting("leftSeatsNum").containsExactly(0, 2, 2, 2, 0, 1, 1, 2);
    }

    @Test
    void 예약하기_예외() {
        // given
        ReservationBusInfo save = new ReservationBusInfo(1L, 1L, 3L);
        List<ReservationBusInfo> busInfo= new ArrayList<>();
        busInfo.add(save);

        ReservationBusInfo save3 = new ReservationBusInfo(3L, 10L, 12L);
        List<ReservationBusInfo> busInfo3= new ArrayList<>();
        busInfo3.add(save3);

        ReservationBusInfo save4 = new ReservationBusInfo(4L, 10L, 11L);
        List<ReservationBusInfo> busInfo4= new ArrayList<>();
        busInfo4.add(save4);

        LocalDate resvDate = LocalDate.now().plusDays(1);

        // when
        reservationService.saveReservation("member1", 1L, 3L, ReservationStatus.RVW_WAIT, resvDate, busInfo);
        reservationService.saveReservation("member2", 1L, 3L, ReservationStatus.RVW_WAIT, resvDate, busInfo);

        // then
        // 남은 좌석이 없는 경우
        assertThrows(NotEnoughSeatsException.class, () ->
                reservationService.saveReservation("member5", 1L, 3L, ReservationStatus.RVW_WAIT, resvDate, busInfo));

        // 이미 예약이 존재하는 경우
        assertThrows(IllegalStateException.class, () ->
                reservationService.saveReservation("member1", 1L, 3L, ReservationStatus.RESERVED, resvDate, busInfo));

        // 버스 운행 시간 지난 경우
        // busDate -> now()
        // resvDate -> now()
        // busArrivalTime -> now().minusHours(1)
        assertThrows(IllegalStateException.class, () ->
                reservationService.saveReservation("member3", 10L, 12L, ReservationStatus.RESERVED, resvDate.minusDays(1), busInfo3));

        // 버스 운행 날짜 지난 경우
        // busDate -> now().minusDays(3)
        // resvDate -> now().plusDays(1)
        assertThrows(IllegalStateException.class, () ->
                reservationService.saveReservation("member4", 10L, 11L, ReservationStatus.RVW_WAIT, resvDate, busInfo4));

    }

    @Test
    void 예약_취소() {
        // given
        List<ReservationBusInfo> busInfo= new ArrayList<>();
        ReservationBusInfo save1 = new ReservationBusInfo(1L, 2L, 4L);
        ReservationBusInfo save2 = new ReservationBusInfo(2L, 5L, 8L);
        busInfo.add(save1);
        busInfo.add(save2);

        LocalDate resvDate = LocalDate.now().plusDays(1);

        Reservation reservation = reservationService.saveReservation("member5", 2L, 8L, ReservationStatus.RVW_WAIT, resvDate, busInfo);

        // when
        Long rId = reservation.getId();
        reservationService.cancelReservation(rId, List.of(1L, 2L));

        em.flush();
        em.clear();

        Reservation findResv = reservationRepository.findResvById(rId);
        List<Seat> seats  = seatRepository.findAll();

        // then
        assertThat(findResv.getReservationStatus()).isEqualTo(ReservationStatus.CANCEL);
        assertThat(seats).extracting("leftSeatsNum").containsExactly(2, 2, 2, 2, 2, 2, 2, 2);
    }

    @Test
    void 예약조회() {

        // given
        Member member100 = new Member("member100", "사용자100", LocalDate.of(2000, 8, 26), "F", "01012342345");
        em.persist(member100);

        LocalDate testDate1 = LocalDate.now().minusDays(30);
        LocalDate testDate2 = LocalDate.now().minusDays(25);
        LocalDate testDate3 = LocalDate.now().minusDays(20);
        LocalDate testDate4 = LocalDate.now().minusDays(19);
        LocalDate testDate5 = LocalDate.now().minusDays(18);
        LocalDate testDate6 = LocalDate.now().minusDays(17);
        LocalDate testDate7 = LocalDate.now().minusDays(16);
        LocalDate testDate8 = LocalDate.now().minusDays(6);
        LocalDate testDate9 = LocalDate.now().minusDays(4);

        Reservation reservation1 = new Reservation(member100, ReservationStatus.RESERVED, "test1", "test2", testDate1, 2);
        Reservation reservation2 = new Reservation(member100, ReservationStatus.CANCEL, "test1", "test2", testDate2, 2);
        Reservation reservation3 = new Reservation(member100, ReservationStatus.RVW_COMP, "test1", "test2", testDate3, 2);
        Reservation reservation4 = new Reservation(member100, ReservationStatus.RVW_WAIT, "test1", "test2", testDate4, 2);
        Reservation reservation5 = new Reservation(member100, ReservationStatus.RVW_COMP, "test1", "test2", testDate5, 2);
        Reservation reservation6 = new Reservation(member100, ReservationStatus.RVW_COMP, "test1", "test2", testDate6, 2);
        Reservation reservation7 = new Reservation(member100, ReservationStatus.RESERVED, "test1", "test2", testDate7, 2);
        Reservation reservation8 = new Reservation(member100, ReservationStatus.CANCEL, "test1", "test2", testDate8, 2);
        Reservation reservation9 = new Reservation(member100, ReservationStatus.PAID, "test1", "test2", testDate9, 2);

        em.persist(reservation1);
        em.persist(reservation2);
        em.persist(reservation3);
        em.persist(reservation4);
        em.persist(reservation5);
        em.persist(reservation6);
        em.persist(reservation7);
        em.persist(reservation8);
        em.persist(reservation9);

        ReservationSearchCondition condition1 = new ReservationSearchCondition("RESERVED");
        ReservationSearchCondition condition2 = new ReservationSearchCondition("PAID");
        ReservationSearchCondition condition3 = new ReservationSearchCondition(null);

        PageRequest page1 = PageRequest.of(0, 4);
        PageRequest page2 = PageRequest.of(0, 1, Sort.by(Sort.Direction.ASC, "reservationDate"));

        // when
        Slice<ReservationListResponse> slice1 = reservationService.findPartForMemberByCond("member100", condition1, page1);
        List<ReservationListResponse> result1 = slice1.getContent();

        Slice<ReservationListResponse> slice2 = reservationService.findPartForMemberByCond("member100", condition2, page2);
        List<ReservationListResponse> result2 = slice2.getContent();

        Slice<ReservationListResponse> slice3 = reservationService.findPartForMemberByCond("member100", condition3, page2);
        List<ReservationListResponse> result3 = slice3.getContent();

        // then
        assertThat(result1).extracting("rId").containsExactly(reservation1.getId(), reservation7.getId());
        assertThat(result2).extracting("rId").containsExactly(reservation9.getId());
        assertThat(result3).extracting("rId").containsExactly(reservation1.getId());



    }

    @Test
    void 플랫폼예외테스트() {
        // given
        ReservationBusInfo save = new ReservationBusInfo(1L, 1L, 10L);
        List<ReservationBusInfo> busInfo= new ArrayList<>();
        busInfo.add(save);

        LocalDate resvDate = LocalDate.now().plusDays(1);

        // then
        Assertions.assertThrows(PlatformException.class, () ->
                reservationService.saveReservation("member1", 1L, 10L, ReservationStatus.RVW_WAIT, resvDate, busInfo));
    }
}