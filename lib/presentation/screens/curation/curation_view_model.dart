import 'dart:developer';
import 'package:soon_sak/domain/model/content/curation/in_progress_quration.dart';
import 'package:soon_sak/utilities/index.dart';

class CurationViewModel extends BaseViewModel {
  CurationViewModel(this._contentRepository);

  /* Variables */
  late final RandomImg randomContentImg;
  late final List<InProgressQurationItem> inProgressCurations = [];

  /* Domain Modules */
  final ContentRepository _contentRepository;

  /* Intent */
  // 진행중인 큐레이션 리스트 호출
  Future<void> fetchInProgressQurationList() async {
    final response = await _contentRepository.loadInProgressQurationList();
    response.fold(
      onSuccess: (data) {
        inProgressCurations.addAll(data);
        update();
      },
      onFailure: (e) {
        log('CurationViewModel : $e');
      },
    );
  }

  // 컨텐츠 등록 스크린으로 이동
  void routeToRegister({required ContentType contentType}) {
    Get.toNamed(AppRoutes.register, arguments: contentType);
  }

  String randomImgGenerator(ContentType contentType) {
    final List<String> imgPathList =
        contentType.isTv ? tvImgPathList : movieImgPathList;
    String randomImgPath = imgPathList.randomItem();
    return randomImgPath;
  }

  @override
  void onInit() {
    super.onInit();

    fetchInProgressQurationList();

    randomContentImg = RandomImg(
        tvImgPath: tvImgPathList.randomItem(),
        movieImgPath: movieImgPathList.randomItem());
  }
}

class RandomImg {
  final String tvImgPath;
  final String movieImgPath;

  RandomImg({required this.tvImgPath, required this.movieImgPath});
}
