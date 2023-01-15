package kr.ac.kumoh.sjjpl138.wheere.driver.service;

import kr.ac.kumoh.sjjpl138.wheere.driver.Driver;
import kr.ac.kumoh.sjjpl138.wheere.driver.dto.DriverLogInRequestDto;
import kr.ac.kumoh.sjjpl138.wheere.driver.dto.DriverLoginResponseDto;
import kr.ac.kumoh.sjjpl138.wheere.driver.repository.DriverRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class DriverService {

    private final DriverRepository driverRepository;

    /**
     * 버스 기사 로그인
     * @param logInRequestDto
     * @return
     */
    public DriverLoginResponseDto logIn(DriverLogInRequestDto logInRequestDto) {

        return new DriverLoginResponseDto();
    }

    /**
     * 버스 기사 정보 수정 (버스 변경)
     * 반환값으로 배정된 버스 정보? 등등
     */
    @Transactional
    public void changeBus() {

    }

    @Transactional
    public void delete(Driver driver) {

    }
}
