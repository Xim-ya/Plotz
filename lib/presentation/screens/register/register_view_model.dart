import 'dart:developer';

import 'package:soon_sak/domain/useCase/register/request_content_registration_use_case.dart';
import 'package:soon_sak/utilities/index.dart';

part 'controllerResource/search_content_view_model.part.dart'; // 컨텐츠 검색
part 'controllerResource/register_video_link_view_model.part.dart'; // 영상 링크 등록
part 'controllerResource/confirm_curation_view_model.part.dart'; // 등록 컨텐츠 확인

class RegisterViewModel extends BaseViewModel {
  RegisterViewModel(this._searchUseCase, this.validateVideoUrlUseCase,
      this._requestContentRegistrationUseCase,
      {required contentType})
      : selectedContentType = contentType;

  /* Variables */
  // 선택된 컨텐츠 타입
  final ContentType selectedContentType;

  // 등록 컨텐츠 진행 단계
  final RxList<bool> selectedSteps = <bool>[true, false, false].obs;

  // 현재 pageView Index
  int get currentPageViewIndex => pageViewController.page?.toInt() ?? 0;

  // 등록 진행중 컨텐츠 데이터
  Rxn<Content> curationContent = Rxn();

  /* Controllers */
  late PageController pageViewController;

  /* UseCases */
  final SearchPagedContentUseCase _searchUseCase;
  final SearchValidateUrlUseCase validateVideoUrlUseCase;
  final RequestContentRegistrationUseCase _requestContentRegistrationUseCase;

  /* Intents */
  // PageIndicator 토글 로직
  void togglePageIndicatorIndex(int pageIndex) {
    for (int i = 0; i < selectedSteps.length; i++) {
      if (i == pageIndex) {
        selectedSteps[i] = true;
      } else {
        selectedSteps[i] = false;
      }
    }
  }

  /// 하단 고정 버튼이 클릭 시
  /// pageView 현재 인덱스에 따라 동작을 다르게 함.
  Future<void> onFloatingStepBtnTapped() async {
    switch (currentPageViewIndex) {
      case 0:
        await pageViewController.animateToPage(
          1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
        togglePageIndicatorIndex(1);
        break;
      case 1:
        unawaited(setContentInfo());
        unawaited(
          pageViewController.animateToPage(
            2,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          ),
        );
        togglePageIndicatorIndex(2);
        break;
      case 2:
        unawaited(requestRegistration());
    }
  }

  // 뒤로가기 버튼 클릭 시
  /// pageView 현재 인덱스에 따라 동작을 다르게 함.
  void onBackBtnTapped() {
    switch (currentPageViewIndex) {
      case 0:
        Get.back();
        break;
      case 1:
        contentFormFocusNode.unfocus();
        togglePageIndicatorIndex(0);
        pageViewController.animateToPage(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
        break;
      case 2:
        videoFormFocusNode.unfocus();
        togglePageIndicatorIndex(1);
        pageViewController.animateToPage(
          1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
        break;
    }
  }

  // 입력된 컨텐츠 정보 저장
  Future<void> setContentInfo() async {
    final videoId = validateVideoUrlUseCase.selectedVideoId;
    final channelId = validateVideoUrlUseCase.selectedChannelId;
    final response = await YoutubeMetaData.yt.channels.get(channelId);

    curationContent.value = Content(
      id: selectedContentDetail!.id,
      type: selectedContentDetail?.type,
      videoId: videoId,
      youtubeVideo: YoutubeVideo(
        channelName: response.title,
        channelImg: response.logoUrl,
        subscriberCount: response.subscribersCount,
      ),
      detail: ContentDetail(
        title: selectedContentDetail?.detail?.title,
        posterImgUrl: selectedContentDetail?.detail?.posterImgUrl,
        releaseDate: selectedContentDetail?.detail?.releaseDate,
      ),
    );
  }

  Future<void> requestRegistration() async {
    final requestData = ContentRequest.fromContentModelWithUserId(
        content: curationContent.value!, userId: UserService.to.userInfo!.id!);
    final response = await _requestContentRegistrationUseCase.call(requestData);
    response.fold(
      onSuccess: (data) {
        log('컨텐츠 등록 성공');
        Get.back();
        AlertWidget.animatedToast(
          '등록 절차를 거친 뒤 컨텐츠가 등록됩니다',
          isUsedOnTabScreen: true,
        );
      },
      onFailure: (e) {
        log('RegisterViewModel : $e');
      },
    );
  }

  @override
  void onInit() {
    super.onInit();

    pagingController.addPageRequestListener((pageKey) {
      loadSearchedContentListByPaging();
    });

    pageViewController = PageController();
  }
}
