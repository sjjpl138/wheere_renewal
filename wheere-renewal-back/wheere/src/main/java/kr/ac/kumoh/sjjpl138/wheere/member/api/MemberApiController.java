package kr.ac.kumoh.sjjpl138.wheere.member.api;

import com.fasterxml.jackson.annotation.JsonProperty;
import kr.ac.kumoh.sjjpl138.wheere.exception.NotExistDriverException;
import kr.ac.kumoh.sjjpl138.wheere.exception.NotExistMemberException;
import kr.ac.kumoh.sjjpl138.wheere.exception.ReservationException;
import kr.ac.kumoh.sjjpl138.wheere.member.Member;
import kr.ac.kumoh.sjjpl138.wheere.member.response.RetrieveRoutesResult;
import kr.ac.kumoh.sjjpl138.wheere.member.RetrieveRoutesRequest;
import kr.ac.kumoh.sjjpl138.wheere.member.dto.MemberLoginRequest;
import kr.ac.kumoh.sjjpl138.wheere.member.dto.MemberInfoDto;
import kr.ac.kumoh.sjjpl138.wheere.member.service.MemberService;
import kr.ac.kumoh.sjjpl138.wheere.member.sub.AllCourseCase;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/members")
@RequiredArgsConstructor
public class MemberApiController {

    private final MemberService memberService;

    @ResponseStatus(HttpStatus.OK)
    @PostMapping("/request-routes")
    public RetrieveRoutesResult retrieveRoutes(@RequestBody RetrieveRoutesRequest retrieveRoutesRequest) {

        // 모든 경우의 수 추출
        Optional<AllCourseCase> allRouteCase = memberService.checkRoutes(retrieveRoutesRequest);

        // 경우의 수가 없는 경우
        if (allRouteCase.isEmpty()) {
            return new RetrieveRoutesResult();
        }

        AllCourseCase allCourseCase = allRouteCase.get();
        LocalDate rDate = retrieveRoutesRequest.getRDate();
        RetrieveRoutesResult retrieveRoutesResult = memberService.checkBusTime(allCourseCase, rDate);

        return retrieveRoutesResult;
    }

    /**
     * 사용자 추가 (회원가입)
     */
    @ResponseStatus(HttpStatus.OK)
    @PostMapping
    public void memberAdd(@RequestBody MemberInfoDto memberDto) {
        memberService.join(memberDto);
    }

    /**
     * 사용자 정보 조회 (로그인)
     */
    @PostMapping("/login")
    public ResponseEntity memberList(@RequestBody MemberLoginRequest member) {
        String mId = member.getMId();
        String fcmToken = member.getFcmToken();
        try {
            Member findMember = memberService.logIn(new MemberLoginRequest(mId, fcmToken));
            MemberLogInResponse response = new MemberLogInResponse(mId, findMember.getUsername(),
                    findMember.getSex(), findMember.getBirthDate(), findMember.getPhoneNumber(), fcmToken);

            return new ResponseEntity(response, HttpStatus.OK);
        } catch (NotExistMemberException e) {
            return new ResponseEntity(e.getMessage(), HttpStatus.BAD_REQUEST);
        }

    }

    /**
     * 사용자 로그아웃
     */
    @PostMapping("/logout")
    public ResponseEntity memberLogout(@RequestBody Map<String, String> memberIdRequest) {
        String memberId = memberIdRequest.get("mId");
        try {
            memberService.logout(memberId);
            return new ResponseEntity(HttpStatus.OK);
        } catch (NotExistMemberException e) {
            return new ResponseEntity(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    /**
     * 사용자 정보 수정
     */
    @PutMapping
    public ResponseEntity memberModify(@RequestBody MemberInfoDto memberDto) {
        try {
            memberService.update(memberDto);
            return new ResponseEntity(HttpStatus.OK);
        } catch (NotExistMemberException e) {
            return new ResponseEntity(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    /**
     * 사용자 삭제 (회원탈퇴)
     */
    @DeleteMapping("/{mId}")
    public ResponseEntity memberRemove(@PathVariable("mId") String mId) {
        try {
            memberService.delete(mId);
            return new ResponseEntity(HttpStatus.OK);
        } catch (NotExistMemberException e) {
            return new ResponseEntity(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    /**
     * 평점 남기기
     */
    @PostMapping("/rate")
    public ResponseEntity memberRate(@RequestBody MemberRateRequest request) {
        try {
            memberService.rateDriver(request.rId, request.bId, request.rate);
            return new ResponseEntity(HttpStatus.OK);
        } catch (ReservationException | NotExistDriverException e) {
            return new ResponseEntity(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }


    @Data
    @AllArgsConstructor
    static class MemberLogInResponse {
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
        @JsonProperty("fcmToken")
        private String fcmToken;
    }

    @Data
    static class MemberRateRequest {
        @JsonProperty("rId")
        private Long rId;
        @JsonProperty("bId")
        private Long bId;
        private Double rate;
    }
}
