package kr.ac.kumoh.sjjpl138.wheere.fcm.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.auth.oauth2.GoogleCredentials;
import com.google.common.net.HttpHeaders;
import kr.ac.kumoh.sjjpl138.wheere.bus.Bus;
import kr.ac.kumoh.sjjpl138.wheere.fcm.msg.CancelReservationMessage;
import kr.ac.kumoh.sjjpl138.wheere.fcm.msg.NewReservationMessage;
import kr.ac.kumoh.sjjpl138.wheere.fcm.msg.RatingMessage;
import kr.ac.kumoh.sjjpl138.wheere.platform.Platform;
import kr.ac.kumoh.sjjpl138.wheere.reservation.Reservation;
import kr.ac.kumoh.sjjpl138.wheere.transfer.Transfer;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import okhttp3.*;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class FcmService {

    private String API_URL = "https://fcm.googleapis.com/v1/projects/wheere-abb78/messages:send";
    private final ObjectMapper objectMapper;

    //@TODO("사용자 버스 하차 후 평점 알림 서비스 구현")
    public void sendRatingMessage(String memberToken, Bus bus, Reservation reservation, List<Platform> platforms) throws IOException {

        String message = makeRatingMessage(memberToken, bus, reservation, platforms);

        OkHttpClient client = new OkHttpClient();
        RequestBody requestBody = RequestBody.create(message, MediaType.get("application/json; charset=utf-8"));
        Request request = new Request.Builder()
                .url(API_URL)
                .post(requestBody)
                .addHeader(HttpHeaders.AUTHORIZATION, "Bearer " + getAccessToken())
                .addHeader(HttpHeaders.CONTENT_TYPE, "application/json; UTF-8")
                .build();

        Response response = client.newCall(request).execute();

        log.info(response.body().string());
    }

    private String makeRatingMessage(String targetToken, Bus bus, Reservation reservation, List<Platform> platforms) throws JsonProcessingException {

        Long reservationId = reservation.getId();
        LocalDate reservationDate = reservation.getReservationDate();

        String busNo = bus.getBusNo();

        Platform startPlatform = platforms.get(0);
        LocalTime startPlatformArrivalTime = startPlatform.getArrivalTime();
        String startStationName = startPlatform.getStation().getName();

        Platform endPlatform = platforms.get(1);
        LocalTime endPlatformArrivalTime = endPlatform.getArrivalTime();
        String endStationName = endPlatform.getStation().getName();

        RatingMessage ratingMessage = RatingMessage.builder()
                .message(RatingMessage.Message.builder()
                        .token(targetToken)
                        .notification(RatingMessage.Notification.builder()
                                .title("평점 작성 요청")
                                .body("버스를 안전히 사용하셨나요?\n서비스에 대한 평점을 남겨주세요!")
                                .image(null)
                                .build()
                        )
                        .data(RatingMessage.Data.builder()
                                .alarmType("rating")
                                .aTime(LocalDateTime.now())
                                .rId(String.valueOf(reservationId))
                                .rDate(reservationDate)
                                .bNo(busNo)
                                .sTime(startPlatformArrivalTime)
                                .sStationName(startStationName)
                                .eTime(endPlatformArrivalTime)
                                .eStationName(endStationName)
                                .build())
                        .build())
                .build();

        return objectMapper.writeValueAsString(ratingMessage);
    }


    public void sendNewReservationMessageToDriver(
            String busDriverToken, String memberId, Long reservationId, Long busId, int startSeq, int endSeq) throws IOException {

        String message = makeNewReservationMessage(busDriverToken, memberId, reservationId, busId, startSeq, endSeq);

        OkHttpClient client = new OkHttpClient();
        RequestBody requestBody = RequestBody.create(message, MediaType.get("application/json; charset=utf-8"));
        Request request = new Request.Builder()
                .url(API_URL)
                .post(requestBody)
                .addHeader(HttpHeaders.AUTHORIZATION, "Bearer " + getAccessToken())
                .addHeader(HttpHeaders.CONTENT_TYPE, "application/json; UTF-8")
                .build();

        Response response = client.newCall(request).execute();

        log.info(response.body().string());
    }

    private String makeNewReservationMessage(String targetToken, String memberId, Long reservationId, Long busId, int startSeq, int endSeq) throws JsonProcessingException {

        NewReservationMessage newReservationMessage = NewReservationMessage.builder()
                .message(NewReservationMessage.Message.builder()
                        .token(targetToken)
                        .notification(NewReservationMessage.Notification.builder()
                                .title("예약 생성 알림")
                                .body("새로운 예약이 발생했습니다")
                                .image(null)
                                .build()
                        )
                        .data(NewReservationMessage.Data.builder()
                                .alarmType("newReservation")
                                .aTime(LocalDateTime.now())
                                .mId(memberId)
                                .rId(String.valueOf(reservationId))
                                .bId(String.valueOf(busId))
                                .startSeq(String.valueOf(startSeq))
                                .endSeq(String.valueOf(endSeq))
                                .build())
                        .build())
                .build();

        return objectMapper.writeValueAsString(newReservationMessage);
    }

    public void sendCancelReservationMessage(String busDriverToken, String memberId, Long reservationId) throws IOException {
        String message = makeCancelReservationMessage(busDriverToken, memberId, reservationId);

        OkHttpClient client = new OkHttpClient();
        RequestBody requestBody = RequestBody.create(message, MediaType.get("application/json; charset=utf-8"));
        Request request = new Request.Builder()
                .url(API_URL)
                .post(requestBody)
                .addHeader(HttpHeaders.AUTHORIZATION, "Bearer " + getAccessToken())
                .addHeader(HttpHeaders.CONTENT_TYPE, "application/json; UTF-8")
                .build();

        Response response = client.newCall(request).execute();

        log.info(response.body().string());
    }

    private String makeCancelReservationMessage(String targetToken, String memberId, Long reservationId) throws JsonProcessingException {
        CancelReservationMessage cancelReservationMessage = CancelReservationMessage.builder()
                .message(CancelReservationMessage.Message.builder()
                        .token(targetToken)
                        .notification(CancelReservationMessage.Notification.builder()
                                .title("예약 취소 알림")
                                .body("예약이 취소되었습니다")
                                .image(null)
                                .build()
                        )
                        .data(CancelReservationMessage.Data.builder()
                                .alarmType("cancelReservation")
                                .aTime(LocalDateTime.now())
                                .mId(memberId)
                                .rId(String.valueOf(reservationId))
                                .build())
                        .build())
                .build();

        return objectMapper.writeValueAsString(cancelReservationMessage);
    }

    private String getAccessToken() throws IOException {
        String firebaseConfigPath = "../resources/keystore/service-account.json";
        GoogleCredentials googleCredentials = GoogleCredentials
                .fromStream(new ClassPathResource(firebaseConfigPath).getInputStream())
                .createScoped(List.of("https://www.googleapis.com/auth/cloud-platform"));
        googleCredentials.refreshIfExpired();
        return googleCredentials.getAccessToken().getTokenValue();
    }
}
