package kr.ac.kumoh.sjjpl138.wheere.reservation.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import kr.ac.kumoh.sjjpl138.wheere.member.Member;
import lombok.AllArgsConstructor;
import lombok.Data;

import java.time.LocalDate;

@Data
@AllArgsConstructor
public class ResvDto {
    @JsonProperty("rId")
    private long rId;
    private int startSeq;
    private int endSeq;
    private long bId;
    private ResvRequestMemberInfo member;
}
