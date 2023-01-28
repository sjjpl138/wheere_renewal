package kr.ac.kumoh.sjjpl138.wheere.member.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;

@Data
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class MemberInfoDto {

    @JsonProperty("mId")
    private String mId;
    @JsonProperty("mName")
    private String mName;
    @JsonProperty("mSex")
    private String mSex;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonProperty("mBirthDate")
    private LocalDate mBirthDate;
    @JsonProperty("mNum")
    private String mNum;
}
