package kr.ac.kumoh.sjjpl138.wheere.platform.service;

import kr.ac.kumoh.sjjpl138.wheere.bus.Bus;
import kr.ac.kumoh.sjjpl138.wheere.driver.Driver;
import kr.ac.kumoh.sjjpl138.wheere.exception.PlatformException;
import kr.ac.kumoh.sjjpl138.wheere.member.Member;
import kr.ac.kumoh.sjjpl138.wheere.platform.Platform;
import kr.ac.kumoh.sjjpl138.wheere.station.Station;
import org.junit.jupiter.api.Assertions;
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
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
@Transactional
class PlatformServiceTest {

    @PersistenceContext
    EntityManager em;
    @Autowired
    PlatformService platformService;

    @BeforeEach
    public void before() {

        Member member = new Member("1234", "사용자", LocalDate.of(2001, 8, 20), "F", "01012341234", "memberFcmToken");
        em.persist(member);

        Station station1 = new Station(1L, "조야동");
        Station station2 = new Station(2L, "사월동");
        Station station3 = new Station(3L, "수성교");
        Station station4 = new Station(4L, "노원네거리");
        Station station5 = new Station(5L, "station5");
        Station station6 = new Station(6L, "station6");
        em.persist(station1);
        em.persist(station2);
        em.persist(station3);
        em.persist(station4);
        em.persist(station5);
        em.persist(station6);

        Bus bus = new Bus(1L,  "route1", "138안 1234", 1, "430", LocalDate.now(), "busFcmToken");
        em.persist(bus);

        Platform platform1 = new Platform(1L, station1, bus, LocalTime.of(5, 30), 1);
        Platform platform2 = new Platform(2L, station2, bus, LocalTime.of(5, 40), 2);
        Platform platform3= new Platform(3L, station3, bus, LocalTime.of(5, 50), 3);
        Platform platform4 = new Platform(4L, station4, bus, LocalTime.of(6, 0), 4);
        Platform platform5 = new Platform(5L, station5, bus, LocalTime.of(6, 10), 5);
        Platform platform6 = new Platform(6L, station6, bus, LocalTime.of(6, 20), 6);
        em.persist(platform1);
        em.persist(platform2);
        em.persist(platform3);
        em.persist(platform4);
        em.persist(platform5);
        em.persist(platform6);

        Driver driver = new Driver("driver1", bus, "버스기사1" , 0, 0);
        em.persist(driver);

        em.flush();
        em.clear();
    }
    @Test
    void findStationNamesByStationName() {
        // Given
        String stationName = "수성교";

        // When
        List<Platform> platforms = platformService.findStationNamesByStationName(1L, stationName);
        List<Platform> platforms2 = platformService.findStationNamesByStationName(1L, "station6");

        // Then
        assertThat(platforms).extracting(Platform::getStation).extracting(Station::getName).containsExactly("조야동", "사월동", "수성교");
        assertThat(platforms2).extracting(Platform::getStation).extracting(Station::getName).containsExactly("조야동", "사월동", "수성교", "노원네거리", "station5", "station6");
        assertThatThrownBy(() -> platformService.findStationNamesByStationName(1L, "station00"))
                .isInstanceOf(PlatformException.class);
    }
}