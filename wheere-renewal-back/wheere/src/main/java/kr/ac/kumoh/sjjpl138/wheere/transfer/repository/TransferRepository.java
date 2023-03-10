package kr.ac.kumoh.sjjpl138.wheere.transfer.repository;

import kr.ac.kumoh.sjjpl138.wheere.reservation.Reservation;
import kr.ac.kumoh.sjjpl138.wheere.transfer.Transfer;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;

public interface TransferRepository extends JpaRepository<Transfer, Long>{

    @Query("select t from Transfer t join t.reservation r join r.member m on m.id = :memberId " +
            "join t.bus b on b.id = :busId where m.id = :memberId and r.reservationDate = :resvDate")
    List<Transfer> findByMemberIdAndBusIdAndReservationDate(@Param("memberId")String  memberId, @Param("busId") Long busId, @Param("resvDate") LocalDate resvDate);

    @Query("select t from Transfer t join t.bus b on b.id = :busId join t.reservation r on r.id = :resvId")
    List<Transfer> findByBusIdAndReservationId(@Param("busId") Long busId, @Param("resvId") Long resvId);

    @Query("select t from Transfer t join t.bus b on b.id = :busId join t.reservation r")
    List<Transfer> findTransferByBusId(@Param("busId")Long bId);

    @EntityGraph(attributePaths = {"bus"})
    List<Transfer> findWithBusByReservation(Reservation reservation);

    List<Transfer> findByReservation(Reservation reservation);
}
