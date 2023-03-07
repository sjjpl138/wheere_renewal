package kr.ac.kumoh.sjjpl138.wheere.reservation.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Data;

import java.time.LocalDate;

@Data
@AllArgsConstructor
public class ResvRequestMemberInfo {
    @JsonProperty("mId")
    private String mId;
    @JsonProperty("mName")
    private String mName;
    @JsonProperty("mSex")
    private String mSex;
    @JsonProperty("mBirthDate")
    private LocalDate mBirthDate;
    @JsonProperty("mNum")
    private String mNum;
}
