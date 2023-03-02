package kr.ac.kumoh.sjjpl138.wheere.bus.service;

import kr.ac.kumoh.sjjpl138.wheere.bus.Bus;
import kr.ac.kumoh.sjjpl138.wheere.bus.repository.BusRepository;
import kr.ac.kumoh.sjjpl138.wheere.exception.NotExistBusException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class BusService {
    private final BusRepository busRepository;

    @Transactional
    public Bus findBus(Long bId) {
        Optional<Bus> findBusOptional = busRepository.findById(bId);
        if (findBusOptional.isEmpty()) {
            throw new NotExistBusException("존재하지 않는 버스입니다.");
        }
        return findBusOptional.get();
    }
}
