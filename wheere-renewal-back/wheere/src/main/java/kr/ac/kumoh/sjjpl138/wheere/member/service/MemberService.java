package kr.ac.kumoh.sjjpl138.wheere.member.service;

import kr.ac.kumoh.sjjpl138.wheere.member.Member;
import kr.ac.kumoh.sjjpl138.wheere.member.dto.MemberDto;
import kr.ac.kumoh.sjjpl138.wheere.member.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class MemberService {

    private final MemberRepository memberRepository;

    /**
     * 사용자 추가 (회원가입)
     * @param memberDto
     * @return
     */
    @Transactional
    public Member join(MemberDto memberDto) {

        return new Member("1", "1", LocalDate.now(), "1", "1");
    }

    /**
     * 사용자 정보 조회 (로그인)
     * @param memberId
     * @return
     */
    public Member logIn(String memberId) {

        return new Member("1", "1", LocalDate.now(), "1", "1");
    }

    /**
     * 사용자 정보 수정
     */
    @Transactional
    public void update(MemberDto memberDto) {

    }

    /**
     * 사용자 삭제 (탈퇴하기)
     * @param member
     */
    @Transactional
    public void delete(Member member) {

    }

    /**
     * 버스 기사 평점 메기기
     * @param rating
     */
    @Transactional
    public void rateDriver(double rating) {

    }
}
