package kr.ac.kumoh.sjjpl138.wheere.member.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RetrieveRoutesRequest {

    private String sx;
    private String sy;
    private String ex;
    private String ey;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate rDate;
}
