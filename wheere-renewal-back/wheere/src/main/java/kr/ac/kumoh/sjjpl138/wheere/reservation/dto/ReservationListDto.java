package kr.ac.kumoh.sjjpl138.wheere.reservation.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import kr.ac.kumoh.sjjpl138.wheere.reservation.ReservationStatus;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReservationListDto {

    @JsonProperty("rId")
    private Long rId;

    @JsonProperty("rDate")
    private LocalDate rDate;

    @JsonProperty("rState")
    private ReservationStatus rState;
}
