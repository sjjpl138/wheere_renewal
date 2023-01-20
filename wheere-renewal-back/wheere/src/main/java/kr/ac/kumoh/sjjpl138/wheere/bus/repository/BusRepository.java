package kr.ac.kumoh.sjjpl138.wheere.bus.repository;

import kr.ac.kumoh.sjjpl138.wheere.bus.Bus;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDate;
import java.util.Optional;

public interface BusRepository extends JpaRepository<Bus, Long> {
    Optional<Bus> findBusByVehicleNoAndBusNoAndBusDate(String vehicleNo, String busNo, LocalDate operationDate);

    Optional<Bus> findBusByVehicleNoAndBusDate(String VehicleNo, LocalDate busDate);
}
