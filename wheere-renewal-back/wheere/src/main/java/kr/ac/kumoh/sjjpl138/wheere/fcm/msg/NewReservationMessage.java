package kr.ac.kumoh.sjjpl138.wheere.fcm.msg;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

import java.time.LocalDateTime;
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
        private String alarmType;
        @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
        private LocalDateTime aTime;
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
        private String topic;
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
