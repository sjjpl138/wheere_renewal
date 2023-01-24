package kr.ac.kumoh.sjjpl138.wheere.reservation.api;

import kr.ac.kumoh.sjjpl138.wheere.reservation.Reservation;
import kr.ac.kumoh.sjjpl138.wheere.reservation.ReservationSearchCondition;
import kr.ac.kumoh.sjjpl138.wheere.reservation.repository.ReservationRepository;
import kr.ac.kumoh.sjjpl138.wheere.reservation.service.ReservationService;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
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

    @GetMapping("/{mId}")
    public ResponseEntity<Slice<Reservation>> reservationList(
            @PathVariable("mId") String mId,
            ReservationSearchCondition condition,
            Pageable pageable) {

        Slice<Reservation> reservations = reservationRepository.searchSlice(mId, condition, pageable);

        return new ResponseEntity<>(reservations, HttpStatus.OK);
    }
}
