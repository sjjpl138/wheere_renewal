package kr.ac.kumoh.sjjpl138.wheere.member.service;

import kr.ac.kumoh.sjjpl138.wheere.driver.Driver;
import kr.ac.kumoh.sjjpl138.wheere.driver.repository.DriverRepository;
import kr.ac.kumoh.sjjpl138.wheere.member.Member;
import kr.ac.kumoh.sjjpl138.wheere.member.dto.MemberDto;
import kr.ac.kumoh.sjjpl138.wheere.member.repository.MemberRepository;
import kr.ac.kumoh.sjjpl138.wheere.operation.Operation;
import kr.ac.kumoh.sjjpl138.wheere.operation.repository.OperationRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.Optional;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class MemberService {

    @Value("${odsay-key}")
    private final String apiKey;

    private final MemberRepository memberRepository;
    private final OperationRepository operationRepository;
    private final DriverRepository driverRepository;

    /**
     * 사용자 추가 (회원가입)
     * @param memberDto
     * @return
     */
    @Transactional
    public Member join(MemberDto memberDto) {
        Member member = changeMemberEntity(memberDto);
        memberRepository.save(member);

        return member;
    }

    private Member changeMemberEntity(MemberDto memberDto) {
        String id = memberDto.getMId();
        String name = memberDto.getMName();
        LocalDate birthDate = memberDto.getMBirthDate();
        String sex = memberDto.getMSex();
        String  num = memberDto.getMNum();
        Member member = new Member(id, name, birthDate, sex, num);

        return member;
    }

    /**
     * 사용자 정보 조회 (로그인)
     * @param memberId
     * @return
     */
    public Member logIn(String memberId) {
        Member member = memberRepository.findMemberById(memberId);

        return member;
    }

    /**
     * 사용자 정보 수정
     */
    @Transactional
    public void update(MemberDto memberDto) {
        String id = memberDto.getMId();
        Member findMember = memberRepository.findMemberById(id);
        findMember.updateMemberInfo(memberDto);
    }

    /**
     * 사용자 삭제 (탈퇴하기)
     * @param member
     */
    @Transactional
    public void delete(Member member) {
        memberRepository.delete(member);
    }

    /**
     * 버스 기사 평점 메기기
     * @param rating
     */
    @Transactional
    public void rateDriver(double rating) {

    }
}
