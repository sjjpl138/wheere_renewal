package kr.ac.kumoh.sjjpl138.wheere.platform.repository;

import java.time.LocalTime;
import java.util.List;

public interface PlatformRepositoryCustom {

    List<Integer> findAllocationSeqByBusIdAndStationIdList(Long busId, List<Long> stationIds);

    List<Integer> findAllocationSeqByBusIdAndStationNameList(Long busId, List<String > stationName);
}
