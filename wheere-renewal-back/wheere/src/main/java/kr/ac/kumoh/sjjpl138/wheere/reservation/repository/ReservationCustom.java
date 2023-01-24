package kr.ac.kumoh.sjjpl138.wheere.reservation.repository;

import kr.ac.kumoh.sjjpl138.wheere.reservation.ReservationSearchCondition;
import kr.ac.kumoh.sjjpl138.wheere.reservation.dto.ReservationListDto;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;

public interface ReservationCustom {

    Slice<ReservationListDto> searchSlice(String memberId, ReservationSearchCondition condition, Pageable pageable);
}
