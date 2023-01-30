package kr.ac.kumoh.sjjpl138.wheere.member.api;

import com.fasterxml.jackson.annotation.JsonProperty;
import kr.ac.kumoh.sjjpl138.wheere.member.Member;
import kr.ac.kumoh.sjjpl138.wheere.member.RetrieveRoutesResult;
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

    @PostMapping("/request-routes")
    public ResponseEntity<RetrieveRoutesResult> retrieveRoutes(@RequestBody RetrieveRoutesRequest retrieveRoutesRequest)  {

        // 모든 경우의 수 추출
        Optional<AllCourseCase> allRouteCase = memberService.checkRoutes(retrieveRoutesRequest);

        // 경우의 수가 없는 경우
        if (allRouteCase.isEmpty()) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }

        AllCourseCase allCourseCase = allRouteCase.get();
        LocalDate rDate = retrieveRoutesRequest.getRDate();
        RetrieveRoutesResult retrieveRoutesResult = memberService.checkBusTime(allCourseCase, rDate);

        return new ResponseEntity<>(retrieveRoutesResult, HttpStatus.OK);
    }

    /**
     * 사용자 추가 (회원가입)
     */
    @PostMapping
    public ResponseEntity memberAdd(@RequestBody MemberInfoDto memberDto) {
        memberService.join(memberDto);
        return new ResponseEntity(HttpStatus.OK);
    }

    /**
     * 사용자 정보 조회 (로그인)
     */
    @PostMapping("/login")
    public ResponseEntity<MemberLogInResponse> memberList(@RequestBody MemberLoginRequest member) {
        String mId = member.getMId();
        String fcmToken = member.getFcmToken();
        Member findMember = memberService.logIn(new MemberLoginRequest(mId, fcmToken));

        return new ResponseEntity<>(new MemberLogInResponse(mId, findMember.getUsername(),
                findMember.getSex(), findMember.getBirthDate(), findMember.getPhoneNumber(), fcmToken), HttpStatus.OK);
    }

    /**
     * 사용자 로그아웃
     */
    @PostMapping("/logout")
    public ResponseEntity memberLogout(@RequestBody Map<String, String> memberIdRequest) {
        String memberId = memberIdRequest.get("mId");
        memberService.logout(memberId);

        return new ResponseEntity(HttpStatus.OK);
    }

    /**
     * 사용자 정보 수정
     */
    @PutMapping
    public ResponseEntity memberModify(@RequestBody MemberInfoDto memberDto) {
        memberService.update(memberDto);
        return new ResponseEntity(HttpStatus.OK);
    }

    /**
     * 사용자 삭제 (회원탈퇴)
     */
    @DeleteMapping("/{mId}")
    public ResponseEntity memberRemove(@PathVariable("mId") String mId) {
        memberService.delete(mId);
        return new ResponseEntity(HttpStatus.OK);
    }
    
    /**
     * 평점 남기기
     */
    @PostMapping("/rate")
    public ResponseEntity memberRate(@RequestBody MemberRateRequest request) {
        memberService.rateDriver(request.rId, request.bId, request.rate);
        return new ResponseEntity(HttpStatus.OK);
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
