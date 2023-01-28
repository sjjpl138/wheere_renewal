package kr.ac.kumoh.sjjpl138.wheere.station.repository;

import kr.ac.kumoh.sjjpl138.wheere.platform.dto.StationInfo;
import kr.ac.kumoh.sjjpl138.wheere.station.Station;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface StationRepository extends JpaRepository<Station, Long> {

    @Query("select s from Station s where s.id in :stationIds")
    List<Station> findStationByStationIds(@Param("stationIds") List<Long> stationIds);

    @Query("select s from Platform p join p.station s where  p.id in :platformId")
    List<Station> findStationByPlatformId(@Param("platformId") List<Long> platformIds);

    @Query("select s from Platform p join p.station s join p.bus b where b.id = :busId")
    List<Station> findStationByBusId(@Param("busId") Long busId);

    @Query("select s.id from Station s where s.name in :sNames")
    List<Long> findStationByNames(@Param("sNames") List<String> sNames);

    @Query("select new kr.ac.kumoh.sjjpl138.wheere.platform.dto.StationInfo(s.name, p.arrivalTime) from Platform p join p.station s on s.id in :stationId")
    List<StationInfo> findStationByPlatformAndBus(@Param("stationId") List<Long> stationId);
}
