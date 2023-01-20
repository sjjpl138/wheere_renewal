package kr.ac.kumoh.sjjpl138.wheere.driver.repository;

import kr.ac.kumoh.sjjpl138.wheere.driver.Driver;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface DriverRepository extends JpaRepository<Driver, String> {
    @Query("select d from Driver d join d.bus b on b.id = :busId")
    Driver findByBusId(@Param("busId")Long busId);
}
