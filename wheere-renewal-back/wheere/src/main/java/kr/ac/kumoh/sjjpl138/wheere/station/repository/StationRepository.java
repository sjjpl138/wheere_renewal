package kr.ac.kumoh.sjjpl138.wheere.station.repository;

import kr.ac.kumoh.sjjpl138.wheere.seat.Seat;
import kr.ac.kumoh.sjjpl138.wheere.station.Station;
import org.springframework.data.jpa.repository.JpaRepository;

public interface StationRepository extends JpaRepository<Station, Long> {
}
