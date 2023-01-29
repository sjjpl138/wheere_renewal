package kr.ac.kumoh.sjjpl138.wheere.fcm.msg;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalTime;

@Builder
@AllArgsConstructor
@Getter
public class CancelReservationMessage {
    private NewReservationMessage.Message message;

    @Builder
    @AllArgsConstructor
    @Getter
    public static class Data {
        private String alarmType;
        @DateTimeFormat(pattern = "HH:mm:ss")
        private LocalTime aTime;
        @JsonProperty("mId")
        private String mId;
        @JsonProperty("rId")
        private String rId;
    }

    @Builder
    @AllArgsConstructor
    @Getter
    public static class Message {
        private NewReservationMessage.Notification notification;
        private String token;
        private NewReservationMessage.Data data;
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
