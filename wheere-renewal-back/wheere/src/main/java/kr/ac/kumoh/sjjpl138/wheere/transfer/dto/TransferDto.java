package kr.ac.kumoh.sjjpl138.wheere.transfer.dto;

import kr.ac.kumoh.sjjpl138.wheere.reservation.ReservationStatus;
import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class TransferDto {
    private Long rId;
    private ReservationStatus status;
    private String boardStation;
    private String alightStation;
}
