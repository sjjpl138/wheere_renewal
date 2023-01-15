package kr.ac.kumoh.sjjpl138.wheere.member.repository;

import kr.ac.kumoh.sjjpl138.wheere.member.Member;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.time.LocalDate;
import java.time.LocalDateTime;


@SpringBootTest
class MemberRepositoryTest {

    @Autowired
    MemberRepository memberRepository;

    // member 저장 시 merge() 메소드가 아닌 persist() 메소드가 호출되는지 검사
    @Test
    public void save() {

        LocalDate birthDate = LocalDate.of(2000, 01, 01);

        Member member = new Member("member", "member1", birthDate, "M", "01011111111");
        
        memberRepository.save(member);
    }
}