package kr.ac.kumoh.sjjpl138.wheere.member;

import kr.ac.kumoh.sjjpl138.wheere.BaseTimeEntity;
import kr.ac.kumoh.sjjpl138.wheere.member.dto.MemberInfoDto;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.data.domain.Persistable;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.Id;
import java.time.LocalDate;

@Entity
@Getter
@EntityListeners(AuditingEntityListener.class)
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
public class Member extends BaseTimeEntity implements Persistable<String> {

    @Id
    @Column(name = "MEMBER_ID")
    private String id;

    private String username;

    private LocalDate birthDate;

    private String sex;

    private String phoneNumber;

    private String token;

    @Override
    public boolean isNew() {
        return getCreatedDate() == null;
    }

    public void updateMemberInfo(MemberInfoDto memberDto) {
        this.id = memberDto.getMId();
        this.username = memberDto.getMName();
        this.birthDate = memberDto.getMBirthDate();
        this.sex = memberDto.getMSex();
        this.phoneNumber = memberDto.getMNum();
    }

    public void registerToken(String token) {
        this.token = token;
    }
}
