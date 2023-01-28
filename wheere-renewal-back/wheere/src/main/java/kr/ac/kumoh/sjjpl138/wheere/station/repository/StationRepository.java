package kr.ac.kumoh.sjjpl138.wheere.station.repository;

import kr.ac.kumoh.sjjpl138.wheere.station.Station;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface StationRepository extends JpaRepository<Station, Long> {

    List<Station> findStationByIdIn(List<Long> stationIds);

    List<Station> findStationByNameIn(List<String> stationNames);
}
