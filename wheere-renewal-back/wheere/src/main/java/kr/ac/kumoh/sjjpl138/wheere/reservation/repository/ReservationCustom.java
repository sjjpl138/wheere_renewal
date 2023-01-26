package kr.ac.kumoh.sjjpl138.wheere.reservation.repository;

import kr.ac.kumoh.sjjpl138.wheere.reservation.Reservation;
import kr.ac.kumoh.sjjpl138.wheere.reservation.request.ReservationSearchCondition;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;

public interface ReservationCustom {

    Slice<Reservation> searchSlice(String memberId, ReservationSearchCondition condition, Pageable pageable);
}
