package kr.ac.kumoh.sjjpl138.wheere.reservation.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ResvDto {
    @JsonProperty("rId")
    private Long rId;
    private int startSeq;
    private int endSeq;

}
