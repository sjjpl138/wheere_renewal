package kr.ac.kumoh.sjjpl138.wheere.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import java.time.LocalDate;

@Entity
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class Member {

    @Id @Column(name = "MEMBER_ID")
    private String id;

    private String name;

    private LocalDate birthDate;

    private String sex;

    private String phoneNumber;
}
