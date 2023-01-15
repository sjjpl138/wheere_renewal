package kr.ac.kumoh.sjjpl138.wheere.reservation.service;

import kr.ac.kumoh.sjjpl138.wheere.reservation.Reservation;
import kr.ac.kumoh.sjjpl138.wheere.reservation.repository.ReservationRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class ReservationService {

    private final ReservationRepository reservationRepository;

    /**
     * 예약 생성
     * @return 생성된 Reservation 객체??
     */
    @Transactional
    public Reservation saveReservation() {
        return new Reservation();
    }

    /**
     * 예약 취소
     */
    @Transactional
    public void cancelReservation() {

    }

    /**
     * 예약 조회
     * 조회 후 찾고자 하는 예약이 없으면 예외 발생
     * @param reservationId 예약 PK
     * @return 조회된 Reservation
     */
    public Reservation findReservationById(Long reservationId) {

        return new Reservation();
    }

    /**
     * 사용자의 예약 정보 조회
     * 필터 조건에 따라 예약 보여주기
     * 조건: 정렬 기준, 예약 상태
     * @param memberId
     * @return
     */
    public List<Reservation> findPartForMemberByCond(String memberId) {

        return new ArrayList<Reservation>();
    }

    public List<Reservation> findPartForDriver() {

        return new ArrayList<Reservation>();
    }

}
