package kr.ac.kumoh.sjjpl138.wheere.driver.service;

import kr.ac.kumoh.sjjpl138.wheere.bus.Bus;
import kr.ac.kumoh.sjjpl138.wheere.bus.repository.BusRepository;
import kr.ac.kumoh.sjjpl138.wheere.driver.Driver;
import kr.ac.kumoh.sjjpl138.wheere.driver.dto.DriverLogInRequestDto;
import kr.ac.kumoh.sjjpl138.wheere.driver.dto.DriverLoginResponseDto;
import kr.ac.kumoh.sjjpl138.wheere.reservation.dto.ResvDto;
import kr.ac.kumoh.sjjpl138.wheere.driver.repository.DriverRepository;
import kr.ac.kumoh.sjjpl138.wheere.platform.dto.StationDto;
import kr.ac.kumoh.sjjpl138.wheere.platform.service.PlatformService;
import kr.ac.kumoh.sjjpl138.wheere.reservation.service.ReservationService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class DriverService {

    private final DriverRepository driverRepository;
    private final BusRepository busRepository;
    private final PlatformService platformService;
    private final ReservationService reservationService;

    /**
     * 버스 기사 로그인
     * @param logInRequestDto
     * @return
     */
    public DriverLoginResponseDto logIn(DriverLogInRequestDto logInRequestDto) {
        String driverId = logInRequestDto.getDriverId();
        String vehicleNo = logInRequestDto.getVehicleNo();
        String busNo = logInRequestDto.getBusNo();
        LocalDate operationDate = LocalDate.now();
        String fcmToken = logInRequestDto.getFcmToken();

        // 버스 토큰 저장
        Bus findBus = busRepository.findBusByVehicleNoAndBusNoAndBusDate(vehicleNo, busNo, operationDate).get();
        findBus.registerToken(fcmToken);

        // 버스 배정
        Driver findDriver = driverRepository.findById(driverId).get();
        findDriver.assignBus(findBus);

        DriverLoginResponseDto result = new DriverLoginResponseDto();
        result.setDName(findDriver.getUsername());
        result.setBId(findBus.getId());
        result.setVNo(vehicleNo);
        result.setBNo(busNo);
        result.setRouteId(findBus.getRouteId());
        result.setTotalSeats(2);

        setRoute(vehicleNo, busNo, result);
        setReservations(findBus, result);

        return result;
    }

    private void setReservations(Bus findBus, DriverLoginResponseDto result) {
        List<ResvDto> resvDtoList = reservationService.findPartForDriver(findBus);
        result.setReservations(resvDtoList);
    }

    private void setRoute(String vehicleNo, String busNo, DriverLoginResponseDto result) {
        List<StationDto> route = platformService.findRoute(busNo, vehicleNo);
        result.setRoute(route);
    }

    /**
     * 버스 기사 정보 수정 (버스 변경)
     * 반환값으로 배정된 버스 정보? 등등
     * @param driverId
     * @param vehicleNo
     * @return
     */
    @Transactional
    public Bus changeBus(String driverId, String vehicleNo, String busNo, LocalDate busDate) {
        Driver findDriver = driverRepository.findById(driverId).get();
        Bus findBus = busRepository.findBusByVehicleNoAndBusNoAndBusDate(vehicleNo, busNo, busDate).get();
        findDriver.assignBus(findBus);

        return findBus;
    }
}
