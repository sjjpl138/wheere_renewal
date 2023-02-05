package kr.ac.kumoh.sjjpl138.wheere.reservation.repository;

import com.querydsl.core.types.Order;
import com.querydsl.core.types.OrderSpecifier;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.core.types.dsl.PathBuilder;
import com.querydsl.jpa.impl.JPAQuery;
import com.querydsl.jpa.impl.JPAQueryFactory;
import kr.ac.kumoh.sjjpl138.wheere.reservation.Reservation;
import kr.ac.kumoh.sjjpl138.wheere.reservation.request.ReservationSearchCondition;
import kr.ac.kumoh.sjjpl138.wheere.reservation.ReservationStatus;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.data.domain.SliceImpl;
import org.springframework.data.domain.Sort;

import javax.persistence.EntityManager;
import java.util.List;

import static kr.ac.kumoh.sjjpl138.wheere.member.QMember.member;
import static kr.ac.kumoh.sjjpl138.wheere.reservation.QReservation.*;
import static org.springframework.util.StringUtils.*;

public class ReservationCustomImpl implements ReservationCustom{

    private final JPAQueryFactory queryFactory;

    public ReservationCustomImpl(EntityManager em) {
        this.queryFactory = new JPAQueryFactory(em);
    }

    @Override
    public Slice<Reservation> searchSlice(String memberId, ReservationSearchCondition condition, Pageable pageable) {
        JPAQuery<Reservation> query = queryFactory
                .selectFrom(reservation)
                .where(
                        rStateEq(condition.getRState()),
                        member.id.eq(memberId)
                )
                .join(reservation.member, member)
                .offset(pageable.getOffset())
                .limit(pageable.getPageSize() + 1);

        for (Sort.Order o : pageable.getSort()) {
            PathBuilder pathBuilder = new PathBuilder(
                    reservation.getType(), reservation.getMetadata()
            );
            query.orderBy(new OrderSpecifier(o.isAscending() ? Order.ASC : Order.DESC,
                    pathBuilder.get(o.getProperty())));
        }

        List<Reservation> result = query.fetch();

        boolean hasNext = false;
        if (result.size() > pageable.getPageSize()) {
            result.remove(pageable.getPageSize());
            hasNext = true;
        }

        return new SliceImpl<>(result, pageable, hasNext);
    }

    private BooleanExpression rStateEq(String rState) {
        return hasText(rState) ? reservation.reservationStatus.eq(ReservationStatus.valueOf(rState)) : null;
    }
}
