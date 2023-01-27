package kr.ac.kumoh.sjjpl138.wheere.member.api;

import kr.ac.kumoh.sjjpl138.wheere.member.RetrieveRoutesResult;
import kr.ac.kumoh.sjjpl138.wheere.member.RetrieveRoutesRequest;
import kr.ac.kumoh.sjjpl138.wheere.member.service.MemberService;
import kr.ac.kumoh.sjjpl138.wheere.member.sub.AllCourseCase;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;
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
}
