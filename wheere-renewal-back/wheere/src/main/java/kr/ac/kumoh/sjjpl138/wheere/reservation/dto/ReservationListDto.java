package kr.ac.kumoh.sjjpl138.wheere.reservation.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import kr.ac.kumoh.sjjpl138.wheere.reservation.ReservationStatus;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReservationListDto {

    @JsonProperty("rId")
    private Long rId;

    @JsonProperty("rDate")
    private LocalDate rDate;
    //        private String bNo;
//        private Long routeId;
//        private String vNo;
//        private LocalTime sTime;
//        private Long sStationId;
//        private String sStationName;
//        private LocalTime eTime;
//        private Long eStationId;
//        private String eStationName;

    @JsonProperty("rState")
    private ReservationStatus rState;
}
