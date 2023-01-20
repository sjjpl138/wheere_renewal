package kr.ac.kumoh.sjjpl138.wheere.member.dto;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class MemberDto {

    private String mId;
    private String mName;
    private String mSex;
    private LocalDate mBirthDate;
    private String mNum;
}
