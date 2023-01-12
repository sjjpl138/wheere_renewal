package kr.ac.kumoh.sjjpl138.wheere.entity;

import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@Getter
@NoArgsConstructor
public class BusDriver extends BaseTimeEntity {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "BUS_DRIVER_ID")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "BUS_ID")
    private Bus bus;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "DRIVER_ID")
    private Driver driver;

    private LocalDate operationDate;

    private BusDriverStatus status; // 버스 배정 상태
}
