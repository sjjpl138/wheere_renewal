package kr.ac.kumoh.sjjpl138.wheere.fcm;

import kr.ac.kumoh.sjjpl138.wheere.fcm.service.FcmService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.io.IOException;

@Controller
@RequiredArgsConstructor
public class FcmController {

    private final FcmService fcmService;

    /**
     * @param requestDTO
     * @throws IOException

     */
    @PostMapping("/api/fcm")
    public ResponseEntity pushMessage(@RequestBody RequestDTO requestDTO) throws IOException {

        fcmService.sendRatingMessage(requestDTO.getTargetToken(), null ,null);

        return ResponseEntity.ok().build();
    }
}
