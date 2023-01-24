package kr.ac.kumoh.sjjpl138.wheere.reservation.repository;

import kr.ac.kumoh.sjjpl138.wheere.reservation.Reservation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ReservationRepository extends JpaRepository<Reservation, Long> {

    Reservation findResvById(Long id);

    @Query("select r from Reservation r join fetch Transfer as t on t.reservation.id = r.id")
    List<Reservation> findByTransferId(@Param("transferId") Long transferId);
}
