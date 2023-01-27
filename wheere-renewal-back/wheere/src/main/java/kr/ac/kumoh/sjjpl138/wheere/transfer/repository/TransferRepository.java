package kr.ac.kumoh.sjjpl138.wheere.transfer.repository;

import kr.ac.kumoh.sjjpl138.wheere.transfer.Transfer;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDate;
import java.util.List;

public interface TransferRepository extends JpaRepository<Transfer, Long> {

    List<Transfer> findByReservation_Member_IdAndBus_IdAndReservation_ReservationDate(String memberId, Long busId, LocalDate resvDate);
}
