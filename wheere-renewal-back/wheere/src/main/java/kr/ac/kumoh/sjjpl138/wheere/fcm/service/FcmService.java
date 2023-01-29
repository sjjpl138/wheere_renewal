package kr.ac.kumoh.sjjpl138.wheere.fcm.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.auth.oauth2.GoogleCredentials;
import com.google.common.net.HttpHeaders;
import kr.ac.kumoh.sjjpl138.wheere.fcm.FCMMessage;
import kr.ac.kumoh.sjjpl138.wheere.fcm.msg.NewReservationMessage;
import kr.ac.kumoh.sjjpl138.wheere.reservation.repository.ReservationRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import okhttp3.*;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class FcmService {
    private final ReservationRepository reservationRepository;

    private String API_URL = "https://fcm.googleapis.com/v1/projects/wheere-abb78/messages:send";
    private final ObjectMapper objectMapper;

    //@TODO("사용자 버스 하차 후 평점 알림 서비스 구현")


    public void sendNewReservationMessageToDriver(String busDriverToken, String memberId, Long reservationId,
                                                  Long busId, int startSeq, int endSeq) throws IOException {

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
        NewReservationMessage newReservationMessage = NewReservationMessage.builder()
                .message(NewReservationMessage.Message.builder()
                        .token(targetToken)
                        .notification(NewReservationMessage.Notification.builder()
                                .title("예약 취소 알림")
                                .body("예약이 취소되었습니다")
                                .image(null)
                                .build()
                        )
                        .data(NewReservationMessage.Data.builder()
                                .mId(memberId)
                                .rId(String.valueOf(reservationId))
                                .build())
                        .build())
                .build();

        return objectMapper.writeValueAsString(newReservationMessage);
    }

    public void sendMessageTo(String targetToken, String title, String body) throws IOException {
        String message = makeMessage(targetToken, title, body);

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

    // 파라미터를 FCM이 요구하는 body 형태로 만들어준다.
    private String makeMessage(String targetToken, String title, String body) throws JsonProcessingException {

        FCMMessage fcmMessage = FCMMessage.builder()
                .message(FCMMessage.Message.builder()
                        .token(targetToken)
                        .notification(FCMMessage.Notification.builder()
                                .title(title)
                                .body(body)
                                .image(null)
                                .build()
                        )
                        .data(FCMMessage.Data.builder()
                                .build())
                        .build()
                )
                .validateOnly(false)
                .build();

        return objectMapper.writeValueAsString(fcmMessage);
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
