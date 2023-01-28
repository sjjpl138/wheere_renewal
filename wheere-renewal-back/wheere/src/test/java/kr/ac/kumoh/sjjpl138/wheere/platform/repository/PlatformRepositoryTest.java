package kr.ac.kumoh.sjjpl138.wheere.platform.repository;

import kr.ac.kumoh.sjjpl138.wheere.bus.Bus;
import kr.ac.kumoh.sjjpl138.wheere.driver.Driver;
import kr.ac.kumoh.sjjpl138.wheere.member.Member;
import kr.ac.kumoh.sjjpl138.wheere.platform.Platform;
import kr.ac.kumoh.sjjpl138.wheere.platform.dto.StationDto;
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
import java.util.stream.Collectors;

import static org.assertj.core.api.Assertions.*;

@SpringBootTest
@Transactional
class PlatformRepositoryTest {

    @PersistenceContext
    EntityManager em;
    @Autowired
    PlatformRepository platformRepository;

    @BeforeEach
    public void before() {

        Member member = new Member("1234", "사용자", LocalDate.of(2001, 8, 20), "F", "01012341234", "memberFcmToken");
        em.persist(member);

        Station station1 = new Station(6L, "조야동");
        Station station2 = new Station(7L, "사월동");
        Station station3 = new Station(8L, "수성교");
        Station station4 = new Station(9L, "노원네거리");
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

        Driver driver = new Driver("driver1", bus, "버스기사1" , 0, 0);
        em.persist(driver);

        em.flush();
        em.clear();
    }

    @Test
    void findPlatformsByBus() {
        //when
        List<Platform> platformsByBus = platformRepository.findPlatformsByBus("430", "138안 1234");

        List<StationDto> route = platformsByBus.stream().map(s -> new StationDto(s)).collect(Collectors.toList());

        //then
        assertThat(route).extracting("sId").containsExactly(1L, 2L, 3L, 4L);
        assertThat(route).extracting("sName").containsExactly("조야동", "사월동", "수성교", "노원네거리");
        assertThat(route).extracting("sSeq").containsExactly(1, 2, 3, 4);
    }

    @Test
    void findAllocationSeqByBusIdAndStationIdListTest() {

        List<Long> stationIDs = Arrays.asList(4L, 2L);
        List<Integer> result = platformRepository.findAllocationSeqByBusIdAndStationIdList(1L, stationIDs);

        assertThat(result.get(0)).isEqualTo(2);
        assertThat(result.get(1)).isEqualTo(4);
    }

    @Test
    void findPlatformByBusIdAndStationIdTest() {
        // when
        List<Long> stationIds = List.of(1L, 3L);
        List<Platform> platforms = platformRepository.findPlatformByBusIdAndStationId(1L, stationIds);

        //then
        assertThat(platforms).extracting("id").containsExactly(1L, 3L);
        assertThat(platforms).extracting("stationSeq").containsExactly(1, 3);
    }

    @Test
    void findPlatformByBusTest() {
        //when
        List<Platform> platforms = platformRepository.findPlatformByBusId(1L);

        //then
        assertThat(platforms).extracting("id").containsExactly(1L, 2L, 3L, 4L);
        assertThat(platforms).extracting("stationSeq").containsExactly(1, 2, 3, 4);
    }

    @Test
    void findAllocationSeqByBusIdAndStationNameListTest() {
        // when
        List<String> stationNames = List.of("조야동", "수성교");
        List<Integer> seqList = platformRepository.findAllocationSeqByBusIdAndStationNameList(1L, stationNames);

        //then
        assertThat(seqList).containsExactly(1, 3);
    }

    @Test
    void findPlatformByIdInTest() {
        //when
        List<Platform> platforms = platformRepository.findPlatformByStationIds(List.of(6L, 7L));

        //then
        assertThat(platforms.get(0).getStation().getName()).isEqualTo("조야동");
        assertThat(platforms.get(1).getStation().getName()).isEqualTo("사월동");
        assertThat(platforms.get(0).getArrivalTime()).isEqualTo(LocalTime.of(5, 30));
        assertThat(platforms.get(1).getArrivalTime()).isEqualTo(LocalTime.of(5, 40));
    }

    @Test
    void findPlatformByIdInTest2() {

        // when
        List<Platform> platforms = platformRepository.findPlatformByIdIn(List.of(1L, 2L));
        List<Station> result = platforms.stream().map(p -> p.getStation()).collect(Collectors.toList());

        // then
        assertThat(result).extracting("id").containsExactly(6L, 7L);
    }
}