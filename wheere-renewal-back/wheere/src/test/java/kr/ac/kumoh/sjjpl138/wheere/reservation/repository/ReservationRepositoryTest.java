package kr.ac.kumoh.sjjpl138.wheere.reservation.repository;

import kr.ac.kumoh.sjjpl138.wheere.bus.Bus;
import kr.ac.kumoh.sjjpl138.wheere.driver.Driver;
import kr.ac.kumoh.sjjpl138.wheere.member.Member;
import kr.ac.kumoh.sjjpl138.wheere.platform.Platform;
import kr.ac.kumoh.sjjpl138.wheere.reservation.Reservation;
import kr.ac.kumoh.sjjpl138.wheere.reservation.ReservationStatus;
import kr.ac.kumoh.sjjpl138.wheere.station.Station;
import kr.ac.kumoh.sjjpl138.wheere.transfer.Transfer;
import kr.ac.kumoh.sjjpl138.wheere.transfer.repository.TransferRepository;
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
import java.util.List;

import static org.assertj.core.api.Assertions.*;

@SpringBootTest
@Transactional
class ReservationRepositoryTest {

    @PersistenceContext
    EntityManager em;

    @Autowired
    ReservationRepository reservationRepository;

    @Autowired TransferRepository transferRepository;

    @BeforeEach
    public void before() {
        Member member1 = new Member("member1", "사용자1", LocalDate.of(2000, 8, 26), "F", "01012342345");
        em.persist(member1);


        Station station1 = new Station(1L, "조야동");
        Station station2 = new Station(2L, "사월동");
        Station station3 = new Station(3L, "수성교");
        Station station4 = new Station(4L, "조야동");
        em.persist(station1);
        em.persist(station2);
        em.persist(station3);
        em.persist(station4);

        Bus bus = new Bus(1L,  "route1", "138안 1234", 1, "430", LocalDate.of(2023, 1, 24));
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
    void findByTransferTest() {
        // given
        List<Transfer> transfers = transferRepository.findAll();

        // when
        List<Reservation> reservations = reservationRepository.findByTransferId(transfers.get(0).getId());

        // then
        assertThat(reservations.get(0).getStartStation()).isEqualTo("조야동");
        assertThat(reservations.get(0).getEndStation()).isEqualTo("수성교");
    }
}