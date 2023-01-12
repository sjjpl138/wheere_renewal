package kr.ac.kumoh.sjjpl138.wheere.entity;

import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
@Getter
@NoArgsConstructor
public class Station {

    @Id @Column(name = "STATION_ID")
    private String id;

    private String name;
}
