package kr.ac.kumoh.sjjpl138.wheere.reservation.repository;

import kr.ac.kumoh.sjjpl138.wheere.reservation.Reservation;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ReservationRepository extends JpaRepository<Reservation, Long> {
}
