package kr.ac.kumoh.sjjpl138.wheere.entity;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import java.time.LocalDate;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
public class Member extends BaseTimeEntity {

    @Id @Column(name = "MEMBER_ID")
    private String id;

    private String username;

    private LocalDate birthDate;

    private String sex;

    private String phoneNumber;
}
