package kr.ac.kumoh.sjjpl138.wheere.driver.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DriverLogInRequestDto {

    @JsonProperty("dId")
    private String driverId;
    @JsonProperty("vNo")
    private String vehicleNo;
    private int busOutNo; // 버스 차고지 출발 순서
    @JsonProperty("bNo")
    private String busNo;
}
