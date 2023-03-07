package kr.ac.kumoh.sjjpl138.wheere.fcm.msg;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

@Builder
@AllArgsConstructor
@Getter
public class RatingMessage {

    private Message message;

    @Builder
    @AllArgsConstructor
    @Getter
    public static class Data {

        private String alarmType;
        @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
        private LocalDateTime aTime;
        @JsonProperty("rId")
        private String rId;
        @JsonFormat(pattern = "yyyy-MM-dd")
        private LocalDate rDate;
        @JsonProperty("bNo")
        private String bNo;
        @JsonProperty("bId")
        private String bId;
        @JsonFormat(pattern = "HH:mm:ss")
        private LocalTime sTime;
        @JsonProperty("sStationName")
        private String sStationName;
        @JsonFormat(pattern = "HH:mm:ss")
        private LocalTime eTime;
        @JsonProperty("eStationName")
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
