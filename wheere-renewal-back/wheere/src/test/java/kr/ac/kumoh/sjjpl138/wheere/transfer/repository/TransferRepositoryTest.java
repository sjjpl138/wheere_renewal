package kr.ac.kumoh.sjjpl138.wheere.transfer.repository;

import kr.ac.kumoh.sjjpl138.wheere.bus.Bus;
import kr.ac.kumoh.sjjpl138.wheere.driver.Driver;
import kr.ac.kumoh.sjjpl138.wheere.member.Member;
import kr.ac.kumoh.sjjpl138.wheere.platform.Platform;
import kr.ac.kumoh.sjjpl138.wheere.reservation.Reservation;
import kr.ac.kumoh.sjjpl138.wheere.reservation.ReservationStatus;
import kr.ac.kumoh.sjjpl138.wheere.station.Station;
import kr.ac.kumoh.sjjpl138.wheere.transfer.Transfer;
import kr.ac.kumoh.sjjpl138.wheere.transfer.dto.TransferDto;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

import static org.assertj.core.api.Assertions.*;


@SpringBootTest
@Transactional
class TransferRepositoryTest {
    @PersistenceContext
    EntityManager em;

    @Autowired TransferRepository transferRepository;

    @BeforeEach
    public void before() {
        Member member1 = new Member("member1", "사용자1", LocalDate.of(2000, 8, 26), "F", "01012342345", "memberFcmToken1");
        em.persist(member1);


        Station station1 = new Station(1L, "조야동");
        Station station2 = new Station(2L, "사월동");
        Station station3 = new Station(3L, "수성교");
        Station station4 = new Station(4L, "노원네거리");
        em.persist(station1);
        em.persist(station2);
        em.persist(station3);
        em.persist(station4);

        Bus bus = new Bus(1L,  "route1", "138안 1234", 1, "430", LocalDate.of(2023, 1, 24), "busFcmToken");
        em.persist(bus);

        Platform platform1 = new Platform(1L, station1, bus, LocalTime.of(5, 30), 1);
        Platform platform2 = new Platform(2L, station2, bus, LocalTime.of(5, 40), 2);
        Platform platform3= new Platform(3L, station3, bus, LocalTime.of(5, 50), 3);
        Platform platform4 = new Platform(4L, station4, bus, LocalTime.of(6, 0), 4);
        em.persist(platform1);
        em.persist(platform2);
        em.persist(platform3);
        em.persist(platform4);

        Driver driver = new Driver("driver1", bus, "버스기사1" , 0, 0);
        em.persist(driver);

        Reservation reservation = new Reservation(member1, ReservationStatus.RESERVED, "조야동", "수성교", LocalDate.of(2023, 1, 24), 1);
        em.persist(reservation);

        Transfer transfer = new Transfer(reservation, bus, "조야동", "수성교");
        em.persist(transfer);
    }

    @Test
    void findTransferByBusAndDateAndMemberTest() {
        // when
        List<Transfer> transfers = transferRepository.findByReservation_Member_IdAndBus_IdAndReservation_ReservationDate("member1", 1L, LocalDate.of(2023, 1, 24));

        // then
        assertThat(transfers.size()).isEqualTo(1);
        assertThat(transfers.get(0).getBoardStation()).isEqualTo("조야동");
        assertThat(transfers.get(0).getAlightStation()).isEqualTo("수성교");
    }

    @Test
    void findByBus_IdAndReservation_IdTest() {
        // when
        List<Transfer> transfers = transferRepository.findByBus_IdAndReservation_Id(1L, 1L);

        // then
        assertThat(transfers.size()).isEqualTo(1);
        assertThat(transfers.get(0).getBoardStation()).isEqualTo("조야동");
        assertThat(transfers.get(0).getAlightStation()).isEqualTo("수성교");
    }

    @Test
    void findTransferByBusIdTest() {
        // when
        List<TransferDto> dtos = transferRepository.findTransferByBusId(1L);

        // then
        assertThat(dtos).extracting("status").containsExactly(ReservationStatus.RESERVED);
        assertThat(dtos).extracting("boardStation").containsExactly("조야동");
        assertThat(dtos).extracting("alightStation").containsExactly("수성교");
    }
}