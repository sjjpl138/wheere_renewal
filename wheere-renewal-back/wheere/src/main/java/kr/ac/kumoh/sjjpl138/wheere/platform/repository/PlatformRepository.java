package kr.ac.kumoh.sjjpl138.wheere.platform.repository;

import kr.ac.kumoh.sjjpl138.wheere.platform.Platform;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface PlatformRepository extends JpaRepository<Platform, Long>, PlatformRepositoryCustom {

    @Query("select p from Platform p join p.bus b on b.busNo = :busNo and b.vehicleNo = :vehicleNo and :busAllocationSeq = b.busAllocationSeq order by p.stationSeq")
    List<Platform> findPlatformsByBus(@Param("busNo") String busNo, @Param("vehicleNo") String vehicleNo, @Param("busAllocationSeq") int busAllocationSeq);

    @Query("select p from Platform p join p.bus b on b.id = :busId join fetch p.station s where s.id in :stationIds")
    List<Platform> findPlatformWithStationByBusIdAndStationId(@Param("busId") Long busId, @Param("stationIds") List<Long> stationIds);

    @Query("select p from Platform p join p.bus b join p.station s where b.id = :busId and s.id in :stationIds")
    List<Platform> findPlatformByBusIdAndStationId(@Param("busId") Long busId, @Param("stationIds") List<Long> stationIds);

    @Query("select p from Platform p join p.bus b on b.id = :busId")
    List<Platform> findPlatformByBusId(@Param("busId") Long busId);

    @EntityGraph(attributePaths = {"station"})
    @Query("select p from Platform p join p.bus b join p.station s where s.name in :stationNames and b.id = :bId")
    List<Platform> findByStationNameAndBusId(@Param("stationNames") List<String> stationNames, @Param("bId") Long bId);

    @EntityGraph(attributePaths = {"station"})
    @Query("select p from Platform p join p.station s where s.id in :stationIds")
    List<Platform> findPlatformByStationIds(@Param("stationIds") List<Long> stationIds);

  @EntityGraph(attributePaths = {"station"})
  @Query("select p from Platform p join p.bus b join p.station s where s.id in :stationIds and b.id = :bId")
  List<Platform> findPlatformByStationIdsAndBusId(@Param("stationIds") List<Long> stationIds, @Param("bId") Long bId);

    List<Platform> findPlatformByIdIn(List<Long> platformIds);

    @Query("select p from Platform p join fetch p.station s where s.name in :stationNameList")
    List<Platform> findPlatformByStationNameIn(@Param("stationNameList") List<String> stationNameList);
}
