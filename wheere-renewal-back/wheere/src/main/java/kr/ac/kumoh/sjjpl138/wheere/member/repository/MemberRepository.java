package kr.ac.kumoh.sjjpl138.wheere.member.repository;

import kr.ac.kumoh.sjjpl138.wheere.member.Member;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MemberRepository extends JpaRepository<Member, String> {

}
