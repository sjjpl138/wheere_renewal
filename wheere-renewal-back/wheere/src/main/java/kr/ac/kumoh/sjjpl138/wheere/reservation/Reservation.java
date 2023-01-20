package kr.ac.kumoh.sjjpl138.wheere.reservation;

import kr.ac.kumoh.sjjpl138.wheere.BaseTimeEntity;
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

    @Enumerated(EnumType.STRING)
    private ReservationStatus reservationStatus;

    private String startStation;

    private String endStation;

    private LocalDate reservationDate;


    private int busCount; // 탑승할 버스 개수

    public void changeResvStatus() {
        this.reservationStatus = ReservationStatus.RVW_COMP;
    }

}
