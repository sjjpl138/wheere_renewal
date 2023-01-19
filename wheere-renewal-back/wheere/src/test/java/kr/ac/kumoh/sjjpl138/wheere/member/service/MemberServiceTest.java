package kr.ac.kumoh.sjjpl138.wheere.member.service;

import kr.ac.kumoh.sjjpl138.wheere.bus.Bus;
import kr.ac.kumoh.sjjpl138.wheere.bus.repository.BusRepository;
import kr.ac.kumoh.sjjpl138.wheere.driver.Driver;
import kr.ac.kumoh.sjjpl138.wheere.driver.repository.DriverRepository;
import kr.ac.kumoh.sjjpl138.wheere.member.Member;
import kr.ac.kumoh.sjjpl138.wheere.member.dto.MemberDto;
import kr.ac.kumoh.sjjpl138.wheere.member.dto.RetrieveRoutesRequest;
import kr.ac.kumoh.sjjpl138.wheere.member.repository.MemberRepository;
import kr.ac.kumoh.sjjpl138.wheere.member.sub.AllCourseCase;
import kr.ac.kumoh.sjjpl138.wheere.member.sub.Course;
import kr.ac.kumoh.sjjpl138.wheere.member.sub.SubCourse;
import kr.ac.kumoh.sjjpl138.wheere.platform.Platform;
import kr.ac.kumoh.sjjpl138.wheere.reservation.Reservation;
import kr.ac.kumoh.sjjpl138.wheere.reservation.ReservationStatus;
import kr.ac.kumoh.sjjpl138.wheere.reservation.repository.ReservationRepository;
import kr.ac.kumoh.sjjpl138.wheere.station.Station;
import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.*;
import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
@Transactional
class MemberServiceTest {

    @PersistenceContext
    EntityManager em;

    @Autowired
    MemberService memberService;

    @Autowired
    MemberRepository memberRepository;

    @Autowired
    BusRepository busRepository;

    @Autowired
    ReservationRepository reservationRepository;

    @Autowired
    DriverRepository driverRepository;

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

//        Reservation reservation = new Reservation(member, bus, ReservationStatus.PAID, "조야동", "수성교", LocalDate.now());
//        em.persist(reservation);

        em.flush();
        em.clear();
    }

    @Test
    void join() {
        //given
        MemberDto member = new MemberDto("1234", "사용자", "F", LocalDate.of(2001, 8, 20), "01012341234");

        //when
        memberService.join(member);

        em.flush();
        em.clear();

        Member findMember = memberRepository.findMemberById(member.getMId());

        //then
        assertThat(findMember.getId()).isEqualTo("1234");
        assertThat(findMember.getUsername()).isEqualTo("사용자");
        assertThat(findMember.getSex()).isEqualTo("F");
        assertThat(findMember.getBirthDate()).isEqualTo(LocalDate.of(2001, 8, 20));
        assertThat(findMember.getPhoneNumber()).isEqualTo("01012341234");
    }

    @Test
    void logIn() {
        //given
        MemberDto member = new MemberDto("1234", "사용자", "F", LocalDate.of(2001, 8, 20), "01012341234");

        //when
        String id = member.getMId();
        memberService.join(member);
        memberService.logIn(id);

        em.flush();
        em.clear();

        Member findMember = memberRepository.findMemberById(id);

        //then
        assertThat(findMember.getId()).isEqualTo("1234");
        assertThat(findMember.getUsername()).isEqualTo("사용자");
        assertThat(findMember.getSex()).isEqualTo("F");
        assertThat(findMember.getBirthDate()).isEqualTo(LocalDate.of(2001, 8, 20));
        assertThat(findMember.getPhoneNumber()).isEqualTo("01012341234");
    }

    @Test
    void update() {
        //given
        MemberDto member = new MemberDto("1234", "사용자", "F", LocalDate.of(2001, 8, 20), "01012341234");
        MemberDto modifiedMember = new MemberDto("1234", "홍길동", "F", LocalDate.of(1999, 8, 24), "01099999999");

        //when
        memberService.join(member);
        memberService.update(modifiedMember);

        em.flush();
        em.clear();

        Member findMember = memberRepository.findMemberById(member.getMId());

        //then
        assertThat(findMember.getUsername()).isEqualTo("홍길동");
        assertThat(findMember.getBirthDate()).isEqualTo(LocalDate.of(1999, 8, 24));
        assertThat(findMember.getPhoneNumber()).isEqualTo("01099999999");
    }

    @Test
    void delete() {
        //given
        MemberDto member = new MemberDto("1234", "사용자", "F", LocalDate.of(2001, 8, 20), "01012341234");

        //when
        Member joinMember = memberService.join(member);
        memberService.delete(joinMember);

        em.flush();
        em.clear();

        Member findMember = memberRepository.findMemberById(member.getMId());

        //then
        assertThrows(NullPointerException.class, () -> {
            System.out.println("username = " + findMember.getUsername());
        });
    }

    @Test
    void rateDriver() {
        double rating = 4.5;
        memberService.rateDriver(1L, 1L, rating);

        Driver findDriver = driverRepository.findByBusId(1L);
        assertThat(findDriver.getRatingScore()).isEqualTo(4.5);

    }

    @Test
    void 경로조회_도시내() {

        // Given
        String sx = "128.7077189612571";
        String sy = "35.83024605453422";
        String ex = "128.67410033572702";
        String ey = "35.82704251894367";

        RetrieveRoutesRequest retrieveRoutesRequest = new RetrieveRoutesRequest(sx, sy, ex, ey, null);

        Optional<AllCourseCase> allCase = memberService.checkRoutes(retrieveRoutesRequest);

        AllCourseCase allCourseCase = allCase.get();
        List<Course> courses = allCourseCase.getCourses();

        Course course1 = courses.get(0);

        List<SubCourse> subCourses = course1.getSubCourses();

        SubCourse subCourse = subCourses.get(0);

        // Then
        assertThat(allCourseCase.getOutTrafficCheck()).isEqualTo(0);
        assertThat(courses).extracting("busTransitCount").containsExactly(1, 2);
        assertThat(courses).extracting("payment").containsExactly(1250, 1250);
        assertThat(subCourses).extracting("trafficType").containsExactly(3, 2, 3);
        assertThat(subCourses).extracting("sectionTime").containsExactly(3, 15, 9);
        assertThat(subCourse.getBusLane()).isNull();
    }

}