package kr.ac.kumoh.sjjpl138.wheere.reservation.api;

import kr.ac.kumoh.sjjpl138.wheere.reservation.ReservationSearchCondition;
import kr.ac.kumoh.sjjpl138.wheere.reservation.dto.ReservationListDto;
import kr.ac.kumoh.sjjpl138.wheere.reservation.repository.ReservationRepository;
import kr.ac.kumoh.sjjpl138.wheere.reservation.service.ReservationService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/resvs")
@RequiredArgsConstructor
public class ReservationApiController {

    private final ReservationService reservationService;
    private final ReservationRepository reservationRepository;

    /**
     * 예약 조회
     * @param mId 사용자ID (PK)
     * @param condition 검색 조건 (예약 상태)
     * @param pageable (size, page, sort)
     * @return ReservationListDto
     */
    @GetMapping("/{mId}")
    public ResponseEntity<Slice<ReservationListDto>> reservationList(
            @PathVariable("mId") String mId,
            ReservationSearchCondition condition,
            @PageableDefault(size=10, sort="reservationDate", direction = Sort.Direction.DESC) Pageable pageable) {

        Slice<ReservationListDto> reservations = reservationRepository.searchSlice(mId, condition, pageable);

        return new ResponseEntity<>(reservations, HttpStatus.OK);
    }
}
