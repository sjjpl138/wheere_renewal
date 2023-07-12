# Wheere_Renewal
> 교통약자를 위한 모바일 버스 예약 시스템

## 💡 Demo (youtube)
유튜브 링크 올라올 예정

## ☑️ 핵심기능 설명
#### ✔️ 버스 예약
- 교통약자를 위한 저상버스 예약 기능을 제공합니다.
- 사용자는 출발지와 도착지 그리고 예약을 원하는 날짜를 입력해 버스 경로를 조회할 수 있습니다.
- 대중교통 정보 플랫폼 (ODsay)에서 제공하는 '대중교통 길 찾기' API와 실제 버스 운행 정보를 활용하여 사용자에게 버스 경로를 제공합니다.
- 저상버스의 남은 휠체어 좌석을 계산해 정보를 제공합니다.
- 사용자는 카카오 결제 기능을 통해 미리 결제할 수 있습니다.
- 예약이 정상적으로 완료되면 버스 운전자에게 FCM(Firebase Cloud Messaging)을 활용해 알림 메시지가 전송됩니다.

#### ✔️ 예약 조회
- 사용자에게 예약 정보 조회 기능을 제공합니다.
- 사용자는 검색 조건을 설정해 원하는 예약 상태만 조회할 수 있습니다.
- 사용자는 예약한 버스의 실시간 위치를 파악할 수 있습니다.

#### ✔️ 예약 취소
- 사용자에게 예약 취소 기능을 제공합니다.
- 사용자는 버스 탑승 전 언제든지 예약을 취소할 수 있습니다.

#### ✔️ 평점 작성
- 사용자에게 평점 작성 기능을 제공합니다.
- 예약이 종료(버스 하차)되면 사용자에게 평점 알림이 전송됩니다.
- 사용자는 버스 운전자의 서비스에 대해 평점을 작성할 수 있습니다.

#### ✔️ 버스 운전자 기능
- 버스 운전자에게 버스 운행 경로 및 정류장마다 승•하차 정보와 잔여 휠체어 좌석 정보를 제공합니다.
- 새로운 예약이 생성되거나 취소되면 알림을 받을 수 있습니다.
- 버스 운전자는 각 정류장에서 승•하차 사용자의 정보를 조회할 수 있습니다.

#### ✔️ 알림 기능
- FCM(Firebase Cloud Messaging)을 활용한 알림 기능을 제공합니다.
- 예약이 생성 • 취소 • 종료되면 알림이 발생합니다.

## 🐾 개발 일정
<p align="center"><img src="https://github.com/sjjpl138/wheere_renewal/assets/97449471/abfcc238-e742-4805-a6ac-a6f5e147818d.png" width=80% /></p>

## 🌈 전체 시스템 구조
<p align="center"><img src="https://github.com/sjjpl138/wheere_renewal/assets/97449471/bfda7f06-aa37-4191-92a6-8a963afcda99.png" width=80% /></p>

## 📃 데이터베이스 구조
<p align="center"><img src="https://github.com/sjjpl138/wheere_renewal/assets/97449471/48689d13-2732-4917-bce5-c97bd27a7143.png" width=700 height=450 /></p>

## 🖨️ Api 명세서
<p align="center"><img src="https://github.com/sjjpl138/wheere_renewal/assets/97449471/60a65db5-b1a5-4471-9327-b48272c3a5fe.png" width=700 /></p>

- 대중교통 정보 플랫폼(ODsay): https://lab.odsay.com/
- 카카오페이: https://developers.kakao.com/docs/latest/ko/kakaopay/common
- google_map_place: https://developers.google.com/maps/documentation/places/web-service/overview?hl=ko

## 👥 역할 분담
#### Server & Database
- 손지민: 설계, 도메인 생성, 예약 생성 • 취소 기능
- 정연준: 설계, FCM 알림 기능, 버스 경로 조회 기능, 예약 정보 조회 기능
- 정영한: 데이터베이스 구축 및 관리, 문서 작성
  
#### Mobile
- 박준식: 설계, 카카오페이 결제 기능, FCM 알림 기능, 예약 기능
- 이지현: 설계, 로그인 기능, 데이터 크롤링, 서버 연동

## 📦 Dependencies
#### Server
```gradle
{
  dependencies {
	implementation 'org.springframework.boot:spring-boot-starter-data-jpa'
	implementation 'org.springframework.boot:spring-boot-starter-validation'
	implementation 'org.springframework.boot:spring-boot-starter-web'

	implementation 'com.github.gavlyukovskiy:p6spy-spring-boot-starter:1.8.1'

	compileOnly 'org.projectlombok:lombok'
	runtimeOnly 'com.h2database:h2'
	runtimeOnly 'com.mysql:mysql-connector-j'
	annotationProcessor 'org.projectlombok:lombok'
	testImplementation 'org.springframework.boot:spring-boot-starter-test'

	implementation "com.querydsl:querydsl-jpa"
	implementation "com.querydsl:querydsl-core"
	implementation "com.querydsl:querydsl-collections"
	annotationProcessor "com.querydsl:querydsl-apt:5.0.0:jpa"
	annotationProcessor "jakarta.annotation:jakarta.annotation-api"
	annotationProcessor "jakarta.persistence:jakarta.persistence-api"

	implementation group: 'org.json', name: 'json', version: '20210307'

	implementation 'com.google.firebase:firebase-admin:9.1.1'
	implementation group: 'com.squareup.okhttp3', name: 'okhttp', version: '4.2.2'
  }
}
```

#### Mobile
```yaml
{
  dependencies:
  flutter:
    sdk: flutter

  # date format 'ko'
  flutter_localizations:
    sdk: flutter

  cupertino_icons: ^1.0.2

  # firebase
  firebase_core: ^2.4.1
  firebase_auth: ^4.2.5

  # firebase Messaging
  firebase_messaging: ^14.2.1
  flutter_local_notifications: ^13.0.0

  # dotenv
  flutter_dotenv: ^5.0.2

  # REST API
  http: ^0.13.5

  # Validator
  validators: ^3.0.0
  provider: ^6.0.5

  # Date Format
  intl: ^0.17.0

  # Rating Bar
  flutter_rating_bar: ^4.0.1

  # secure_storage
  flutter_secure_storage: ^7.0.1

  # rounded_date_picker
  flutter_rounded_date_picker: ^3.0.2

  # google_map
  google_maps_flutter: ^2.2.1
  flutter_google_places: ^0.3.0
  google_maps_cluster_manager: ^3.0.0+1

  # dotted_border
  dotted_border: ^2.0.0+3
}
```

## ⚒️ 기술 스택

### 👩‍💻 개발언어
<span><img src="https://img.shields.io/badge/Java-007396?style=for-the-badge&logo=Java&logoColor=white"/></span>
<span><img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=Dart&logoColor=white"/></span>

### 👩‍💻 프레임워크
<span><img src="https://img.shields.io/badge/Spring-6DB33F?style=for-the-badge&logo=Spring&logoColor=white"/></span>
<span><img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=Flutter&logoColor=white"/></span>

### 📂 데이터베이스
<span><img src="https://img.shields.io/badge/MySql-00758F?style=for-the-badge&logo=MySql&logoColor=white"/></span>

### 💭 협업 및 버전관리
<span><img src="https://img.shields.io/badge/GitHub-000000?style=for-the-badge&logo=GitHub&logoColor=white"/></span>
<span><img src="https://img.shields.io/badge/Notion-000000?style=for-the-badge&logo=Notion&logoColor=white"/></span>




