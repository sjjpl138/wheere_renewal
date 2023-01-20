package kr.ac.kumoh.sjjpl138.wheere.seat;

import kr.ac.kumoh.sjjpl138.wheere.platform.Platform;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Seat {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "SEAT_ID")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "PLATFORM_ID")
    private Platform platform;

    private int totalSeatsNum;     // 예약 가능한 총 좌석 수

    private int leftSeatsNum;     // 예약 가능한 남은 좌석 수

    private LocalDate seatDate;

    public Seat(Platform platform, int totalSeatsNum, int leftSeatsNum, LocalDate seatDate) {
        this.platform = platform;
        this.totalSeatsNum = totalSeatsNum;
        this.leftSeatsNum = leftSeatsNum;
        this.seatDate = seatDate;
    }
}
