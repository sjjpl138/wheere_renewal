package kr.ac.kumoh.sjjpl138.wheere.reservation.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ReservationBusInfo {
    private Long bId;
    private Long sStationId;
    private Long eStationId;
}
