package kr.ac.kumoh.sjjpl138.wheere.member.service;

import kr.ac.kumoh.sjjpl138.wheere.member.sub.AllCourseCase;
import kr.ac.kumoh.sjjpl138.wheere.member.sub.BusLane;
import kr.ac.kumoh.sjjpl138.wheere.member.sub.Course;
import kr.ac.kumoh.sjjpl138.wheere.member.sub.SubCourse;
import lombok.extern.slf4j.Slf4j;
import org.json.JSONArray;
import org.json.JSONObject;

import kr.ac.kumoh.sjjpl138.wheere.driver.repository.DriverRepository;
import kr.ac.kumoh.sjjpl138.wheere.member.Member;
import kr.ac.kumoh.sjjpl138.wheere.member.dto.MemberDto;
import kr.ac.kumoh.sjjpl138.wheere.member.dto.RetrieveRoutesRequest;
import kr.ac.kumoh.sjjpl138.wheere.member.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import static java.nio.charset.StandardCharsets.*;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
@Slf4j
public class MemberService {

    @Value("${odsay-key}")
    private String apiKey;
    private final MemberRepository memberRepository;
    private final DriverRepository driverRepository;

    /**
     * 사용자 추가 (회원가입)
     *
     * @param memberDto
     * @return
     */
    @Transactional
    public Member join(MemberDto memberDto) {
        Member member = changeMemberEntity(memberDto);
        memberRepository.save(member);

        return member;
    }

    private Member changeMemberEntity(MemberDto memberDto) {
        String id = memberDto.getMId();
        String name = memberDto.getMName();
        LocalDate birthDate = memberDto.getMBirthDate();
        String sex = memberDto.getMSex();
        String num = memberDto.getMNum();
        Member member = new Member(id, name, birthDate, sex, num);

        return member;
    }

    /**
     * 사용자 정보 조회 (로그인)
     *
     * @param memberId
     * @return
     */
    public Member logIn(String memberId) {
        Member member = memberRepository.findMemberById(memberId);

        return member;
    }

    /**
     * 사용자 정보 수정
     */
    @Transactional
    public void update(MemberDto memberDto) {
        String id = memberDto.getMId();
        Member findMember = memberRepository.findMemberById(id);
        findMember.updateMemberInfo(memberDto);
    }

    /**
     * 사용자 삭제 (탈퇴하기)
     *
     * @param member
     */
    @Transactional
    public void delete(Member member) {
        memberRepository.delete(member);
    }

    /**
     * 버스 기사 평점 메기기
     *
     * @param rating
     */
    @Transactional
    public void rateDriver(double rating) {

    }

    /**
     * 출발지, 도착지 좌표를 입력 받아
     * 대중교통 길찾기 api를 사용해 선택지 제공
     */
    public Optional<AllCourseCase> checkRoutes(RetrieveRoutesRequest requestDto) throws IOException {

        // 대주교통 길차지 API Url 설정
        // @TODO("예외처리 필요 (UnsupportedEncodingException)")
        StringBuilder urlBuilder = setUrl(requestDto);

        // GET 방식으로 전송해서 파라미터 받아오기
        // @TODO("예외처리 필요 (MalformedURLException)")
        URL url = createUrl(urlBuilder);

        // @TODO("예외처리 필요 (IOException)")
        String jsonResult = extractJson(url);

        return extractRetrieveRoutesResult(jsonResult);
    }

    private Optional<AllCourseCase> extractRetrieveRoutesResult(String jsonResult) {

        AllCourseCase allCourseCase = new AllCourseCase();

        List<Course> courses = new ArrayList<>();

        /* json parsing */
        JSONObject rootJsonObject = getJsonObject(jsonResult);

        // 값이 0 (도시내) 인 경우에만 응답하도록
        int searchType = getSearchType(rootJsonObject);

        // 조회한 범위가 도시 내가 아닌 경우 empty Optional 반환
        if (isNotInCity(searchType)) {
            return Optional.empty();
        }

        // 도시간 '직통' 탐색 결과 유무
        // 0: 직통, 1: 직통 없음
        int outTrafficCheck = getOutTrafficCheck(rootJsonObject);
        allCourseCase.setOutTrafficCheck(outTrafficCheck);

        // 결과 리스트 확장 노드
        JSONArray path = getPath(rootJsonObject);

        addCourse(courses, path);

        allCourseCase.setCourses(courses);

        return Optional.of(allCourseCase);
    }

