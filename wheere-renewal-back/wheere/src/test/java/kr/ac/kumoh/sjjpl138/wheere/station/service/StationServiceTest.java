package kr.ac.kumoh.sjjpl138.wheere.station.service;

import kr.ac.kumoh.sjjpl138.wheere.bus.Bus;
import kr.ac.kumoh.sjjpl138.wheere.platform.Platform;
import kr.ac.kumoh.sjjpl138.wheere.platform.dto.StationInfo;
import kr.ac.kumoh.sjjpl138.wheere.station.Station;
import kr.ac.kumoh.sjjpl138.wheere.station.repository.StationRepository;
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

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
@Transactional
class StationServiceTest {

    @PersistenceContext
    EntityManager em;
    @Autowired
    StationRepository stationRepository;

    @Autowired StationService stationService;

    @BeforeEach
    public void before() {
        Station station1 = new Station(1L, "조야동");
        Station station2 = new Station(2L, "사월동");
        Station station3 = new Station(3L, "수성교");
        Station station4 = new Station(4L, "노원네거리");
        em.persist(station1);
        em.persist(station2);
        em.persist(station3);
        em.persist(station4);

        Bus bus = new Bus(1L, "route1", "138안 1234", 1, "430", LocalDate.now(), "busFcmToken");
        em.persist(bus);

        Platform platform1 = new Platform(1L, station1, bus, LocalTime.of(5, 30), 1);
        Platform platform2 = new Platform(2L, station2, bus, LocalTime.of(5, 40), 2);
        Platform platform3 = new Platform(3L, station3, bus, LocalTime.of(5, 50), 3);
        Platform platform4 = new Platform(4L, station4, bus, LocalTime.of(6, 0), 4);
        em.persist(platform1);
        em.persist(platform2);
        em.persist(platform3);
        em.persist(platform4);

        em.flush();
        em.clear();
    }

    @Test
    void findStationByPlatformAndBus() {
        // when
        List<StationInfo> infos = stationService.findStationByPlatformAndBus(List.of(1L, 2L));

        // then
        assertThat(infos).extracting("sName").containsExactly("조야동", "사월동");
        assertThat(infos).extracting("arrivalTime").containsExactly(LocalTime.of(5, 30), LocalTime.of(5, 40));
    }
}