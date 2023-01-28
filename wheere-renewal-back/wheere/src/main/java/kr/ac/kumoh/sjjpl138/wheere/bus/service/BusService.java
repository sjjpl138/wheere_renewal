package kr.ac.kumoh.sjjpl138.wheere.bus.service;

import kr.ac.kumoh.sjjpl138.wheere.bus.Bus;
import kr.ac.kumoh.sjjpl138.wheere.bus.repository.BusRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class BusService {
    private final BusRepository busRepository;

    @Transactional
    public Bus findBus(Long bId) {
        return busRepository.findById(bId).get();
    }
}
