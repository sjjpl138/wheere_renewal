package kr.ac.kumoh.sjjpl138.wheere.bus.repository;

import kr.ac.kumoh.sjjpl138.wheere.bus.Bus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface BusRepository extends JpaRepository<Bus, Long> {
    Optional<Bus> findBusByVehicleNoAndBusNoAndBusDate(String vehicleNo, String busNo, LocalDate operationDate);

    List<Bus> findByBusNo(String busNo);
    List<Bus> findByBusNoAndBusDate(String busNo, LocalDate busDate);

    List<Bus> findByIdIn(List<Long> busIds);

    @Query("select b.id from Bus b where b.busNo = :busNo")
    List<Long> findBusIdByBusNo(@Param("busNo") String busNo);

    @Query("select b.id from Bus b where b.busNo = :busNo and b.busDate = :busDate")
    List<Long> findBusIdByBusNoAndBusDate(@Param("busNo") String busNo, @Param("busDate") LocalDate busDate);
}
