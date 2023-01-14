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
    // 이미 Scanned & Updated이 완료된 컨텐츠라면(뒤로 이동한 경우)
    if (swiperIndex.value < maximumIndexOfScanned.value) {
      print('AIM - 0');
      return;
    }

    // 첫 번째
    if (swiperIndex.value == 0) {
      print('AIM - 1');
      for (var e in exploreContentList.value!.getRange(0, 2)) {
        if (e.isUpdated.isFalse) {
          await Future.wait([
            e.updateContentDetailInfo(),
            e.updateYoutubeChannelInfo(),
          ]).then((value) {
            e.isUpdated(true);
            maximumIndexOfScanned(2);
          });
        }
      }
    } else if (maximumIndexOfScanned.value == swiperIndex.value) {
      // 미리 호출한 컨텐츠가 없다면
      if (maximumIndexOfScanned.value+ 2 >= exploreContentList.value!.length) {
        print('AIM - 2');
        for (var e in exploreContentList.value!
            .getRange(swiperIndex.value, exploreContentList.value!.length)) {
          if (e.isUpdated.isFalse) {
            await Future.wait([
              e.updateContentDetailInfo(),
              e.updateYoutubeChannelInfo(),
            ]).then((value) {
              e.isUpdated(true);
              maximumIndexOfScanned(exploreContentList.value!.length);
            });
          }
        }
      }
      // 미리 컨텐츠 호출
      else {
        print('AIM - 3');
        for (var e in exploreContentList.value!
            .getRange(swiperIndex.value + 1, swiperIndex.value + 2)) {
          if (e.isUpdated.isFalse) {
            await Future.wait([
              e.updateContentDetailInfo(),
              e.updateYoutubeChannelInfo(),
            ]).then((value) {
              e.isUpdated(true);
              maximumIndexOfScanned(swiperIndex.value + 2);
            });
          }
        }
      }
    }
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