    private static JSONArray getPath(JSONObject rootJsonObject) {
        JSONArray path = rootJsonObject.getJSONArray("path");
        return path;
    }

    private static JSONObject getJsonObject(String jsonResult) {
        JSONObject jsonObj = new JSONObject(jsonResult);
        return jsonObj.getJSONObject("result");
    }

    private static int getSearchType(JSONObject rootJsonObject) {
        int searchType = rootJsonObject.getInt("searchType");
        log.debug("searchType = {}", searchType);
        return searchType;
    }

    private static int getOutTrafficCheck(JSONObject rootJsonObject) {
        int outTrafficCheck = rootJsonObject.getInt("outTrafficCheck");
        log.debug("outTrafficCheck = {}", outTrafficCheck);
        return outTrafficCheck;
    }

    private void addCourse(List<Course> courses, JSONArray path) {
        for (int i = 0; i < path.length(); i++) {

            Course course = new Course();

            List<SubCourse> subCourses = new ArrayList<>();

            // 출발지 -> 목적지 경우의 수 중에서 하나
            JSONObject pathObj = getPathObj(path, i);

            // 요약 정보 확장 노드
            JSONObject info = getInfo(pathObj);

            // 총 요금
            int payment = getPayment(info);
            course.setPayment(payment);

            // 버스 환승 카운트 (1부터 시작)
            // busTransitCount + 1 = 도보
            int busTransitCount = getBusTransitCount(info);
            course.setBusTransitCount(busTransitCount);

            // 이동 교통 수단 정보 확장 노드
            JSONArray subPath = getSubPath(pathObj);

            addSubCourse(subCourses, subPath);

            course.setSubCourses(subCourses);
            courses.add(course);
        }
    }

    private static JSONObject getPathObj(JSONArray path, int i) {
        return path.getJSONObject(i);
    }

    private static JSONObject getInfo(JSONObject pathObj) {
        return pathObj.getJSONObject("info");
    }

    private static int getBusTransitCount(JSONObject info) {
        int busTransitCount = info.getInt("busTransitCount");
        log.debug("busTransitCount = {}", busTransitCount);
        return busTransitCount;
    }

    private static int getPayment(JSONObject info) {
        int payment = info.getInt("payment");
        log.debug("payment = {}", payment);
        return payment;
    }

    private static JSONArray getSubPath(JSONObject pathObj) {
        return pathObj.getJSONArray("subPath");
    }

    private void addSubCourse(List<SubCourse> subCourses, JSONArray subPath) {
        for (int k = 0; k < subPath.length(); k++) {

            SubCourse subCourse = new SubCourse();

            JSONObject subPathObj = getSubPathObj(subPath, k);

            // 이동 수단 종류
            // 1: 지하철, 2: 버스, 3: 도보 (2, 3인 경우로 구분해서 구현하기)
            int trafficType = getTrafficType(subPathObj);
            subCourse.setTrafficType(trafficType);

            // 이동 소요 시간
            int sectionTime = getSectionTime(subPathObj);
            subCourse.setSectionTime(sectionTime);

            ifPresentBusLane(subCourse, subPathObj, trafficType);

            subCourses.add(subCourse);
        }
    }

    private static JSONObject getSubPathObj(JSONArray subPath, int k) {
        return subPath.getJSONObject(k);
    }

    private int getTrafficType(JSONObject subPathObj) {
        int trafficType = subPathObj.getInt("trafficType");
        log.debug("trafficType = {}", trafficType);
        return trafficType;
    }

    private int getSectionTime(JSONObject subPathObj) {
        int sectionTime = subPathObj.getInt("sectionTime");
        log.debug("sectionTime = {}", sectionTime);
        return sectionTime;
    }

