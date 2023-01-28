package kr.ac.kumoh.sjjpl138.wheere.seat.repository;

import kr.ac.kumoh.sjjpl138.wheere.bus.Bus;
import kr.ac.kumoh.sjjpl138.wheere.driver.Driver;
import kr.ac.kumoh.sjjpl138.wheere.platform.Platform;
import kr.ac.kumoh.sjjpl138.wheere.seat.Seat;
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
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.*;


@SpringBootTest
@Transactional
class SeatRepositoryTest {

    @PersistenceContext
    EntityManager em;

    @Autowired
    SeatRepository seatRepository;

    @BeforeEach
    public void before() {

        Station station1 = new Station(1L, "조야동");
        Station station2 = new Station(2L, "사월동");
        Station station3 = new Station(3L, "수성교");
        Station station4 = new Station(4L, "조야동");
        em.persist(station1);
        em.persist(station2);
        em.persist(station3);
        em.persist(station4);

        Bus bus = new Bus(1L,  "route1", "138안 1234", 1, "430", LocalDate.now(), "busFcmToken");
        em.persist(bus);

        Platform platform1 = new Platform(1L, station1, bus, LocalTime.of(5, 30), 1);
        Platform platform2 = new Platform(2L, station2, bus, LocalTime.of(5, 40), 2);
        Platform platform3= new Platform(3L, station3, bus, LocalTime.of(5, 50), 3);
        Platform platform4 = new Platform(4L, station4, bus, LocalTime.of(6, 0), 4);
        em.persist(platform1);
        em.persist(platform2);
        em.persist(platform3);
        em.persist(platform4);

        Seat seat1 = new Seat(platform1, 2, 2, LocalDate.of(2022, 1, 22));
        Seat seat2 = new Seat(platform2, 2, 0, LocalDate.of(2022, 1, 22));
        Seat seat3 = new Seat(platform3, 2, 2, LocalDate.of(2022, 1, 22));
        Seat seat4 = new Seat(platform4, 2, 2, LocalDate.of(2022, 1, 22));
        em.persist(seat1);
        em.persist(seat2);
        em.persist(seat3);
        em.persist(seat4);

        Driver driver = new Driver("driver1", bus, "버스기사1" , 0, 0);
        em.persist(driver);

        em.flush();
        em.clear();
    }

    @Test
    void findMinLeftSeatsByStationTest() {

        List<Integer> seqList = Arrays.asList(1, 2, 3);
        Optional<Integer> find = seatRepository.findMinLeftSeatsByStation(1L, seqList, LocalDate.of(2023, 1, 21));
        assertThat(find).isEmpty();

        Optional<Integer> min = seatRepository.findMinLeftSeatsByStation(1L, seqList, LocalDate.of(2022, 1, 22));
        Integer minLeftSeatNo = min.get();
        assertThat(minLeftSeatNo).isEqualTo(0);
    }

    @Test
   void findSeatByBIdAndDateTest() {
        // when
        List<Integer> seqList = Arrays.asList(1, 2, 3);
        List<Seat> findSeats = seatRepository.findSeatByBIdAndDate(1L, LocalDate.of(2022    , 1, 22), seqList);

        // then
        assertThat(findSeats).extracting("totalSeatsNum").containsExactly(2, 2, 2);
        assertThat(findSeats).extracting("leftSeatsNum").containsExactly(2, 0, 2);
    }
}