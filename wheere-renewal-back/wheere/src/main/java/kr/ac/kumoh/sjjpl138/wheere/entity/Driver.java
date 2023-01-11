package kr.ac.kumoh.sjjpl138.wheere.entity;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
@Getter
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Driver {

    @Id @Column(name = "DRIVER_ID")
    private String id;

    private String name;

    private double ratingScore;

    private int ratingCnt;
}