    private void ifPresentBusLane(SubCourse subCourse, JSONObject subPathObj, int trafficType) {
        if (trafficType == 2) {

            List<String> busNoList = new ArrayList<>();

            // 교통 수단 정보 확장 노드
            addBusNo(subPathObj, busNoList);

            // 경로 상세구간 정보 확장 노드
            JSONObject passStopList = getPassStopList(subPathObj);

            // 정류장 정보 그룹 노드
            JSONArray stations = getStations(passStopList);

            // 첫번째 정류소 정보
            JSONObject firstPassStopObj = getPassStopObj(stations, 0);

            // 첫번째 정류장 ID
            int firstStationID = getStationID(firstPassStopObj);

            // 첫번째 정류장 명칭
            String firstStationName = getStationName(firstPassStopObj);

            // 마지막 정류소 정보
            JSONObject lastPassStopObj = getPassStopObj(stations, stations.length() - 1);

            // 마지막 정류장 ID
            int lastStationID = getStationID(lastPassStopObj);

            // 마지막 정류장 명칭
            String lastStationName = getStationName(lastPassStopObj);

            BusLane busLane = BusLane.createBusLane(busNoList, firstStationID, firstStationName, lastStationID, lastStationName);
            subCourse.setBusLane(Optional.of(busLane));
        }
    }

    private void addBusNo(JSONObject subPathObj, List<String> busNoList) {
        JSONArray lane = getLane(subPathObj);

        for (int r = 0; r < lane.length(); r++) {
            busNoList.add(getBusNo(getLaneObj(lane, r)));
        }
    }

    private JSONObject getLaneObj(JSONArray lane, int r) {
        return lane.getJSONObject(r);
    }

    private JSONArray getLane(JSONObject subPathObj) {
        return subPathObj.getJSONArray("lane");
    }

    private String getBusNo(JSONObject laneObj) {
        String busNo = laneObj.getString("busNo");
        log.debug("busNo = {}", busNo);
        return busNo;
    }

    private JSONObject getPassStopList(JSONObject subPathObj) {
        return subPathObj.getJSONObject("passStopList");
    }

    private JSONArray getStations(JSONObject passStopList) {
        return passStopList.getJSONArray("stations");
    }

    private JSONObject getPassStopObj(JSONArray stations, int index) {
        return stations.getJSONObject(index);
    }

    private String getStationName(JSONObject passStopObj) {
        String stationName = passStopObj.getString("stationName");
        log.debug("stationName = {}", stationName);
        return stationName;
    }

    private int getStationID(JSONObject firstPassStopObj) {
        int firstStationID = firstPassStopObj.getInt("stationID");
        log.debug("StationID = {}", firstStationID);
        return firstStationID;
    }

    private boolean isNotInCity(int searchType) {
        return searchType != 0;
    }

    private String extractJson(URL url) throws IOException {
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        log.debug("Response code = {}", conn.getResponseCode());

        BufferedReader rd;
        if (isOK(conn)) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }

        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }

        rd.close();
        conn.disconnect();

        return sb.toString();
    }

    private boolean isOK(HttpURLConnection conn) throws IOException {
        return conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300;
    }

    private URL createUrl(StringBuilder urlBuilder) throws MalformedURLException {
        return new URL(urlBuilder.toString());
    }

    private StringBuilder setUrl(RetrieveRoutesRequest requestDto) throws UnsupportedEncodingException {
        String apiUrl = "https://api.odsay.com/v1/api/searchPubTransPathT";

        StringBuilder urlBuilder = new StringBuilder(apiUrl);

        urlBuilder.append("?").append(URLEncoder.encode("apiKey", UTF_8)).append("=").append(apiKey);

        // 출발지 X좌표 (경도좌표)
        urlBuilder.append("&").append(URLEncoder.encode("SX", UTF_8)).append("=").append(URLEncoder.encode(requestDto.getSx(), UTF_8));

        //출발지 Y좌표 (위도좌표)
        urlBuilder.append("&").append(URLEncoder.encode("SY", UTF_8)).append("=").append(URLEncoder.encode(requestDto.getSy(), UTF_8));

        // 도착지 X좌표 (경도좌표)
        urlBuilder.append("&").append(URLEncoder.encode("EX", UTF_8)).append("=").append(URLEncoder.encode(requestDto.getEx(), UTF_8));

        // 도착지 Y좌표 (위도좌표)
        urlBuilder.append("&").append(URLEncoder.encode("EY", UTF_8)).append("=").append(URLEncoder.encode(requestDto.getEy(), UTF_8));

        // 도시 내 경로수단을 지정한다. (2: 버스)
        urlBuilder.append("&").append(URLEncoder.encode("SearchPathType", UTF_8)).append("=").append(2);

        return urlBuilder;
    }
}
