package kr.ac.kumoh.sjjpl138.wheere.member.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class MemberLoginRequest {
    @JsonProperty("mId")
    private String mId;
    private String fcmToken;
}
