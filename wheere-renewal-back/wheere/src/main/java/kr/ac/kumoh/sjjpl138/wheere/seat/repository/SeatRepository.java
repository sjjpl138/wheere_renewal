package kr.ac.kumoh.sjjpl138.wheere.seat.repository;

import kr.ac.kumoh.sjjpl138.wheere.seat.Seat;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import javax.swing.text.html.Option;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;


public interface SeatRepository extends JpaRepository<Seat, Long>, SeatRepositoryCustom {

    @Query("select s from Seat s join s.platform p on p.bus.id = :busId and p.stationSeq in :seqList where s.seatDate = :resvDate")
    List<Seat> findSeatByBIdAndDate(@Param("busId") Long busId, @Param("resvDate") LocalDate resvDate, @Param("seqList") List<Integer> seqList);

    @Query("select min(s.leftSeatsNum) from Seat s join s.platform p on p.bus.id = :busId and p.stationSeq in :seqList where s.seatDate = :resvDate")
    Optional<Integer> findMinLeftSeatsByBusIdAndDateAndSeqIn(@Param("busId") Long busId, @Param("resvDate") LocalDate resvDate, @Param("seqList") List<Integer> seqList);
}
