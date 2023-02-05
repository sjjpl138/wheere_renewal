package kr.ac.kumoh.sjjpl138.wheere.transfer;

import kr.ac.kumoh.sjjpl138.wheere.bus.Bus;
import kr.ac.kumoh.sjjpl138.wheere.reservation.Reservation;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
public class Transfer {

    @Id
    @GeneratedValue
    @Column(name = "TRANSFER_ID")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "RESERVATION_ID")
    private Reservation reservation;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "BUS_ID")
    private Bus bus;

    private String boardStation;

    private String alightStation;

    public Transfer(Reservation reservation, Bus bus, String boardStation, String alightStation) {
        this.alightStation = alightStation;
        this.reservation = reservation;
        this.bus = bus;
        this.boardStation = boardStation;
    }

    public static Transfer createTransfer(Reservation reservation, Bus bus, String boardStation, String alightStation) {
        return new Transfer(reservation, bus, boardStation, alightStation);
    }
}
