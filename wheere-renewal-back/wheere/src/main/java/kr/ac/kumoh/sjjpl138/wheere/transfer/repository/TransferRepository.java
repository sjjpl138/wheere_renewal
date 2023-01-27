package kr.ac.kumoh.sjjpl138.wheere.transfer.repository;

import kr.ac.kumoh.sjjpl138.wheere.reservation.Reservation;
import kr.ac.kumoh.sjjpl138.wheere.transfer.Transfer;
import kr.ac.kumoh.sjjpl138.wheere.transfer.dto.TransferDto;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;

public interface TransferRepository extends JpaRepository<Transfer, Long> {

    List<Transfer> findByReservation_Member_IdAndBus_IdAndReservation_ReservationDate(String memberId, Long busId, LocalDate resvDate);

    List<Transfer> findByBus_IdAndReservation_Id(Long busId, Long resvId);

    @Query("select new kr.ac.kumoh.sjjpl138.wheere.transfer.dto.TransferDto(r.id, r.reservationStatus, t.boardStation, t.alightStation) from Transfer t join t.bus b on b.id = :busId join t.reservation r")
    List<TransferDto> findTransferByBusId(@Param("busId")Long bId);

    @EntityGraph(attributePaths = {"bus"})
    List<Transfer> findByReservation(Reservation reservation);
}
