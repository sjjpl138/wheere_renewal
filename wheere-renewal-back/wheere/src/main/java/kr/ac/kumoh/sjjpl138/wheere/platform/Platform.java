package kr.ac.kumoh.sjjpl138.wheere.platform;

import kr.ac.kumoh.sjjpl138.wheere.route.Route;
import kr.ac.kumoh.sjjpl138.wheere.station.Station;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDate;
import java.time.LocalTime;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
public class Platform {

    @Id @Column(name = "PLATFORM_ID")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "STATION_ID")
    private Station station;

    private LocalTime arrivalTime; // 예상 도착 시간

    private int stationSeq; //정류장 순서

    private LocalDate platformDate;

    private String vehicleNo;
}
