package kr.ac.kumoh.sjjpl138.wheere.member.service;

import kr.ac.kumoh.sjjpl138.wheere.bus.Bus;
import kr.ac.kumoh.sjjpl138.wheere.bus.repository.BusRepository;
import kr.ac.kumoh.sjjpl138.wheere.driver.Driver;
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
     * ????????? ?????? (????????????)
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
     * ????????? ?????? ?????? (?????????)
     * - fcm token ??????
     *
     * @param request
     * @return
     */
    @Transactional
    public Member logIn(MemberLoginRequest request) {
        String memberId = request.getMId();
        String fcmToken = request.getFcmToken();

        Member member = memberRepository.findById(memberId).get();
        member.registerToken(fcmToken);

        return member;
    }

    /**
     * ????????? ????????????
     * - fcm token ??????
     *
     * @param memberId
     */
    @Transactional
    public void logout(String memberId) {
        Member findMember = memberRepository.findById(memberId).get();
        findMember.deleteToken();
    }

    /**
     * ????????? ?????? ??????
     */
    @Transactional
    public void update(MemberInfoDto memberDto) {
        String id = memberDto.getMId();
        Member findMember = memberRepository.findById(id).get();

        findMember.updateMemberInfo(memberDto);
    }

    /**
     * ????????? ?????? (????????????)
     *
     * @param mId
     */
    @Transactional
    public void delete(String mId) {
        Member findMember = memberRepository.findById(mId).get();
        memberRepository.delete(findMember);
    }

    /**
     * ?????? ?????? ?????? ?????????
     *
     * @param rating
     */
    @Transactional
    public void rateDriver(Long rId, Long bId, double rating) {
        Reservation resv = reservationRepository.findResvById(rId);
        Driver driver = driverRepository.findByBusId(bId).get();
        driver.calculateRating(rating);
        changeStateToComp(resv);
    }

    private void changeStateToComp(Reservation resv) {
        resv.changeStatusToRVW_COMP();
    }

    /**
     * ?????????, ????????? ????????? ?????? ??????
     * ???????????? ????????? api??? ????????? ????????? ??????
     */
    public Optional<AllCourseCase> checkRoutes(RetrieveRoutesRequest requestDto) {

        // ???????????? ????????? API Url ??????
        StringBuilder urlBuilder = setUrl(requestDto);

        // GET ???????????? ???????????? ???????????? ????????????
        try {
            URL url = createUrl(urlBuilder);

            String jsonResult = extractJson(url);

            // json ??????
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

        // ?????? 0 (?????????) ??? ???????????? ???????????????
        int searchType = getSearchType(rootJsonObject);

        // ????????? ????????? ?????? ?????? ?????? ?????? empty Optional ??????
        if (isNotInCity(searchType)) {
            return Optional.empty();
        }

        // ????????? '??????' ?????? ?????? ?????? (0: ??????, 1: ?????? ??????)
        int outTrafficCheck = getOutTrafficCheck(rootJsonObject);
        allCourseCase.setOutTrafficCheck(outTrafficCheck);

        List<Course> courses = createCourses(rootJsonObject);

        allCourseCase.setCourses(courses);

        return Optional.of(allCourseCase);
    }

    private List<Course> createCourses(JSONObject rootJsonObject) {
        List<Course> courses = new ArrayList<>();

        // ?????? ????????? ?????? ??????
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

            // ????????? -> ????????? ????????? ??? ????????? ??????
            JSONObject pathObj = getPathObj(path, i);

            // ?????? ?????? ?????? ??????
            JSONObject info = getInfo(pathObj);

            // ?????? ?????? ????????? (1?????? ??????)
            // busTransitCount + 1 = ??????
            int busTransitCount = getBusTransitCount(info);

            // ????????? ?????? 2?????? ??????????????? ?????? ????????? ??????????????? ??????
            if (busTransitCount > 2) continue;

            Course course = new Course();

            List<SubCourse> subCourses = new ArrayList<>();

            // ??? ??????
            int payment = getPayment(info);
            course.setPayment(payment);

            course.setBusTransitCount(busTransitCount);

            String firstStartStation = getFirstStartStation(info);
            course.setFirstStartStation(firstStartStation);

            String lastEndStation = getLastEndStation(info);
            course.setLastEndStation(lastEndStation);

            // ?????? ?????? ?????? ?????? ?????? ??????
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

            // ?????? ?????? ??????
            // 1: ?????????, 2: ??????, 3: ?????? (2, 3??? ????????? ???????????? ????????????)
            int trafficType = getTrafficType(subPathObj);
            subCourse.setTrafficType(trafficType);

            // ?????? ?????? ??????
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

        // ?????? ?????? ?????? ?????? ??????
        addBusNo(subPathObj, busNoList);

        // ?????? ???????????? ?????? ?????? ??????
        JSONObject passStopList = getPassStopList(subPathObj);

        // ????????? ?????? ?????? ??????
        JSONArray stations = getStations(passStopList);

        // ????????? ????????? ??????
        JSONObject firstPassStopObj = getPassStopObj(stations, 0);

        // ????????? ????????? ID
        int firstStationID = getStationID(firstPassStopObj);

        // ????????? ????????? ??????
        String firstStationName = getStationName(firstPassStopObj);

        // ????????? ????????? ??????
        JSONObject lastPassStopObj = getPassStopObj(stations, stations.length() - 1);

        // ????????? ????????? ID
        int lastStationID = getStationID(lastPassStopObj);

        // ????????? ????????? ??????
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

        // ????????? X?????? (????????????)
        urlBuilder.append("&").append(URLEncoder.encode("SX", UTF_8)).append("=").append(URLEncoder.encode(requestDto.getSx(), UTF_8));

        //????????? Y?????? (????????????)
        urlBuilder.append("&").append(URLEncoder.encode("SY", UTF_8)).append("=").append(URLEncoder.encode(requestDto.getSy(), UTF_8));

        // ????????? X?????? (????????????)
        urlBuilder.append("&").append(URLEncoder.encode("EX", UTF_8)).append("=").append(URLEncoder.encode(requestDto.getEx(), UTF_8));

        // ????????? Y?????? (????????????)
        urlBuilder.append("&").append(URLEncoder.encode("EY", UTF_8)).append("=").append(URLEncoder.encode(requestDto.getEy(), UTF_8));

        // ?????? ??? ??????????????? ????????????. (2: ??????)
        urlBuilder.append("&").append(URLEncoder.encode("SearchPathType", UTF_8)).append("=").append(2);

        return urlBuilder;
    }

    /**
     * ???????????? ????????? API??? ????????? ?????? ????????? ??????
     */
    public RetrieveRoutesResult checkBusTime(AllCourseCase allRouteCase, LocalDate rDate) {

        // ?????? ????????? ???
        List<Course> courses = allRouteCase.getCourses();

        RetrieveRoutesResult retrieveRoutesResult = new RetrieveRoutesResult();
        retrieveRoutesResult.setOutTrafficCheck(allRouteCase.getOutTrafficCheck());
        List<Route> routes = new ArrayList<>();

        // ????????? ??? ??? ??????
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
                    List<Bus> findBus = busRepository.findByBusNoAndBusDate(busNo, rDate);
                    if (findBus.isEmpty()) {
                        continue;
                    }
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
        } else if(routeCase.size() == 1){

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

            // ?????? ?????? ????????? ?????? BusId??? ?????? ????????????
            List<Long> findBusIds = busRepository.findBusIdByBusNoAndBusDate(busNo, rDate);

            List<Long> runBusIdList = new ArrayList<>();
            List<LocalTime> startStationArrivalTimes = new ArrayList<>();
            List<LocalTime> endStationArrivalTimes = new ArrayList<>();
            List<Integer> findLeftSeats = new ArrayList<>();

            Map<Long, List<Platform>> busPlatformMap = new HashMap<>();

            for (Long findBusId : findBusIds) {

                // ??????, ?????? ????????? ????????? ????????? runBusNoList??? ??????
                List<Platform> findPlatforms = platformRepository.findPlatformByBusIdAndStationId(findBusId, stationIdList);

                if (findPlatforms.size() != 2) {
                    continue;
                }

                busPlatformMap.put(findBusId, findPlatforms);

                Platform startPlatform;
                Platform endPlatform;

                Platform firstTmpPlatform = findPlatforms.get(0);
                Platform secondTmpPlatform = findPlatforms.get(1);

                if (firstTmpPlatform.getArrivalTime().isBefore(secondTmpPlatform.getArrivalTime())) {

                    startPlatform = firstTmpPlatform;
                    endPlatform = secondTmpPlatform;
                } else {
                    startPlatform = secondTmpPlatform;
                    endPlatform = firstTmpPlatform;
                }

                runBusIdList.add(findBusId);
                startStationArrivalTimes.add(startPlatform.getArrivalTime());
                endStationArrivalTimes.add(endPlatform.getArrivalTime());
            }

            Map<Long, List<LocalTime>> combineTimes = combineLists(runBusIdList, startStationArrivalTimes, endStationArrivalTimes);

            // ?????? ????????? ???????????? combineTimes ??????
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

                // ?????? ????????? ?????? ?????? -> ????????? ????????? ?????? ??????
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

    public static Map<Long, List<LocalTime>> combineLists(List<Long> idList, List<LocalTime> startStationArrivalTimes, List<LocalTime> endStationArrivalTimes) {
        if (idList.size() != startStationArrivalTimes.size() || idList.size() != endStationArrivalTimes.size()) {
            throw new IllegalArgumentException("Lists must have the same size");
        }

        return IntStream.range(0, idList.size())
                .boxed()
                .map(index -> new AbstractMap.SimpleEntry<>(idList.get(index), List.of(startStationArrivalTimes.get(index), endStationArrivalTimes.get(index))))
                .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));
    }
}
