package kr.ac.kumoh.sjjpl138.wheere.driver.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.time.LocalDate;

@Data
@AllArgsConstructor
public class DriverLogInRequestDto {
    private String driverId;
    private String vehicleNo;
    private int busOutNo; // 버스 차고지 출발 순서
    private String busNo;
}
