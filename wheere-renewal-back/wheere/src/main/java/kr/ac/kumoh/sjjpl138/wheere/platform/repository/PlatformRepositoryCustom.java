package kr.ac.kumoh.sjjpl138.wheere.platform.repository;

import kr.ac.kumoh.sjjpl138.wheere.platform.Platform;

import java.util.List;

public interface PlatformRepositoryCustom {

    List<Integer> findAllocationSeqByBusIdAndStationIdList(Long busId, List<Long> stationIds);

    List<Integer> findAllocationSeqByBusIdAndStationNameList(Long busId, List<String > stationName);

    List<Platform> findPagedStationsByBusIdAndStationSeq(Long busId, int offset, int limit);
}
