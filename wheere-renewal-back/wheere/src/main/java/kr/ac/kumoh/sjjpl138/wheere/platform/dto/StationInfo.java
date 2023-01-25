package kr.ac.kumoh.sjjpl138.wheere.platform.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.time.LocalTime;

@Data
@AllArgsConstructor
public class StationInfo {
    private String sName;
    private LocalTime arrivalTime;
}
