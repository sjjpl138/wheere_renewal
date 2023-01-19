package kr.ac.kumoh.sjjpl138.wheere.reservation;

import kr.ac.kumoh.sjjpl138.wheere.BaseTimeEntity;
import kr.ac.kumoh.sjjpl138.wheere.bus.Bus;
import kr.ac.kumoh.sjjpl138.wheere.member.Member;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
public class Reservation extends BaseTimeEntity {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "RESERVATION_ID")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MEMBER_ID")
    private Member member;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "BUS_ID")
    private Bus bus;

    @Enumerated(EnumType.STRING)
    private ReservationStatus reservationStatus;

    private int busCount; // 탑승해야하는 버스 개수 (환승 구분)

    private String startStation;

    private String endStation;

    private LocalDate reservationDate;

    public void changeResvStatus() {
        this.reservationStatus = ReservationStatus.RVW_COMP;
    }
}
