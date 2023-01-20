package kr.ac.kumoh.sjjpl138.wheere.reservation.repository;

import kr.ac.kumoh.sjjpl138.wheere.reservation.Reservation;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ReservationRepository extends JpaRepository<Reservation, Long> {

    List<Reservation> findByBus_Id(Long budId);
    Reservation findResvById(Long id);
}
