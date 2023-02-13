package kr.ac.kumoh.sjjpl138.wheere.reservation.repository;

import kr.ac.kumoh.sjjpl138.wheere.bus.Bus;
import kr.ac.kumoh.sjjpl138.wheere.driver.Driver;
import kr.ac.kumoh.sjjpl138.wheere.member.Member;
import kr.ac.kumoh.sjjpl138.wheere.platform.Platform;
import kr.ac.kumoh.sjjpl138.wheere.reservation.Reservation;
import kr.ac.kumoh.sjjpl138.wheere.reservation.ReservationStatus;
import kr.ac.kumoh.sjjpl138.wheere.reservation.dto.ReservationBusInfo;
import kr.ac.kumoh.sjjpl138.wheere.station.Station;
import kr.ac.kumoh.sjjpl138.wheere.station.repository.StationRepository;
import org.assertj.core.api.Assertions;
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
import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
@Transactional
class ReservationRepositoryTest {

    @PersistenceContext
    EntityManager em;
    @Autowired
    ReservationRepository reservationRepository;

    @BeforeEach
    public void before() {
        String token = "1234";

        Member member1 = new Member("member1", "사용자1", LocalDate.of(2000, 8, 26), "F", "01012342345", token);
        Member member2 = new Member("member2", "사용자2", LocalDate.of(2003, 3, 5), "M", "01023331111", token);
        Member member3 = new Member("member3", "사용자3", LocalDate.of(1999, 11, 14), "F", "01012345678", token);
        Member member4 = new Member("member4", "사용자4", LocalDate.of(1986, 9, 25), "M", "01009251986", token);
        Member member5 = new Member("member5", "사용자5", LocalDate.of(1986, 9, 25), "M", "01009251986", token);

        em.persist(member1);
        em.persist(member2);
        em.persist(member3);
        em.persist(member4);
        em.persist(member5);

        Station station1 = new Station(1L, "조야동");
        Station station2 = new Station(2L, "사월동");
        Station station3 = new Station(3L, "수성교");
        Station station4 = new Station(4L, "조야동");

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
        Bus bus = new Bus(1L,  "route1", "138안 1234", 1, "430", busDate1, token);
        Bus bus2 = new Bus(2L, "route2", "139안 5678", 1, "840", busDate1, token);
        Bus bus3 = new Bus(3L, "route3", "555안 8989", 2, "509", resvDate, token);
        Bus bus4 = new Bus(4L, "route3", "777안 1212", 3, "509", busDate2, token);
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

        ReservationBusInfo save1 = new ReservationBusInfo(1L, 1L, 3L);
        List<ReservationBusInfo> busInfo1= new ArrayList<>();
        busInfo1.add(save1);

        ReservationBusInfo save2 = new ReservationBusInfo(1L, 2L, 4L);
        List<ReservationBusInfo> busInfo2 = new ArrayList<>();
        busInfo2.add(save2);

        LocalDate testDate = LocalDate.now().plusDays(1);

        // when
            /*Reservation reservation1 = reservationService.saveReservation("member1", 1L, 3L, ReservationStatus.PAID, testDate, busInfo1);
            Reservation reservation2 = reservationService.saveReservation("member2", 2L, 4L, ReservationStatus.PAID, testDate, busInfo2);*/


        LocalDate testDate1 = LocalDate.now().minusDays(30);
        LocalDate testDate2 = LocalDate.now().minusDays(25);
        LocalDate testDate3 = LocalDate.now().minusDays(20);
        LocalDate testDate4 = LocalDate.now().minusDays(19);
        LocalDate testDate5 = LocalDate.now().minusDays(18);
        LocalDate testDate6 = LocalDate.now().minusDays(17);
        LocalDate testDate7 = LocalDate.now().minusDays(16);
        LocalDate testDate8 = LocalDate.now().minusDays(6);
        LocalDate testDate9 = LocalDate.now().minusDays(4);

        em.persist(new Reservation(member1, ReservationStatus.RESERVED, "test1", "test2", testDate1, 2));
        em.persist(new Reservation(member1, ReservationStatus.CANCEL, "test1", "test2", testDate1, 2));
        em.persist(new Reservation(member1, ReservationStatus.RVW_COMP, "test1", "test2", testDate1, 2));
        em.persist(new Reservation(member1, ReservationStatus.RVW_WAIT, "test1", "test2", testDate1, 2));
        em.persist(new Reservation(member1, ReservationStatus.RVW_COMP, "test1", "test2", testDate1, 2));
        em.persist(new Reservation(member1, ReservationStatus.RVW_COMP, "test1", "test2", testDate1, 2));
        em.persist(new Reservation(member1, ReservationStatus.RESERVED, "test1", "test2", testDate1, 2));
        em.persist(new Reservation(member1, ReservationStatus.CANCEL, "test1", "test2", testDate1, 2));
        em.persist(new Reservation(member1, ReservationStatus.PAID, "test1", "test2", testDate1, 2));
    }

    @Test
    public void findCancelReservationTest() {
        List<Reservation> reservations = reservationRepository.findCancelReservation("member1", ReservationStatus.CANCEL, LocalDate.now().minusDays(30));

        assertThat(reservations.size()).isEqualTo(7);
        assertThat(reservations).extracting("reservationStatus").containsExactly(
                ReservationStatus.RESERVED,
                ReservationStatus.RVW_COMP,
                ReservationStatus.RVW_WAIT,
                ReservationStatus.RVW_COMP,
                ReservationStatus.RVW_COMP,
                ReservationStatus.RESERVED,
                ReservationStatus.PAID);

    }
}