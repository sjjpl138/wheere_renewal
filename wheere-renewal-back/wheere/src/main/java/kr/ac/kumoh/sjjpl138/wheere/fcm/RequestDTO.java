package kr.ac.kumoh.sjjpl138.wheere.fcm;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RequestDTO {

    private String targetToken;
    private String title;
    private String body;
}
