package kr.ac.kumoh.sjjpl138.wheere.driver.service;

import kr.ac.kumoh.sjjpl138.wheere.bus.Bus;
import kr.ac.kumoh.sjjpl138.wheere.driver.Driver;
import kr.ac.kumoh.sjjpl138.wheere.driver.dto.DriverLogInRequestDto;
import kr.ac.kumoh.sjjpl138.wheere.driver.dto.DriverLoginResponseDto;
import kr.ac.kumoh.sjjpl138.wheere.driver.repository.DriverRepository;
import kr.ac.kumoh.sjjpl138.wheere.member.Member;
import kr.ac.kumoh.sjjpl138.wheere.member.repository.MemberRepository;
import kr.ac.kumoh.sjjpl138.wheere.platform.Platform;
import kr.ac.kumoh.sjjpl138.wheere.platform.service.PlatformService;
import kr.ac.kumoh.sjjpl138.wheere.station.Station;
import kr.ac.kumoh.sjjpl138.wheere.platform.dto.StationDto;
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

@SpringBootTest
@Transactional
class DriverServiceTest {

    @PersistenceContext
    EntityManager em;
    @Autowired
    DriverService driverService;
    @Autowired DriverRepository driverRepository;
    @Autowired
    PlatformService platformService;
    @Autowired
    MemberRepository memberRepository;

    @BeforeEach
    public void before() {

        Member member = new Member("1234", "사용자", LocalDate.of(2001, 8, 20), "F", "01012341234");
        em.persist(member);

        Station station1 = new Station(1L, "조야동");
        Station station2 = new Station(2L, "사월동");
        Station station3 = new Station(3L, "수성교");
        Station station4 = new Station(4L, "조야동");
        em.persist(station1);
        em.persist(station2);
        em.persist(station3);
        em.persist(station4);

        Bus bus = new Bus(1L, null, "route1", "138안 1234", 1, "430", LocalDate.now());
        em.persist(bus);

        Platform platform1 = new Platform(1L, station1, bus, LocalTime.of(5, 30), 1);
        Platform platform2 = new Platform(2L, station2, bus, LocalTime.of(5, 40), 2);
        Platform platform3= new Platform(3L, station3, bus, LocalTime.of(5, 50), 3);
        Platform platform4 = new Platform(4L, station4, bus, LocalTime.of(6, 0), 4);
        em.persist(platform1);
        em.persist(platform2);
        em.persist(platform3);
        em.persist(platform4);

        List<Platform> platformList = new ArrayList<>();
        platformList.add(platform1);
        platformList.add(platform2);
        platformList.add(platform3);
        platformList.add(platform4);

        bus.selectPlatforms(platformList);

        Driver driver = new Driver("driver1", bus, "버스기사1" , 0, 0);
        em.persist(driver);

        em.flush();
        em.clear();
    }

    @Test
    public void 버스기사_로그인() {

        Driver driver = driverRepository.findDriverById("driver1");
        DriverLogInRequestDto driverLoginDto = new DriverLogInRequestDto("driver1", "138안 1234", 1, "430");
        DriverLoginResponseDto logIn = driverService.logIn(driverLoginDto);

        List<StationDto> route = platformService.findRoute(driverLoginDto.getBusNo(), driverLoginDto.getVehicleNo());
        logIn.setRoute(route);

        for (StationDto stationDto : route) {
            System.out.println("================================");
            System.out.println("stationDto.getSId() = " + stationDto.getSId());
            System.out.println("stationDto.getSName() = " + stationDto.getSName());
            System.out.println("stationDto.getSSeq() = " + stationDto.getSSeq());
            System.out.println("================================");
        }
    }

}