import 'dart:developer';
import 'package:go_router/go_router.dart';
import 'package:soon_sak/utilities/index.dart';

class CurationViewModel extends NewBaseViewModel {
  CurationViewModel({required ContentRepository contentRepository})
      : _contentRepository = contentRepository;

  /* Variables */
  late final RandomImg randomContentImg;
  List<CurationContent> inProgressCurations = [];
  bool isInProgressCurationEmpty = false;

  /* Domain Modules */
  final ContentRepository _contentRepository;

  // 진행중인 큐레이션 리스트 호출
  Future<void> fetchInProgressCurationList() async {
    final response = await _contentRepository.loadInProgressQurationList();
    response.fold(
      onSuccess: (data) {
        if (data.isEmpty) {
          isInProgressCurationEmpty = true;
        } else {
          if (isInProgressCurationEmpty == true) {
            isInProgressCurationEmpty = false;
          }
          inProgressCurations.clear();
          inProgressCurations.addAll(data);
        }
        notifyListeners();
      },
      onFailure: (e) {
        log('CurationViewModel : $e');
      },
    );
  }

  // 컨텐츠 등록 스크린으로 이동
  void routeToRegister({required ContentType contentType}) {
    AppAnalytics.instance.logEvent(
      name: 'goToCurationProgress',
      parameters: {'type': contentType.name},
    );
    context.push(AppRoutes.tabs + AppRoutes.register, extra: contentType);
  }

  String randomImgGenerator(ContentType contentType) {
    final List<String> imgPathList =
        contentType.isTv ? tvImgPathList : movieImgPathList;
    String randomImgPath = imgPathList.randomItem();
    return randomImgPath;
  }

  /* Getters */
  int get curationListLength {
    return inProgressCurations.isNotEmpty
        ? inProgressCurations.length
        : 4; // 4 == 스켈레톤 뷰 개수
  }

  Future<void> prepare() async {
    loadingState = ViewModelLoadingState.loading;
    await fetchInProgressCurationList();
    loadingState = ViewModelLoadingState.done;
  }

  @override
  void onInit() {
    super.onInit();
    loading = true;
    randomContentImg = RandomImg(
      tvImgPath: tvImgPathList.randomItem(),
      movieImgPath: movieImgPathList.randomItem(),
    );
  }
}

class RandomImg {
  final String tvImgPath;
  final String movieImgPath;

  RandomImg({required this.tvImgPath, required this.movieImgPath});
}
