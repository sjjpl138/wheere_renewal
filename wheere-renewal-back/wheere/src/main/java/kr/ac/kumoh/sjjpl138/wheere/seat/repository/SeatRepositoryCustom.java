package kr.ac.kumoh.sjjpl138.wheere.seat.repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface SeatRepositoryCustom {

    Optional<Integer> findMinLeftSeatsByStation(Long busId, List<Integer> seqList, LocalDate date);
}
