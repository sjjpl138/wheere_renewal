package kr.ac.kumoh.sjjpl138.wheere.bus;

import kr.ac.kumoh.sjjpl138.wheere.route.Route;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Bus {

    @Id @Column(name = "BUS_ID")
    private String id;

    private String vehicleNo; //차량 번호

    private int busAllocationSeq; //버스 배차 순번

    private String busNo; //버스 번호

    private LocalTime departureTime;  // 버스 출발 시간

    @OneToMany(mappedBy = "bus", cascade = CascadeType.REMOVE)
    private List<Route> routes = new ArrayList<>();
}
