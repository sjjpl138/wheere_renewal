package kr.ac.kumoh.sjjpl138.wheere.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class Driver {

    @Id @Column(name = "DRIVER_ID")
    private String id;

    private String username;

    private double ratingScore;

    private int ratingCnt;
}
