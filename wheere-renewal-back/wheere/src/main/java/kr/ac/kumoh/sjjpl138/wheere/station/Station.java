package kr.ac.kumoh.sjjpl138.wheere.station;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Station {

    @Id @Column(name = "STATION_ID")
    private String id;

    private String name;
}
