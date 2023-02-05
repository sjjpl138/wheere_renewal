package kr.ac.kumoh.sjjpl138.wheere.member.service;

import kr.ac.kumoh.sjjpl138.wheere.bus.repository.BusRepository;
import kr.ac.kumoh.sjjpl138.wheere.driver.Driver;
import kr.ac.kumoh.sjjpl138.wheere.exception.NotExistDriverException;
import kr.ac.kumoh.sjjpl138.wheere.exception.NotExistMemberException;
import kr.ac.kumoh.sjjpl138.wheere.exception.ReservationException;
import kr.ac.kumoh.sjjpl138.wheere.member.*;
import kr.ac.kumoh.sjjpl138.wheere.member.dto.MemberLoginRequest;
import kr.ac.kumoh.sjjpl138.wheere.member.dto.MemberInfoDto;
import kr.ac.kumoh.sjjpl138.wheere.member.response.BusRoute;
import kr.ac.kumoh.sjjpl138.wheere.member.response.RetrieveRoutesResult;
import kr.ac.kumoh.sjjpl138.wheere.member.response.Route;
import kr.ac.kumoh.sjjpl138.wheere.member.response.SubRoute;
import kr.ac.kumoh.sjjpl138.wheere.member.sub.AllCourseCase;
import kr.ac.kumoh.sjjpl138.wheere.member.sub.BusLane;
import kr.ac.kumoh.sjjpl138.wheere.member.sub.Course;
import kr.ac.kumoh.sjjpl138.wheere.member.sub.SubCourse;
import kr.ac.kumoh.sjjpl138.wheere.platform.Platform;
import kr.ac.kumoh.sjjpl138.wheere.platform.repository.PlatformRepository;
import kr.ac.kumoh.sjjpl138.wheere.seat.repository.SeatRepository;
import lombok.extern.slf4j.Slf4j;
import org.json.JSONArray;
import org.json.JSONObject;

