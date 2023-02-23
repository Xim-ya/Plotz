import 'dart:async';
import 'dart:developer';

import 'package:soon_sak/domain/useCase/register/request_content_registration_use_case.dart';
import 'package:soon_sak/domain/useCase/search/new_search_paged_content_use_case.dart';
import 'package:soon_sak/utilities/index.dart';

part 'controllerResource/search_content_view_model.part.dart'; // 컨텐츠 검색
part 'controllerResource/register_video_link_view_model.part.dart'; // 영상 링크 등록
part 'controllerResource/confirm_curation_view_model.part.dart'; // 등록 컨텐츠 확인

class RegisterViewModel extends BaseViewModel {
  RegisterViewModel(
      this._userService,
      this.validateVideoUrlUseCase,
      this._requestContentRegistrationUseCase,
      this._curationViewModel,
      this._myPageViewModel,
      this.pagedSearchHandler,
      {required contentType})
      : selectedContentType = contentType;

  /* Data Modules */
  final UserService _userService;

  // 선택된 컨텐츠 정보
  final Rxn<Content> _selectedContent = Rxn();

  /* ViewModel */
  final CurationViewModel _curationViewModel;
  final MyPageViewModel _myPageViewModel;

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
  // final SearchPagedContentUseCase _searchUseCase;
  final NewSearchedPagedContentUseCase pagedSearchHandler;
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
      id: _selectedContent.value!.id,
      type: _selectedContent.value!.type,
      videoId: videoId,
      youtubeVideo: YoutubeVideo(
        channelName: response.title,
        channelImg: response.logoUrl,
        subscriberCount: response.subscribersCount,
      ),
      detail: ContentDetail(
        title: _selectedContent.value?.detail?.title,
        posterImgUrl: _selectedContent.value?.detail?.posterImgUrl,
        releaseDate: _selectedContent.value?.detail?.releaseDate,
      ),
    );
  }

  Future<void> requestRegistration() async {
    if (curationContent.value == null || _userService.userInfo == null) {
      unawaited(AlertWidget.newToast('선택된 데이터가 없습니다. 다시 시도해주세요'));
    }

    final requestData = ContentRequest.fromContentModelWithUserId(
        content: curationContent.value!, userId: _userService.userInfo!.id!);
    final response = await _requestContentRegistrationUseCase.call(requestData);
    await response.fold(
      onSuccess: (data) async {
        log('컨텐츠 등록 성공');
        Get.back();
        unawaited(
          Get.dialog(
            AppDialog.dividedBtn(
              title:
                  '[${_selectedContent.value!.detail!.title}]\n컨텐츠 등록이 완료되었어요',
              description: '검토 후 순삭 컨텐츠에 정식 등록됩니다',
              leftBtnContent: '큐레이션 내역',
              rightBtnContent: '확인',
              onRightBtnClicked: Get.back,
              onLeftBtnClicked: () {
                Get.toNamed(AppRoutes.curationHistory)!.whenComplete(Get.back);

              },
            ),
          ),
        );

        /// 다른 화면 데이터 갱신
        /// 1. 큐레이션 스크린 (진행 중 큐레이션 내역)
        /// 2. 마이페이지 스크린 (큐레이션 내역)
        await _curationViewModel.fetchInProgressQurationList();
        await _myPageViewModel.fetchUserCurationSummary();
      },
      onFailure: (e) {
        AlertWidget.toast('컨텐츠 등록 요청에 실패했습니다. 다시 시도해주세요');
        log('RegisterViewModel : $e');
      },
    );
  }

  @override
  void onInit() {
    super.onInit();

    pagedSearchHandler.initUseCase(forcedContentType: selectedContentType);

    pageViewController = PageController();
  }
}
