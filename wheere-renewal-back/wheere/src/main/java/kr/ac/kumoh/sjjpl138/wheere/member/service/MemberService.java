package kr.ac.kumoh.sjjpl138.wheere.member.service;

import kr.ac.kumoh.sjjpl138.wheere.bus.Bus;
import kr.ac.kumoh.sjjpl138.wheere.member.SubRoute;
import kr.ac.kumoh.sjjpl138.wheere.bus.repository.BusRepository;
import kr.ac.kumoh.sjjpl138.wheere.driver.Driver;
import kr.ac.kumoh.sjjpl138.wheere.member.*;
import kr.ac.kumoh.sjjpl138.wheere.member.sub.AllCourseCase;
import kr.ac.kumoh.sjjpl138.wheere.member.sub.BusLane;
import kr.ac.kumoh.sjjpl138.wheere.member.sub.Course;
import kr.ac.kumoh.sjjpl138.wheere.member.sub.SubCourse;
import kr.ac.kumoh.sjjpl138.wheere.platform.repository.PlatformRepository;
import kr.ac.kumoh.sjjpl138.wheere.seat.repository.SeatRepository;
import lombok.extern.slf4j.Slf4j;
import org.json.JSONArray;
import org.json.JSONObject;

import kr.ac.kumoh.sjjpl138.wheere.driver.repository.DriverRepository;
import kr.ac.kumoh.sjjpl138.wheere.member.dto.MemberDto;
import kr.ac.kumoh.sjjpl138.wheere.member.repository.MemberRepository;
import kr.ac.kumoh.sjjpl138.wheere.reservation.Reservation;
import kr.ac.kumoh.sjjpl138.wheere.reservation.repository.ReservationRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

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
    private final ReservationRepository reservationRepository;
    private final BusRepository busRepository;
    private final PlatformRepository platformRepository;

    private final SeatRepository seatRepository;

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
        Member member = memberRepository.findById(memberId).get();

        return member;
    }

    /**
     * 사용자 정보 수정
     */
    @Transactional
    public void update(MemberDto memberDto) {
        String id = memberDto.getMId();
        Member findMember = memberRepository.findById(id).get();
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
    public void rateDriver(Long rId, Long bId, double rating) {
        Reservation resv = reservationRepository.findResvById(rId);
        Driver driver = driverRepository.findByBusId(bId).get();
        driver.calculateRating(rating);
        resv.changeResvStatus();
    }

    /**
     * 출발지, 도착지 좌표를 입력 받아
     * 대중교통 길찾기 api를 사용해 선택지 제공
     */
    public Optional<AllCourseCase> checkRoutes(RetrieveRoutesRequest requestDto) {

        // 대주교통 길차지 API Url 설정
        StringBuilder urlBuilder = setUrl(requestDto);

        // GET 방식으로 전송해서 파라미터 받아오기
        try {
            URL url = createUrl(urlBuilder);

            String jsonResult = extractJson(url);

            // json 파싱
            return extractAllCourseCase(jsonResult);

        } catch (MalformedURLException e) {
            e.printStackTrace();
            String message = e.getMessage();
            log.error("message = {}", message);

            return Optional.empty();
        }
    }

    private Optional<AllCourseCase> extractAllCourseCase(String jsonResult) {

        AllCourseCase allCourseCase = new AllCourseCase();

        /* json parsing */
        JSONObject rootJsonObject = getJsonObject(jsonResult);

        // 값이 0 (도시내) 인 경우에만 응답하도록
        int searchType = getSearchType(rootJsonObject);

        // 조회한 범위가 도시 내가 아닌 경우 empty Optional 반환
        if (isNotInCity(searchType)) {
            return Optional.empty();
        }

        // 도시간 '직통' 탐색 결과 유무 (0: 직통, 1: 직통 없음)
        int outTrafficCheck = getOutTrafficCheck(rootJsonObject);
        allCourseCase.setOutTrafficCheck(outTrafficCheck);

        List<Course> courses = createCourses(rootJsonObject);

        allCourseCase.setCourses(courses);

        return Optional.of(allCourseCase);
    }

    private List<Course> createCourses(JSONObject rootJsonObject) {
        List<Course> courses = new ArrayList<>();

        // 결과 리스트 확장 노드
        JSONArray path = getPath(rootJsonObject);

        addCourse(courses, path);
        return courses;
    }

    private JSONArray getPath(JSONObject rootJsonObject) {
        return rootJsonObject.getJSONArray("path");
    }

    private JSONObject getJsonObject(String jsonResult) {
        JSONObject jsonObj = new JSONObject(jsonResult);
        return jsonObj.getJSONObject("result");
    }

    private int getSearchType(JSONObject rootJsonObject) {
        int searchType = rootJsonObject.getInt("searchType");
        log.debug("searchType = {}", searchType);
        return searchType;
    }

    private int getOutTrafficCheck(JSONObject rootJsonObject) {
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

    private JSONObject getPathObj(JSONArray path, int i) {
        return path.getJSONObject(i);
    }

    private JSONObject getInfo(JSONObject pathObj) {
        return pathObj.getJSONObject("info");
    }

    private int getBusTransitCount(JSONObject info) {
        int busTransitCount = info.getInt("busTransitCount");
        log.debug("busTransitCount = {}", busTransitCount);
        return busTransitCount;
    }

    private int getPayment(JSONObject info) {
        int payment = info.getInt("payment");
        log.debug("payment = {}", payment);
        return payment;
    }

    private JSONArray getSubPath(JSONObject pathObj) {
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

            if (trafficType == 2) {
                createBusLane(subCourse, subPathObj);
            } else {
                subCourse.setBusLane(Optional.ofNullable(null));
            }

            subCourses.add(subCourse);
        }
    }

    private JSONObject getSubPathObj(JSONArray subPath, int index) {
        return subPath.getJSONObject(index);
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

    private void createBusLane(SubCourse subCourse, JSONObject subPathObj) {
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

    private void addBusNo(JSONObject subPathObj, List<String> busNoList) {
        JSONArray lane = getLane(subPathObj);

        for (int r = 0; r < lane.length(); r++) {
            busNoList.add(getBusNo(getLaneObj(lane, r)));
        }
    }

    private JSONObject getLaneObj(JSONArray lane, int index) {
        return lane.getJSONObject(index);
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

    private String extractJson(URL url) {

        try {
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
        } catch (IOException e) {
            e.printStackTrace();
            String message = e.getMessage();
            log.error("message = {}", message);
            return null;
        }
    }

    private boolean isOK(HttpURLConnection conn) throws IOException {
        return conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300;
    }

    private URL createUrl(StringBuilder urlBuilder) throws MalformedURLException {

        return new URL(urlBuilder.toString());
    }

    private StringBuilder setUrl(RetrieveRoutesRequest requestDto) {
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

    /**
     * 대중교통 길찾기 API로 추출한 버스 시간표 조회
     */
    public RetrieveRoutesResult checkBusTime(AllCourseCase allRouteCase, LocalDate rDate) {

        // 모든 경우의 수
        List<Course> courses = allRouteCase.getCourses();

        RetrieveRoutesResult retrieveRoutesResult = new RetrieveRoutesResult();
        retrieveRoutesResult.setOutTrafficCheck(allRouteCase.getOutTrafficCheck());

        List<CoursePerHour> selects = new ArrayList<>();

        for (int i = 0; i < 24; i++) {

            CoursePerHour coursePerHour = new CoursePerHour();
            coursePerHour.setSelectTime(i);

            List<Route> routes = new ArrayList<>();

            // 경우의 수 중 하나
            for (Course course : courses) {

                Route route = new Route();
                route.setPayment(course.getPayment());
                route.setBusTransitCount(course.getBusTransitCount());

                List<SubRoute> subRoutes = new ArrayList<>();

                List<SubCourse> subCourses = course.getSubCourses();
                for (SubCourse subCourse : subCourses) {

                    SubRoute subRoute = new SubRoute();
                    subRoute.setTrafficType(subCourse.getTrafficType());
                    subRoute.setSectionTime(subCourse.getSectionTime());

                    Optional<BusLane> busLane = subCourse.getBusLane();


                    // ================================================================================ //

                    busLane.ifPresent(b -> {

                        List<String> busNoList = b.getBusNoList();
                        for (String busNo : busNoList) {

                            BusRoute busRoute = new BusRoute();

                            int boardStationID = b.getBoardStationID();
                            int alightStationID = b.getAlightStationID();

                            busRoute.setBNo(busNo);
                            busRoute.setSStationId(boardStationID);
                            busRoute.setSStationName(b.getBoardStationName());
                            busRoute.setEStationId(alightStationID);
                            busRoute.setEStationName(b.getAlightStationName());

                            List<Bus> findBusList = busRepository.findByBusNo(busNo);

                            List<Long> findBusIDs = findBusList.stream().map(Bus::getId).collect(Collectors.toList());

                            for (Long findBusID : findBusIDs) {

                                busRoute.setBusId(findBusID);

                                List<Long> stationIdList = Arrays.asList((long) boardStationID, (long) alightStationID);
                                List<LocalTime> arrivalTimes = platformRepository.searchArrivalTime(findBusID, stationIdList);

                                busRoute.setSTime(arrivalTimes.get(0));
                                busRoute.setETime(arrivalTimes.get(1));

                                List<Integer> findSeq = platformRepository.findAllocationSeqByBusIdAndStationIdList(findBusID, stationIdList);

                                Integer firstStationSeq = findSeq.get(0);
                                Integer lastStationSeq = findSeq.get(0);

                                List<Integer> seqList = new ArrayList<>();
                                for (int j = firstStationSeq; j <= lastStationSeq; j++) {
                                    seqList.add(j);
                                }

                                Optional<Integer> minLeftSeatsNo = seatRepository.findMinLeftSeatsByStation(findBusID, seqList, rDate);
                                if (minLeftSeatsNo.isEmpty()) {
                                    busRoute.setLeftSeats(2);
                                } else {
                                    busRoute.setLeftSeats(minLeftSeatsNo.get());
                                }
                            }
                            subRoute.setBusRoute(busRoute);
                        }
                    });

                    // ================================================================================ //

                    subRoutes.add(subRoute);
                }
                // 둘이 분리시켜야 할듯
                route.setSubRoutes(subRoutes);
                routes.add(route);
            }
            coursePerHour.setRoutes(routes);
            selects.add(coursePerHour);
        }
        retrieveRoutesResult.setSelects(selects);
        return retrieveRoutesResult;
    }

    private List<Long> extractBusIdList(String busNo) {
        List<Bus> findBusList = busRepository.findByBusNo(busNo);

        return findBusList.stream().map(Bus::getId).collect(Collectors.toList());
    }

    private void setArrivalTimes(BusRoute busRoute, Long findBusID, List<Long> stationIdList) {
        List<LocalTime> arrivalTimes = platformRepository.searchArrivalTime(findBusID, stationIdList);

        busRoute.setSTime(arrivalTimes.get(0));
        busRoute.setETime(arrivalTimes.get(1));
    }

    private void setLeftSeats(LocalDate rDate, BusRoute busRoute, Long findBusID, List<Integer> findSeq) {
        Integer firstStationSeq = findSeq.get(0);
        Integer lastStationSeq = findSeq.get(0);

        List<Integer> seqList = new ArrayList<>();
        for (int j = firstStationSeq; j <= lastStationSeq; j++) {
            seqList.add(j);
        }

        Optional<Integer> minLeftSeatsNo = seatRepository.findMinLeftSeatsByStation(findBusID, seqList, rDate);
        if (minLeftSeatsNo.isEmpty()) {
            busRoute.setLeftSeats(2);
        } else {
            busRoute.setLeftSeats(minLeftSeatsNo.get());
        }
    }
}