import kr.ac.kumoh.sjjpl138.wheere.driver.repository.DriverRepository;
import kr.ac.kumoh.sjjpl138.wheere.member.RetrieveRoutesRequest;
import kr.ac.kumoh.sjjpl138.wheere.member.repository.MemberRepository;
import kr.ac.kumoh.sjjpl138.wheere.reservation.Reservation;
import kr.ac.kumoh.sjjpl138.wheere.reservation.repository.ReservationRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

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
    public Member join(MemberInfoDto memberDto) {
        Member member = changeMemberEntity(memberDto);
        memberRepository.save(member);

        return member;
    }

    private Member changeMemberEntity(MemberInfoDto memberDto) {
        String id = memberDto.getMId();
        String name = memberDto.getMName();
        LocalDate birthDate = memberDto.getMBirthDate();
        String sex = memberDto.getMSex();
        String num = memberDto.getMNum();

        Member member = new Member(id, name, birthDate, sex, num, null);

        return member;
    }

    /**
     * 사용자 정보 조회 (로그인)
     * - fcm token 저장
     *
     * @param request
     * @return
     */
    @Transactional
    public Member logIn(MemberLoginRequest request) {
        String memberId = request.getMId();
        String fcmToken = request.getFcmToken();

        Member findMember = memberRepository.findById(memberId).get();
        if (findMember == null) throw new NotExistMemberException("존재하지 않는 회원입니다.");
        findMember.registerToken(fcmToken);

        return findMember;
    }

    /**
     * 사용자 로그아웃
     * - fcm token 삭제
     *
     * @param memberId
     */
    @Transactional
    public void logout(String memberId) {
        Member findMember = memberRepository.findById(memberId).get();
        if (findMember == null) throw new NotExistMemberException("존재하지 않는 회원입니다.");

        findMember.deleteToken();
    }

    /**
     * 사용자 정보 수정
     */
    @Transactional
    public void update(MemberInfoDto memberDto) {
        String id = memberDto.getMId();
        Member findMember = memberRepository.findById(id).get();
        if (findMember == null) throw new NotExistMemberException("존재하지 않는 회원입니다.");

        findMember.updateMemberInfo(memberDto);
    }

    /**
     * 사용자 삭제 (탈퇴하기)
     *
     * @param mId
     */
    @Transactional
    public void delete(String mId) {
        Member findMember = memberRepository.findById(mId).get();
        if (findMember == null) throw new NotExistMemberException("존재하지 않는 회원입니다.");

        memberRepository.delete(findMember);
    }

    /**
     * 버스 기사 평점 매기기
     *
     * @param rating
     */
    @Transactional
    public void rateDriver(Long rId, Long bId, double rating) {
        Reservation resv = reservationRepository.findResvById(rId);
        if (resv == null) throw new ReservationException("존재하지 않는 예약입니다.");

        Driver driver = driverRepository.findByBusId(bId).get();
        if (driver == null) throw new NotExistDriverException("존재하지 않는 버스 기사입니다.");

        driver.calculateRating(rating);
        changeStateToComp(resv);
    }

    private void changeStateToComp(Reservation resv) {
        resv.changeStatusToRVW_COMP();
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

            // 출발지 -> 목적지 경우의 수 중에서 하나
            JSONObject pathObj = getPathObj(path, i);

            // 요약 정보 확장 노드
            JSONObject info = getInfo(pathObj);

            // 버스 환승 카운트 (1부터 시작)
            // busTransitCount + 1 = 도보
            int busTransitCount = getBusTransitCount(info);

            // 버스는 최대 2개만 탑승하도록 아닌 경우는 제공해주지 않음
            if (busTransitCount > 2) continue;

            Course course = new Course();

            List<SubCourse> subCourses = new ArrayList<>();

            // 총 요금
            int payment = getPayment(info);
            course.setPayment(payment);

            course.setBusTransitCount(busTransitCount);

            String firstStartStation = getFirstStartStation(info);
            course.setFirstStartStation(firstStartStation);

            String lastEndStation = getLastEndStation(info);
            course.setLastEndStation(lastEndStation);

            // 이동 교통 수단 정보 확장 노드
            JSONArray subPath = getSubPath(pathObj);

            addSubCourse(subCourses, subPath);

            course.setSubCourses(subCourses);
            courses.add(course);
        }
    }

    private String getLastEndStation(JSONObject info) {
        String lastEndStation = info.getString("lastEndStation");
        log.debug("lastEndStation = {}", lastEndStation);
        return lastEndStation;
    }

    private String getFirstStartStation(JSONObject info) {
        String firstStartStation = info.getString("firstStartStation");
        log.debug("firstStartStation = {}", firstStartStation);
        return firstStartStation;
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
        List<Route> routes = new ArrayList<>();

        // 경우의 수 중 하나
        for (Course course : courses) {

            List<SubRoute> onlyWalk = new ArrayList<>();
            List<SubRoute> onlyBus = new ArrayList<>();

            MultiValueMap<Integer, String> routeCase = new LinkedMultiValueMap<>();
            Integer index = 0;

            List<SubCourse> subCourses = course.getSubCourses();
            for (SubCourse subCourse : subCourses) {

                SubRoute subRoute = new SubRoute();
                subRoute.setTrafficType(subCourse.getTrafficType());
                subRoute.setSectionTime(subCourse.getSectionTime());

                Optional<BusLane> busLane = subCourse.getBusLane();

                if (busLane.isEmpty()) {
                    onlyWalk.add(subRoute);
                    continue;
                }

                BusLane findBusLane = busLane.get();

                BusRoute busRoute = new BusRoute();
                busRoute.setSStationId(findBusLane.getBoardStationID());
                busRoute.setSStationName(findBusLane.getBoardStationName());
                busRoute.setEStationId(findBusLane.getAlightStationID());
                busRoute.setEStationName(findBusLane.getAlightStationName());

                subRoute.setBusRoute(busRoute);

                onlyBus.add(subRoute);

                List<String> busNoList = findBusLane.getBusNoList();

                for (String busNo : busNoList) {
                    routeCase.add(index, busNo);
                }

                index++;
            }

            Map<String, SubRoute> busMap = new HashMap<>();

            for (int i = 0; i < routeCase.size(); i++) {

                List<String> busNoList = routeCase.get(i);
                SubRoute subRouteForBus = onlyBus.get(i);

                BusRoute findBusRoute = subRouteForBus.getBusRoute();

                int startStationId = findBusRoute.getSStationId();
                int endStationId = findBusRoute.getEStationId();

                List<Long> stationIdList = Arrays.asList((long) startStationId, (long) endStationId);

                addToBusMap(rDate, busNoList, busMap, subRouteForBus, findBusRoute, stationIdList);
            }

            addToRoutes(routes, course, onlyWalk, routeCase, busMap);
        }

        retrieveRoutesResult.setRoutes(routes);
        return retrieveRoutesResult;
    }

    private void addToRoutes(List<Route> routes, Course course, List<SubRoute> onlyWalk, MultiValueMap<Integer, String> routeCase, Map<String, SubRoute> busMap) {

        List<String> firstBusNoList = routeCase.get(0);

        if (routeCase.size() == 2) {
            List<String> secondBusNoList = routeCase.get(1);

            for (String firstBusNo : firstBusNoList) {
                for (String secondBusNo : secondBusNoList) {

                    Route route = new Route();

                    route.setPayment(course.getPayment());
                    route.setBusTransitCount(course.getBusTransitCount());
                    route.setFirstStartStation(course.getFirstStartStation());
                    route.setLastEndStation(course.getLastEndStation());

                    List<SubRoute> subRoutes = new ArrayList<>();

                    SubRoute firstWalkSubRoute = onlyWalk.get(0);
                    subRoutes.add(firstWalkSubRoute);

                    SubRoute firstBusSubRoute = busMap.get(firstBusNo);
                    subRoutes.add(firstBusSubRoute);

                    SubRoute secondWalkSubRoute = onlyWalk.get(1);
                    subRoutes.add(secondWalkSubRoute);

                    SubRoute secondBusSubRoute = busMap.get(secondBusNo);
                    subRoutes.add(secondBusSubRoute);

                    SubRoute thirdWalkSubRoute = onlyWalk.get(2);
                    subRoutes.add(thirdWalkSubRoute);

                    route.setSubRoutes(subRoutes);
                    routes.add(route);
                }
            }
        } else {

            for (String firstBusNo : firstBusNoList) {

                Route route = new Route();

                route.setPayment(course.getPayment());
                route.setBusTransitCount(course.getBusTransitCount());
                route.setFirstStartStation(course.getFirstStartStation());
                route.setLastEndStation(course.getLastEndStation());

                List<SubRoute> subRoutes = new ArrayList<>();

                SubRoute firstWalkSubRoute = onlyWalk.get(0);
                subRoutes.add(firstWalkSubRoute);
                SubRoute firstBusSubRoute = busMap.get(firstBusNo);
                subRoutes.add(firstBusSubRoute);
                SubRoute secondWalkSubRoute = onlyWalk.get(1);
                subRoutes.add(secondWalkSubRoute);

                route.setSubRoutes(subRoutes);
                routes.add(route);
            }
        }
    }

    private void addToBusMap(LocalDate rDate, List<String> busNoList, Map<String, SubRoute> busMap, SubRoute busSubRoute, BusRoute findBusRoute, List<Long> stationIdList) {

        int leftSeatsNum;

        for (String busNo : busNoList) {

            SubRoute subRoute = new SubRoute();
            subRoute.setTrafficType(busSubRoute.getTrafficType());
            subRoute.setSectionTime(busSubRoute.getSectionTime());

            // 특정 버스 번호에 대해 BusId를 모두 조회하기
            List<Long> findBusIds = busRepository.findBusIdByBusNo(busNo);

            List<Long> runBusNoList = new ArrayList<>();
            List<LocalTime> startStationArrivalTimes = new ArrayList<>();
            List<LocalTime> endStationArrivalTimes = new ArrayList<>();
            List<Integer> findLeftSeats = new ArrayList<>();

            Map<Long, List<Platform>> busPlatformMap = new HashMap<>();

            for (Long findBusId : findBusIds) {

                // 출발, 도착 정류장 모두를 지나면 runBusNoList에 추가
                List<Platform> findPlatforms = platformRepository.findPlatformByBusIdAndStationId(findBusId, stationIdList);

                busPlatformMap.put(findBusId, findPlatforms);

                if (findPlatforms.size() != 2) {
                    continue;
                }

                Platform startPlatform = findPlatforms.get(0);
                Platform endPlatform = findPlatforms.get(1);

                runBusNoList.add(findBusId);
                startStationArrivalTimes.add(startPlatform.getArrivalTime());
                endStationArrivalTimes.add(endPlatform.getArrivalTime());
            }

            Map<Long, List<LocalTime>> combineTimes = combineLists(runBusNoList, startStationArrivalTimes, endStationArrivalTimes);

            // 출발 시간을 기준으로 combineTimes 정렬
            Map<Long, List<LocalTime>> timePerBus = combineTimes.entrySet().stream()
                    .sorted(Comparator.comparing(entry -> entry.getValue().get(0)))
                    .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue, (a, b) -> b, LinkedHashMap::new));

            startStationArrivalTimes.clear();
            endStationArrivalTimes.clear();

            timePerBus.forEach((key, value) -> {

                startStationArrivalTimes.add(value.get(0));
                endStationArrivalTimes.add(value.get(1));
            });

            List<Long> orderedBusIds = new ArrayList<>(timePerBus.keySet());

            for (Long busId : orderedBusIds) {

                List<Platform> findPlatforms = busPlatformMap.get(busId);

                Platform startPlatform = findPlatforms.get(0);
                Platform endPlatform = findPlatforms.get(1);

                int startSeq = startPlatform.getStationSeq();
                int endSeq = endPlatform.getStationSeq();

                List<Integer> seqList = new ArrayList<>();
                for (int i = startSeq; i <= endSeq; i++) {
                    seqList.add(i);
                }

                // 이걸 뒤에서 따로 조회 -> 그러면 정류장 순서 필요
                Optional<Integer> minLeftSeats = seatRepository.findMinLeftSeatsByBusIdAndDateAndSeqIn(busId, rDate, seqList);

                if (minLeftSeats.isEmpty()) {
                    leftSeatsNum = 2;
                } else {
                    leftSeatsNum = minLeftSeats.get();
                }

                findLeftSeats.add(leftSeatsNum);
            }

            BusRoute busRoute = new BusRoute();
            busRoute.setBNo(busNo);
            busRoute.setBusId(orderedBusIds);
            busRoute.setSStationId(findBusRoute.getSStationId());
            busRoute.setSStationName(findBusRoute.getSStationName());
            busRoute.setSTime(startStationArrivalTimes);
            busRoute.setEStationId(findBusRoute.getEStationId());
            busRoute.setEStationName(findBusRoute.getEStationName());
            busRoute.setETime(endStationArrivalTimes);
            busRoute.setLeftSeats(findLeftSeats);

            subRoute.setBusRoute(busRoute);

            busMap.put(busNo, subRoute);
        }
    }

    public static Map<Long, List<LocalTime>> combineLists(List<Long> idList, List<LocalTime> timeList1, List<LocalTime> timeList2) {
        if (idList.size() != timeList1.size() || idList.size() != timeList2.size()) {
            throw new IllegalArgumentException("Lists must have the same size");
        }

        return IntStream.range(0, idList.size())
                .boxed()
                .map(index -> new AbstractMap.SimpleEntry<>(idList.get(index), List.of(timeList1.get(index), timeList2.get(index))))
                .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));
    }
}
