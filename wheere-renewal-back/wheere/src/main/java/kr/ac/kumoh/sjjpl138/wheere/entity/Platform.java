package kr.ac.kumoh.sjjpl138.wheere.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalTime;

@Entity
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class Platform {

    @Id @Column(name = "PLATFORM_ID")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ROUTE_ID")
    private Route route;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "STATION_ID")
    private Station station;

    private int stationSeq; //정류장 순서

    private LocalTime arrivalTime; // 예상 도착 시간
}
