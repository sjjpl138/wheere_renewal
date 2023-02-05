package kr.ac.kumoh.sjjpl138.wheere.driver.api;

import com.fasterxml.jackson.annotation.JsonProperty;
import kr.ac.kumoh.sjjpl138.wheere.driver.dto.DriverLogInRequestDto;
import kr.ac.kumoh.sjjpl138.wheere.driver.dto.DriverLoginResponseDto;
import kr.ac.kumoh.sjjpl138.wheere.driver.service.DriverService;
import kr.ac.kumoh.sjjpl138.wheere.exception.NotExistBusException;
import kr.ac.kumoh.sjjpl138.wheere.exception.NotExistDriverException;
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
    @PostMapping
    public ResponseEntity driverLogIn(@RequestBody DriverLogInRequestDto requestDto) {
        try {
            DriverLoginResponseDto responseDto = driverService.logIn(requestDto);
            return new ResponseEntity(responseDto, HttpStatus.OK);
        } catch(NotExistBusException e) {
            return new ResponseEntity(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    /**
     * 버스 기사 정보 수정
     * @param request
     * @return
     */
    @PutMapping
    public ResponseEntity driverModify(@RequestBody DriverUpdateRequest request) {
        String dId = request.getDId();
        String vNo = request.getVNo();
        String bNo = request.getBNo();
        LocalDate busDate = LocalDate.now();

        try {
            driverService.changeBus(dId, vNo, bNo, busDate);
            return new ResponseEntity(HttpStatus.OK);
        } catch (NotExistBusException | NotExistDriverException e) {
            return new ResponseEntity(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    /**
     * 버스 기사 로그아웃
     * @param driverIdRequest
     * @return
     */
    @PostMapping("/logout")
    public ResponseEntity memberLogout(@RequestBody Map<String, String> driverIdRequest) {
        String driverId = driverIdRequest.get("dId");

        try {
            driverService.logout(driverId);
            return new ResponseEntity(HttpStatus.OK);
        } catch (NotExistDriverException e) {
            return new ResponseEntity(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
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
