package kr.ac.kumoh.sjjpl138.wheere.station.repository;

import kr.ac.kumoh.sjjpl138.wheere.station.Station;
import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
@Transactional
class StationRepositoryTest {

    @PersistenceContext
    EntityManager em;
    @Autowired StationRepository stationRepository;

    @BeforeEach
    public void before() {
        Station station1 = new Station(1L, "조야동");
        Station station2 = new Station(2L, "사월동");
        Station station3 = new Station(3L, "수성교");
        Station station4 = new Station(4L, "조야동");
        em.persist(station1);
        em.persist(station2);
        em.persist(station3);
        em.persist(station4);

        em.flush();
        em.clear();
    }

    @Test
    void findStationByStationIds() {
        // when
        List<Long> idList = List.of(1L, 2L, 3L, 4L);
        List<Station> stations = stationRepository.findStationByStationIds(idList);

        //then
        Assertions.assertThat(stations).extracting("id").containsExactly(1L, 2L, 3L, 4L);
    }
}