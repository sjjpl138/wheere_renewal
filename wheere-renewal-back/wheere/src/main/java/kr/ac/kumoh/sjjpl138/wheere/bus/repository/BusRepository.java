package kr.ac.kumoh.sjjpl138.wheere.bus.repository;

import kr.ac.kumoh.sjjpl138.wheere.bus.Bus;
import kr.ac.kumoh.sjjpl138.wheere.platform.Platform;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.time.LocalDate;
import java.util.List;

public interface BusRepository extends JpaRepository<Bus, Long> {
    Bus findBusByVehicleNoAndBusNoAndBusDate(String vehicleNo, String busNo, LocalDate operationDate);

}
