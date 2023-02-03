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
    public List<Integer> findAllocationSeqByBusIdAndStationIdList(Long busId, List<Long> stationIds) {
        return queryFactory
                .select(platform.stationSeq)
                .from(platform)
                .where(platform.bus.id.eq(busId), platform.station.id.in(stationIds))
                .fetch();
    }

    @Override
    public List<Integer> findAllocationSeqByBusIdAndStationNameList(Long busId, List<String > stationName) {
        return queryFactory
                .select(platform.stationSeq)
                .from(platform)
                .where(platform.bus.id.eq(busId), platform.station.name.in(stationName))
                .fetch();
    }
}
