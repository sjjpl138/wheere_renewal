package kr.ac.kumoh.sjjpl138.wheere.reservation.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import kr.ac.kumoh.sjjpl138.wheere.bus.Bus;
import kr.ac.kumoh.sjjpl138.wheere.platform.Platform;
import kr.ac.kumoh.sjjpl138.wheere.station.Station;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalTime;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReservationBus {

    @JsonProperty("bId")
    private Long bId;
    @JsonProperty("bNo")
    private String bNo;
    private String routeId;
    @JsonProperty("vNo")
    private String vNo;

    @JsonProperty("sTime")
    private LocalTime sTime;
    @JsonProperty("sStationId")
    private Long sStationId;
    @JsonProperty("sStationName")
    private String sStationName;

    @JsonProperty("eTime")
    private LocalTime eTime;
    @JsonProperty("eStationId")
    private Long eStationId;
    @JsonProperty("eStationName")
    private String eStationName;

    public static ReservationBus createReservationBus(Bus bus, List<Platform> platforms) {

        ReservationBus reservationBus = new ReservationBus();

        reservationBus.setBId(bus.getId());
        reservationBus.setBNo(bus.getBusNo());
        reservationBus.setRouteId(bus.getRouteId());
        reservationBus.setVNo(bus.getVehicleNo());

        Platform boardPlatform = platforms.get(0);
        Station findBoardStation = boardPlatform.getStation();
        Platform alightPlatform = platforms.get(1);
        Station findAlightStation = alightPlatform.getStation();

        reservationBus.setSTime(boardPlatform.getArrivalTime());
        reservationBus.setSStationId(findBoardStation.getId());
        reservationBus.setSStationName(findBoardStation.getName());

        reservationBus.setETime(alightPlatform.getArrivalTime());
        reservationBus.setEStationId(findAlightStation.getId());
        reservationBus.setEStationName(findAlightStation.getName());

        return reservationBus;
    }
}
