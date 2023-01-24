package kr.ac.kumoh.sjjpl138.wheere.seat.repository;

import com.querydsl.jpa.impl.JPAQueryFactory;

import javax.persistence.EntityManager;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import static kr.ac.kumoh.sjjpl138.wheere.platform.QPlatform.platform;
import static kr.ac.kumoh.sjjpl138.wheere.seat.QSeat.seat;

public class SeatRepositoryImpl implements SeatRepositoryCustom {

    private final JPAQueryFactory queryFactory;

    public SeatRepositoryImpl(EntityManager em) {
        this.queryFactory = new JPAQueryFactory(em);
    }

    @Override
    public Optional<Integer> findMinLeftSeatsByStation(Long busId, List<Integer> seqList, LocalDate date) {

        Integer minLeftSeats = queryFactory
                .select(seat.leftSeatsNum.min())
                .from(seat)
                .join(seat.platform, platform)
                .where(
                        platform.bus.id.eq(busId),
                        platform.stationSeq.in(seqList),
                        seat.seatDate.eq(date)
                )
                .fetchOne();

        return Optional.ofNullable(minLeftSeats);
    }
}
