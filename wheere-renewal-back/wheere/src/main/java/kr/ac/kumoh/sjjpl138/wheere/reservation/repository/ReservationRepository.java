package kr.ac.kumoh.sjjpl138.wheere.reservation.repository;

import kr.ac.kumoh.sjjpl138.wheere.reservation.Reservation;
import kr.ac.kumoh.sjjpl138.wheere.reservation.ReservationStatus;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface ReservationRepository extends JpaRepository<Reservation, Long>, ReservationCustom {

    Reservation findResvById(Long id);

    @Query("select r from Reservation r join fetch Transfer as t on t.reservation.id = r.id")
    List<Reservation> findByTransferId(@Param("transferId") Long transferId);

    @EntityGraph(attributePaths = {"member"})
    Optional<Reservation> findReservationWithMemberById(Long id);

    @Query("select r from Reservation r join r.member m where m.id = :mId and r.reservationStatus <> 'CANCEL' and r.reservationDate = :rDate")
    List<Reservation> findCancelReservation(@Param("mId") String mId, @Param("rDate") LocalDate rDate);
}
