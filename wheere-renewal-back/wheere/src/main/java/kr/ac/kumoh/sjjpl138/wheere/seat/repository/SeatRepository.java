package kr.ac.kumoh.sjjpl138.wheere.seat.repository;

import kr.ac.kumoh.sjjpl138.wheere.seat.Seat;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface SeatRepository extends JpaRepository<Seat, Long>, SeatRepositoryCustom {
}
