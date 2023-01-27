package kr.ac.kumoh.sjjpl138.wheere.platform.repository;

import com.querydsl.jpa.impl.JPAQueryFactory;

import javax.persistence.EntityManager;
import java.time.LocalTime;
import java.util.List;

import static kr.ac.kumoh.sjjpl138.wheere.platform.QPlatform.platform;

public class PlatformRepositoryImpl implements PlatformRepositoryCustom {

    private final JPAQueryFactory queryFactory;

    public PlatformRepositoryImpl(EntityManager em) {
        this.queryFactory = new JPAQueryFactory(em);
    }

    @Override
    public List<LocalTime> searchArrivalTime(Long busId, List<Long> stationIdList) {

        return queryFactory
                .select(platform.arrivalTime)
                .from(platform)
                .where(
                        platform.bus.id.eq(busId),
                        platform.station.id.in(stationIdList)
                )
                .fetch();
    }

    @Override
    public List<Integer> findAllocationSeqByBusIdAndStationIdList(Long busId, List<Long> stationIds) {
        return queryFactory
                .select(platform.stationSeq)
                .from(platform)
                .where(platform.bus.id.eq(busId), platform.station.id.in(stationIds))
                .fetch();
    }
}
