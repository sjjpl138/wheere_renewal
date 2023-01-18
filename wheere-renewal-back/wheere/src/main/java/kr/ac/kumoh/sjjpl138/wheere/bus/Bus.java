package kr.ac.kumoh.sjjpl138.wheere.bus;

import kr.ac.kumoh.sjjpl138.wheere.driver.Driver;
import kr.ac.kumoh.sjjpl138.wheere.platform.Platform;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;


@Entity
@Getter
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Bus {

    @Id @Column(name = "BUS_ID")
    private Long id;

    @OneToMany(mappedBy = "bus")
    private List<Platform> platforms = new ArrayList<>();

    @OneToOne
    @JoinColumn(name = "DRIVER_ID")
    private Driver driver;

    private String routeId;

    private String vehicleNo; //차량 번호

    private int busAllocationSeq; //버스 배차 순번

    private String busNo; //버스 번호

    private LocalDate busDate;
}
