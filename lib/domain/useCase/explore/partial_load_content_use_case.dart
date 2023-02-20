// 임시 삭제 : 이후 고도화 

// import 'package:soon_sak/utilities/index.dart';
//
// /** Created By Ximya - 2022.01.20
//  *  [ExploreScreen] 에서 사용되는 UseCase
//  *  [ExploreContent] 데이터를 호출함
//  *
//  *  [ExploreContent] 객체는 아래와 같이 구성되어 있음.
//  *  1. idInfo (contentId, videoId, videoType)
//  *  2. youtubeInfo (컨텐츠 유튜브 정보)
//  *  3. detail (컨텐츠 상세 정보 - TMDB)
//  *
//  *  idInfo(1)  객체 리스트를 선 호출하고
//  *  해당 idInfoList의 contentId, videoId를 값으로 [youtubeInfo] [detailInfo] 필드값에 대응하는
//  *  응답값을 부분 호출을 진행함.
//  *  이때 [swiperIndex](슬라이드 인덱스)을 기준으로 부분적으로 호출을 진행.
//  *
//  *  - 부분 호출을 하는 이유 -
//  *  api call 횟수를 줄임과 동시에 load한 데이터를 빠르게 보여주기 위함.
//  *
//  *
//  *  TODO: Exception 처리 로직 필요 + Isolate 로직 추가
//  *  TODO: for loop Excution 로직 고도화 필요
//  * */
//
// class PartialLoadContentUseCase {
//   PartialLoadContentUseCase(this._repository);
//
//   final ContentRepository _repository;
//
//   RxInt tesInt = 0.obs;
//   RxInt maxScannedIndex = 0.obs; // 최대 스캔된 인덱스
//   RxList<ExploreContent> exploreContentList =
//       <ExploreContent>[].obs; // 탐색 컨텐츠 리스트
//   RxBool isCanceled = false.obs;
//
//   /* Intents */
//
//   Future<void> changeCanceledState() async {
//     isCanceled(false);
//   }
//
//   /// 리스트 부분 업데이트 로직
//   Future<void> updateExploreContentFields(int swiperIndex) async {
//     // 이미 모든 리스트가 업데이트 되었다면 : 호출 X
//     if (maxScannedIndex.value == exploreContentList.length - 1) {
//       return;
//     }
//
//     // 슬라디어의 인덱스가 0이라면 : 첫 번째 호출
//     if (swiperIndex == 0) {
//       maxScannedIndex(2);
//       await loopAndUpdateListOfRange(0, 3);
//       return;
//     }
//
//     // 슬라이더의 인덱스가 미리 호출해야되는 시점의 인덱스라면.
//     if (swiperIndex == maxScannedIndex.value - 1) {
//       // 선 호출 할 수 있는 배열 요소가 부족하다면 (3개를 먼저 호출할 수 없다면) : 마지막 호출
//       if (maxScannedIndex.value + 2 >= exploreContentList.length) {
//         maxScannedIndex(exploreContentList.length - 1);
//         await loopAndUpdateListOfRange(swiperIndex, exploreContentList.length);
//       } else {
//         // 선 호출 (3개) : 중간 호출
//         maxScannedIndex(swiperIndex + 4);
//         await loopAndUpdateListOfRange(swiperIndex + 2, swiperIndex + 4);
//       }
//     }
//   }
//
//   // 컨텐츠 [idInfo] 데이터 리스트 호출
//   Future<List<ExploreContent>> loadContentIdList() async {
//     final response = await _repository.loadBasicInfoOfExploreContentList();
//     final result = response.getOrThrow();
//     exploreContentList.value = result;
//     return result;
//   }
//
//   /// 특정 범위의 리스트의 필드 값 업데이트
//   Future<void> loopAndUpdateListOfRange(
//       int firstRangIndex, int lastRangeIndex) async {
//     try {
//       for (var e
//           in exploreContentList.getRange(firstRangIndex, lastRangeIndex)) {
//         if (isCanceled.isTrue) throw 'For loop Excuted ${tesInt.value} ${e.idInfo.contentId}';
//         if (e.isUpdated.isFalse) {
//           tesInt.value = tesInt.value + 1;
//           print(tesInt.value);
//           await Future.wait([
//             e.updateContentDetailInfo(), // 컨텐츠 상세 정보 업데이트
//             e.updateYoutubeChannelInfo(), // 유뷰트 상세 정보 업데이트
//           ]).then((value) {
//             e.isUpdated(true); // 객체 업데이트 상태변경
//           });
//         }
//       }
//     } catch (e) {
//       print('${e}');
//     }
//   }
// }
