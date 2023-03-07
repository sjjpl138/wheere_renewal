package kr.ac.kumoh.sjjpl138.wheere.seat;

import kr.ac.kumoh.sjjpl138.wheere.exception.NotEnoughSeatsException;
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

    public static Seat createSeat(Platform platform, int totalSeatsNum, LocalDate seatDate) {
        return new Seat(platform, totalSeatsNum, totalSeatsNum, seatDate);
    }

    public void subSeats() {
        int restSeats = this.leftSeatsNum - 1;
        if (restSeats < 0)
            throw new NotEnoughSeatsException("남은 좌석이 없습니다.");

        this.leftSeatsNum = restSeats;
    }

    public void addSeats() {
        int restSeats = this.leftSeatsNum + 1;
        if (restSeats <= totalSeatsNum) {
            this.leftSeatsNum = restSeats;
        }
    }
}
