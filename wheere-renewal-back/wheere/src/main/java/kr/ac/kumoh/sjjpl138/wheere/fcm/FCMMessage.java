package kr.ac.kumoh.sjjpl138.wheere.fcm;

import com.fasterxml.jackson.annotation.JsonFormat;
import kr.ac.kumoh.sjjpl138.wheere.reservation.ReservationStatus;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;
import java.time.LocalTime;

@Builder
@AllArgsConstructor
@Getter
public class FCMMessage {
    private boolean validateOnly;
    private Message message;

    @Builder
    @AllArgsConstructor
    @Getter
    public static class Data {
        @JsonFormat(pattern = "yyyy-MM-dd")
        private LocalDate rDate;
        private ReservationStatus rStatus;
        @DateTimeFormat(pattern = "HH:mm:ss")
        private LocalTime sTime;
        private String sStationId;
        private String sStationName;
        @DateTimeFormat(pattern = "HH:mm:ss")
        private LocalTime eTime;
        private String eStationId;
        private String eStationName;
    }

    @Builder
    @AllArgsConstructor
    @Getter
    public static class Message {
        private Notification notification;
        private String token;
        private Data data;
    }

    @Builder
    @AllArgsConstructor
    @Getter
    public static class Notification {
        private String title;
        private String body;
        private String image;
    }
}
