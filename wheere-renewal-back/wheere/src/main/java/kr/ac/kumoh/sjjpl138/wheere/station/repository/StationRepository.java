package kr.ac.kumoh.sjjpl138.wheere.station.repository;

import kr.ac.kumoh.sjjpl138.wheere.station.Station;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface StationRepository extends JpaRepository<Station, Long> {

    @Query("select s from Station s where s.id in :stationIds")
    List<Station> findStationByStationIds(@Param("stationIds") List<Long> stationIds);
}
