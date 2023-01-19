package kr.ac.kumoh.sjjpl138.wheere.driver.dto;

import kr.ac.kumoh.sjjpl138.wheere.platform.dto.StationDto;
import lombok.Data;

import java.util.List;

@Data
public class DriverLoginResponseDto {

    private String dName;
    private Long bId;
    private String vNo;
    private String bNo;

    private List<StationDto> route;
    private List<ResvDto> reservations;

}
