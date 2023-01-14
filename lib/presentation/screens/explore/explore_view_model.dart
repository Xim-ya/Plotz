import 'package:uppercut_fantube/domain/useCase/content/explore/load_explore_content_by_slider_index_use_case.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class ExploreViewModel extends BaseViewModel {
  /* Variables */
  final Rxn<List<ExploreContent>> exploreContentList = Rxn();

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
    fetchExploreContent();
  }
}
