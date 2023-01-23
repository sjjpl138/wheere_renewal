package kr.ac.kumoh.sjjpl138.wheere.reservation.service;

import kr.ac.kumoh.sjjpl138.wheere.bus.Bus;
import kr.ac.kumoh.sjjpl138.wheere.driver.Driver;
import kr.ac.kumoh.sjjpl138.wheere.member.Member;
import kr.ac.kumoh.sjjpl138.wheere.platform.Platform;
import kr.ac.kumoh.sjjpl138.wheere.reservation.Reservation;
import kr.ac.kumoh.sjjpl138.wheere.reservation.ReservationStatus;
import kr.ac.kumoh.sjjpl138.wheere.reservation.dto.SaveResvDto;
import kr.ac.kumoh.sjjpl138.wheere.reservation.repository.ReservationRepository;
import kr.ac.kumoh.sjjpl138.wheere.seat.Seat;
import kr.ac.kumoh.sjjpl138.wheere.seat.repository.SeatRepository;
import kr.ac.kumoh.sjjpl138.wheere.station.Station;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

import static org.assertj.core.api.Assertions.*;

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
        em.persist(member1);
        em.persist(member2);
        em.persist(member3);
        em.persist(member4);

        Station station1 = new Station(1L, "조야동");
        Station station2 = new Station(2L, "사월동");
        Station station3 = new Station(3L, "수성교");
        Station station4 = new Station(4L, "조야동");

        Station station5 = new Station(5L, "사월역(4번출구)");
        Station station6 = new Station(6L, "경산시장");
        Station station7 = new Station(7L, "금구동(진량방향)");
        Station station8 = new Station(8L, "경일대종점건너");
        em.persist(station1);
        em.persist(station2);
        em.persist(station3);
        em.persist(station4);

        em.persist(station5);
        em.persist(station6);
        em.persist(station7);
        em.persist(station8);

        Bus bus = new Bus(1L,  "route1", "138안 1234", 1, "430", LocalDate.of(2023, 1, 24));
        Bus bus2 = new Bus(2L, "route2", "139안 5678", 1, "840", LocalDate.of(2023, 1, 24));
        em.persist(bus);
        em.persist(bus2);

        Platform platform1 = new Platform(1L, station1, bus, LocalTime.of(5, 30), 1);
        Platform platform2 = new Platform(2L, station2, bus, LocalTime.of(5, 40), 2);
        Platform platform3= new Platform(3L, station3, bus, LocalTime.of(5, 50), 3);
        Platform platform4 = new Platform(4L, station4, bus, LocalTime.of(6, 0), 4);

        Platform platform5 = new Platform(5L, station5, bus2, LocalTime.of(6, 30), 1);
        Platform platform6 = new Platform(6L, station6, bus2, LocalTime.of(6, 50), 2);
        Platform platform7 = new Platform(7L, station7, bus2, LocalTime.of(7, 10), 3);
        Platform platform8 = new Platform(8L, station8, bus2, LocalTime.of(7, 30), 4);
        em.persist(platform1);
        em.persist(platform2);
        em.persist(platform3);
        em.persist(platform4);
        em.persist(platform5);
        em.persist(platform6);
        em.persist(platform7);
        em.persist(platform8);

        Driver driver = new Driver("driver1", bus, "버스기사1" , 0, 0);
        Driver driver2 = new Driver("driver2", bus2, "버스기사2", 0, 0);
        em.persist(driver);
        em.persist(driver2);
    }

    @Test
    void 예약하기() {
        // given
        SaveResvDto save1 = new SaveResvDto(1L, 1L, 3L);
        List<SaveResvDto> busInfo1= new ArrayList<>();
        busInfo1.add(save1);

        SaveResvDto save2 = new SaveResvDto(1L, 2L, 4L);
        List<SaveResvDto> busInfo2 = new ArrayList<>();
        busInfo2.add(save2);

        // when
        Reservation reservation1 = reservationService.saveReservation("member1", 1L, 3L, ReservationStatus.PAID, LocalDate.of(2023, 1, 24), busInfo1);
        Reservation reservation2 = reservationService.saveReservation("member2", 2L, 4L, ReservationStatus.PAID, LocalDate.of(2023, 1, 24), busInfo2);

        Reservation findResv1 = reservationRepository.findResvById(reservation1.getId());
        Reservation findResv2 = reservationRepository.findResvById(reservation2.getId());

        em.flush();
        em.clear();

        // then
        assertThat(findResv1.getStartStation()).isEqualTo("조야동");
        assertThat(findResv1.getEndStation()).isEqualTo("수성교");
        assertThat(findResv1.getReservationStatus()).isEqualTo(ReservationStatus.PAID);
        assertThat(findResv1.getReservationDate()).isEqualTo(LocalDate.of(2023, 1, 24));

        assertThat(findResv2.getStartStation()).isEqualTo("사월동");
        assertThat(findResv2.getEndStation()).isEqualTo("조야동");
        assertThat(findResv2.getReservationStatus()).isEqualTo(ReservationStatus.PAID);
        assertThat(findResv2.getReservationDate()).isEqualTo(LocalDate.of(2023, 1, 24));

        // 좌석 차감 테스트
        List<Seat> seats = seatRepository.findAll();
        assertThat(seats).extracting("leftSeatsNum").containsExactly(1,0,1,2);
    }

    @Test
    void 예약하기_환승() {
        // given
        List<SaveResvDto> busInfo= new ArrayList<>();
        SaveResvDto save1 = new SaveResvDto(1L, 1L, 2L);
        SaveResvDto save2 = new SaveResvDto(2L, 5L, 8L);
        busInfo.add(save1);
        busInfo.add(save2);

        List<SaveResvDto> busInfo2= new ArrayList<>();
        SaveResvDto saveA = new SaveResvDto(1L, 1L, 2L);
        SaveResvDto saveB = new SaveResvDto(2L, 5L, 6L);
        busInfo2.add(saveA);
        busInfo2.add(saveB);

        // when
        Reservation reservation = reservationService.saveReservation("member3", 1L, 8L, ReservationStatus.PAID, LocalDate.of(2023, 1, 24), busInfo);
        Reservation reservation2 = reservationService.saveReservation("member4", 1L, 6L, ReservationStatus.RVW_WAIT, LocalDate.of(2023, 1, 24), busInfo2);

        Reservation findResv = reservationRepository.findResvById(reservation.getId());
        Reservation findResv2 = reservationRepository.findResvById(reservation2.getId());

        em.flush();
        em.clear();

        // then
        assertThat(findResv.getMember().getId()).isEqualTo("member3");
        assertThat(findResv.getReservationStatus()).isEqualTo(ReservationStatus.PAID);
        assertThat(findResv.getReservationDate()).isEqualTo(LocalDate.of(2023, 1,24));
        assertThat(findResv.getBusCount()).isEqualTo(2);

        assertThat(findResv2.getMember().getId()).isEqualTo("member4");
        assertThat(findResv2.getReservationStatus()).isEqualTo(ReservationStatus.RVW_WAIT);
        assertThat(findResv2.getReservationDate()).isEqualTo(LocalDate.of(2023, 1,24));
        assertThat(findResv2.getBusCount()).isEqualTo(2);

        List<Seat> seats = seatRepository.findAll();
        assertThat(seats).extracting("leftSeatsNum").containsExactly(0, 2, 2, 2, 0, 1, 1, 2);

    }
}