package kr.ac.kumoh.sjjpl138.wheere.driver.api;

import com.fasterxml.jackson.annotation.JsonProperty;
import kr.ac.kumoh.sjjpl138.wheere.driver.dto.DriverLogInRequestDto;
import kr.ac.kumoh.sjjpl138.wheere.driver.dto.DriverLoginResponseDto;
import kr.ac.kumoh.sjjpl138.wheere.driver.service.DriverService;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.Map;

@RestController
@RequestMapping("/api/drivers")
@RequiredArgsConstructor
public class DriverApiController {
    private final DriverService driverService;

    /**
     * 버스기사 로그인
     * @param requestDto
     * @return
     */
    @ResponseStatus(HttpStatus.OK)
    @PostMapping
    public DriverLoginResponseDto driverLogIn(@RequestBody DriverLogInRequestDto requestDto) {
        DriverLoginResponseDto responseDto = driverService.logIn(requestDto);

        return responseDto;
    }

    /**
     * 버스 기사 정보 수정
     * @param request
     * @return
     */
    @ResponseStatus(HttpStatus.OK)
    @PutMapping
    public void driverModify(@RequestBody DriverUpdateRequest request) {
        String dId = request.getDId();
        String vNo = request.getVNo();
        String bNo = request.getBNo();
        LocalDate busDate = LocalDate.now();
        driverService.changeBus(dId, vNo, bNo, busDate);
    }

    @ResponseStatus(HttpStatus.OK)
    @PostMapping("/logout")
    public void memberLogout(@RequestBody Map<String, String> driverIdRequest) {
        String driverId = driverIdRequest.get("dId");
        driverService.logout(driverId);
    }

    @Data
    static class DriverUpdateRequest {
        @JsonProperty("dId")
        private String dId;
        @JsonProperty("dName")
        private String dName;
        @JsonProperty("vNo")
        private String vNo;
        @JsonProperty("bNo")
        private String bNo;
    }
}
