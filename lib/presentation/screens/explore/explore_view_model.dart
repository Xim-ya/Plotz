import 'package:uppercut_fantube/domain/useCase/content/explore/load_explore_content_by_slider_index_use_case.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class ExploreViewModel extends BaseViewModel {
  /* Variables */

  // Data Variables;
  final Rxn<List<ExploreContent>> exploreContentList = Rxn();

  // State Variables;
  final RxInt swiperIndex = 0.obs;
  final RxInt maximumIndexOfScanned = 0.obs;

  ExploreViewModel(this._loadExploreContentBySlierIndex);

  /* UseCase */
  final LoadExploreContentBySlierIndexUseCase _loadExploreContentBySlierIndex;

  /* Intent */
  Future<void> fetchExploreContent() async {
    final responseResult = await _loadExploreContentBySlierIndex.call(0);
    responseResult.fold(onSuccess: (data) {
      exploreContentList.value = data;
    }, onFailure: (e) {
      AlertWidget.toast('탐색 컨텐츠를 불러오는 데 실패했습니다');
    });
  }

  Future<void> scannedAndUpdateContentInfo() async {
    // 첫 번째 (첫 번째 호출)
    if (swiperIndex.value == 0) {
      print('첫 번째 호출 ${swiperIndex.value}');
      maximumIndexOfScanned(2);
      for (var e in exploreContentList.value!.getRange(0, 3)) {
        if (e.isUpdated.isFalse) {
          await Future.wait([
            e.updateContentDetailInfo(),
            e.updateYoutubeChannelInfo(),
          ]).then((value) {
            e.isUpdated(true);
          });
        }
      }
    }
    // 호출 섹션
    else if (maximumIndexOfScanned.value - 1 == swiperIndex.value) {
      if (maximumIndexOfScanned.value + 2 >= exploreContentList.value!.length) {
        print('마지막 호출 호출 ${swiperIndex.value}');
        maximumIndexOfScanned(exploreContentList.value!.length);
        for (var e in exploreContentList.value!
            .getRange(swiperIndex.value, exploreContentList.value!.length)) {
          if (e.isUpdated.isFalse) {
            await Future.wait([
              e.updateContentDetailInfo(),
              e.updateYoutubeChannelInfo(),
            ]).then((value) {
              e.isUpdated(true);
            });
          }
        }
      } else {
        /* 0 1 '2' 3 4 '5'  6 */
        print(
            '중간 호출 ${swiperIndex.value} swiperIndex ${swiperIndex.value} maximumu${maximumIndexOfScanned}');
        maximumIndexOfScanned(swiperIndex.value + 4);
        // 미리 컨텐츠 호출
        for (var e in exploreContentList.value!
            .getRange(swiperIndex.value + 2, swiperIndex.value + 4)) {
          if (e.isUpdated.isFalse) {
            await Future.wait([
              e.updateContentDetailInfo(),
              e.updateYoutubeChannelInfo(),
            ]).then((value) {
              e.isUpdated(true);
            });
          }
        }
      }
    } else {
      print('호출 안함');
    }

    // 첫번째 호출 - 0
    // 호출 안함 - 1
    // 미리 컨텐츠 호출 - 2
    // 호출 안함 - 3
    // 호출 안함 - 4
    // 마지막 호출 - 5
    // 호출 안함 - 5
    // 호출 안함 - 6
  }

  String? get headerTitle => '어퍼컷'.obs.value;

  String? get releaseDate => '2022-12-20'.obs.value;

  String? get channelImgUrl =>
      'https://yt3.googleusercontent.com/ytc/AMLnZu9tKXzVPuAGTdZ-jfWmuDYRcZwKZlOm6GWpduKnvg=s900-c-k-c0x00ffffff-no-rj'
          .obs
          .value;

  String? get channelName => '어퍼컷'.obs.value;

  int? get subscriberCount => 3234123.obs.value;

  @override
  void onInit() {
    super.onInit();
    fetchExploreContent().then((value) {
      scannedAndUpdateContentInfo();
    });
  }
}
