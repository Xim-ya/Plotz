

<br/>
<br/>
<h1>Plotz</h1>

<div style="display: flex; justify-content: space-evenly">
    <img style="width: 240px" src="https://github.com/Xim-ya/Plotz/assets/75591730/a10a9e22-6a6d-44af-9e55-7f94f297f4a2"/>
    <img style="width: 240px" src="https://github.com/Xim-ya/Plotz/assets/75591730/99e84ceb-faa8-4a40-a821-f8f7b10cf56a"/>
    <img style="width: 240px" src="https://github.com/Xim-ya/Plotz/assets/75591730/0c2e9d4f-6803-4f1b-8b55-19184c4b9457"/>
</div>


<br/>
<br/>


<div align="center">
<h3>다운로드 링크</h3>
<div style="display : flex; justify-content: center; flex-direction: row">
  <a href="https://apps.apple.com/kr/app/%EC%88%9C%EC%82%AD/id1671820197">
  	<img src="https://velog.velcdn.com/images/ximya_hf/post/f393f426-f940-4b9f-a0a3-6d8c3047467f/image.png" style="width : 50px"/>
  </a>
  <div style="width: 12px"></div>
    <a href="https://play.google.com/store/apps/details?id=com.soon_sak">
  	<img src="https://velog.velcdn.com/images/ximya_hf/post/a626c32d-2b7b-4d40-b1fb-03dc7792b111/image.png" style="width : 50px"/>
  </a>
</div>
</div>


## 요약

| Index      | Detail                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
|------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 프레임워크      | Flutter                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| 기여도        | 100%                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| 상태 관리      | GetX --> Provider, RxDart                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| 구   조      | Clean MVVM Architecture                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| 의존성  주입    | get_it                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| 라우팅        | go_router                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| 모델링        | Retrofit                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| 네트 워킹      | Dio                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| 로컬 데이터 베이스 | sembast, Hive                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| 데이터 베이스    | - FirebaseStore & RealtimeDatabase                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| 주요 특징      | - <a href="https://velog.io/@ximya_hf/flutterfirestoremixinmodule">Mixin 키워드 기반 FireStore, RealtimeDataBase  네트워크 통신 모듈 구현</a> <br/>- [로컬 데이터베이스 기반 캐싱 로직 구현. 불필요 API call 최소화 ](./lib/domain/service/local_storage_service.dart)  </br>- [isolate 활용 모듈을 만들어 UI 렌더링 퍼포먼스 최적화 작업 진행 ](./lib/data/mixin/firebase_isolate_helper_mixin.dart)<br/>- MVVM + Clean Architecture 도입. 각 레이어간 역할과 책임을 분리하여 유지보수와 테스트를 용이하게 함</br><a href="https://velog.io/@ximya_hf/listviewbuilder">- UI 렌더링 최적화 작업<a/> </br>- <a href="https://medium.com/@ximya/create-utility-classes-like-a-pro-focus-on-memory-structure-in-flutter-d2377a0d79b3">유틸리티 모듈, 메모리 최적화 고려</a><br/><a href="https://velog.io/@ximya_hf/how-write-clean-flutter-ui-code">- 협업과 유지 보수를 고려한 구조화된 UI 코드 작성</a></br>- [로컬 데이터베이스 기반 캐싱 로직 구현. 불필요 API call 최소화 ](./lib/presentation/common/dialog/app_dialog.dart) </br> - 어드민 페이지 개발 및 운영 </br> <a href="https://velog.io/@ximya_hf/basescreenonmvvm">- BaseScreen BaseViewModel모듈을 기반으로 ViewModel과 View를 명확하게 구분하고,  개발 생산성을 높임</a></br> - 당장 외부 개발자가 작업에 투입 되어도 차질 없게, 전체적인 코드의 가독성을 고려. </br> <a href="https://www.figma.com/file/rDIwovXfvUjlBw7z4wylIf/%EC%88%9C%EC%82%AD-%EC%84%9C%EB%B2%84-%EA%B3%B5%EC%9C%A0?node-id=0%3A1&t=7RAQoBU2Ehl8Qwv3-1">- NoSQL 데이터베이스 구조 설정.  확장성에 초점을 둠.</a> </br> - Flavor 설정. 개발 및 프로덕션 작업환경 분리</br> - [Factory 패턴 기반 커스텀 UI 위젯 모듈](./lib/presentation/common/dialog/app_dialog.dart)  </br> - Firebase Analytics,  Crashlytics 설정. </br> - [Result 모듈 기반 에러 핸들링](./lib/utilities/result.dart) </br> - [extension을 활용하여 ViewModel 리소스 다이어트](./lib/presentation/screens/contentDetail/controllerResources/content_detail_header_view_model.part.dart) | 



## Change Log
### 1.0.0

* 순삭 어플리케이션 배포

### 1.0.1

- 순삭 어드민 어플리케이션 내부 배포


### 1.0.2
- UI 모듈 고도화 (SkeletonBox, AppDialog, KeepAliveView)
- Firebase Analytics 로직 추가
- 기타 버그 수정.

### 1.0.3
- 개발환경 분리 (prod, dev)
- 유저 트래킹 로직 추가
- 홈 탭 내부 캐싱 로직 적용 + 페이징 로직 적용

### 1.0.4
- Isolate 로직을 도입 UI 프리징 이슈를 해결 (FirebaseIsolateHelper, IsolateHelper)
- 홈 섹션 코드 리팩토링


### 1.0.5
- **서비스 리뉴얼**  (순삭 to Plotz)
- 콘텐츠 상세 페이지 리뉴얼
- 상태관리 라이브러리 전환 (Getx to Provider)
- 라우팅 로직 변경 (Getx to go_router)
- DI 로직 변경 (Getx to get_it)
- 이미지 캐싱 관련 메모리 누수 문제 수정 


### 1.0.6
- 로그인 화면 리뉴얼 
- DI 로직 고도화 
  - route binding 로직 적용
  - safeRegister 로직 적용
- 기타 UX를 고려한 기능 추가
  

### 1.0.7
- 기타 버그 수정


### 1.0.8
- 온보딩 섹션 추가
- 유저 취향 정보 수집 로직 추가 
- 불필요 isolate 로직 제거



### 1.0.9
- 큐레이션 탭 및 관련 기능 제거


### 1.0.10
- 마이페이지 리뉴얼
- 설정 페이지 제거
- SingleImport 로직 적용


### 1.0.11 
- 코딩 컨벤션 수정 및 보완
- 검색 스크린 리뉴얼 
  - 카테고리 통합 movie, tv -> all
  - 탭 섹션으로 이동
- 이미지 캐시 할당 로직 고도화 (최소 할당 캐시 설정)
- 
### 1.0.12 ~ 1.0.13
- 기타 버그 수정
- 어드민 어플리케이션 기능 수정 및 고도화


[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2FXim-ya%2FSoonSack%2Fhit-counter&count_bg=%23E30914&title_bg=%23101010&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com)


