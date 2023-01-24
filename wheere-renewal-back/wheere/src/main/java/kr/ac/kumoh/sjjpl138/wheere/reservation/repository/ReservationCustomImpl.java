package kr.ac.kumoh.sjjpl138.wheere.reservation.repository;

import com.querydsl.core.types.Order;
import com.querydsl.core.types.OrderSpecifier;
import com.querydsl.core.types.Projections;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.core.types.dsl.PathBuilder;
import com.querydsl.jpa.impl.JPAQuery;
import com.querydsl.jpa.impl.JPAQueryFactory;
import kr.ac.kumoh.sjjpl138.wheere.reservation.ReservationSearchCondition;
import kr.ac.kumoh.sjjpl138.wheere.reservation.ReservationStatus;
import kr.ac.kumoh.sjjpl138.wheere.reservation.dto.ReservationListDto;
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
    public Slice<ReservationListDto> searchSlice(String memberId, ReservationSearchCondition condition, Pageable pageable) {
        JPAQuery<ReservationListDto> query = queryFactory
                .select(Projections.fields(ReservationListDto.class,
                        reservation.id.as("rId"),
                        reservation.reservationDate.as("rDate"),
                        reservation.reservationStatus.as("rState")))
                .from(reservation)
                .where(
                        rStateEq(condition.getRState()),
                        member.id.eq(memberId)
                )
                .join(reservation.member, member)
                .offset(pageable.getOffset())
                .limit(pageable.getPageSize());

        for (Sort.Order o : pageable.getSort()) {
            PathBuilder pathBuilder = new PathBuilder(
                    reservation.getType(), reservation.getMetadata()
            );
            query.orderBy(new OrderSpecifier(o.isAscending() ? Order.ASC : Order.DESC,
                    pathBuilder.get(o.getProperty())));
        }

        List<ReservationListDto> result = query.fetch();

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
