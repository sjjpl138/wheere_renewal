package kr.ac.kumoh.sjjpl138.wheere.member.service;

import kr.ac.kumoh.sjjpl138.wheere.bus.Bus;
import kr.ac.kumoh.sjjpl138.wheere.bus.repository.BusRepository;
import kr.ac.kumoh.sjjpl138.wheere.driver.Driver;
import kr.ac.kumoh.sjjpl138.wheere.member.Member;
import kr.ac.kumoh.sjjpl138.wheere.member.dto.MemberDto;
import kr.ac.kumoh.sjjpl138.wheere.member.repository.MemberRepository;
import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.time.LocalDate;
import java.time.LocalTime;

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
}