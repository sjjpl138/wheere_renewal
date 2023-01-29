package kr.ac.kumoh.sjjpl138.wheere.fcm.msg;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;
import kr.ac.kumoh.sjjpl138.wheere.fcm.FCMMessage;
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
public class NewReservationMessage {
    private Message message;

    @Builder
    @AllArgsConstructor
    @Getter
    public static class Data {
        @JsonProperty("mId")
        private String mId;
        @JsonProperty("rId")
        private String rId;
        @JsonProperty("bId")
        private String bId;
        private String startSeq;
        private String endSeq;
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
