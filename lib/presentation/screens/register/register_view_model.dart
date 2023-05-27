import 'dart:developer';

import 'package:go_router/go_router.dart';
import 'package:rxdart/rxdart.dart';
import 'package:soon_sak/domain/useCase/register/request_content_registration_use_case.dart';
import 'package:soon_sak/domain/useCase/search/new_search_paged_content_use_case.dart';
import 'package:soon_sak/utilities/index.dart';

part 'controllerResource/search_content_view_model.part.dart'; // 컨텐츠 검색
part 'controllerResource/register_video_link_view_model.part.dart'; // 영상 링크 등록
part 'controllerResource/confirm_curation_view_model.part.dart'; // 등록 컨텐츠 확인

class RegisterViewModel extends NewBaseViewModel {
  RegisterViewModel({
    required UserService userService,
    required SearchValidateUrlUseCase searchValidateUrlUseCase,
    required RequestContentRegistrationUseCase
        requestContentRegistrationUseCase,
    required CurationViewModel curationViewModel,
    required MyPageViewModel myPageViewModel,
    required NewSearchedPagedContentUseCase newSearchedPagedContentUseCase,
    required ContentType contentType,
  })  : selectedContentType = contentType,
        _userService = userService,
        validateVideoUrlUseCase = searchValidateUrlUseCase,
        _requestContentRegistrationUseCase = requestContentRegistrationUseCase,
        _curationViewModel = curationViewModel,
        pagedSearchHandler = newSearchedPagedContentUseCase,
        _myPageViewModel = myPageViewModel;

  /* Data Modules */
  final UserService _userService;

  // 선택된 컨텐츠 정보
  Content? _selectedContent;

  /* ViewModel */
  final CurationViewModel _curationViewModel;
  final MyPageViewModel _myPageViewModel;

  /* State Variables */
  // 선택된 컨텐츠 타입
  final ContentType selectedContentType;

  // 비디오 Form close btn노출 여부
  bool showVideoFormCloseBtn = false;

  // 컨텐츠 Form close btn노출 여부
  bool showContentFormCloseBtn = false;

  // 등록 컨텐츠 진행 단계
  List<bool> selectedSteps = <bool>[true, false, false];

  // 현재 pageView Index
  int get currentPageViewIndex => pageViewController.page?.toInt() ?? 0;

  // 등록 진행중 컨텐츠 데이터
  Content? curationContent;

  /* Controllers */
  late PageController pageViewController;

  /* UseCases */
  // final SearchPagedContentUseCase _searchUseCase;
  final NewSearchedPagedContentUseCase pagedSearchHandler;
  final SearchValidateUrlUseCase validateVideoUrlUseCase;
  final RequestContentRegistrationUseCase _requestContentRegistrationUseCase;

  /* Intents */
  void testest() {
    notifyListeners();
  }

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
        notifyListeners();
        break;
      case 1:
        unawaited(setContentInfo());

        await pageViewController.animateToPage(
          2,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );

        togglePageIndicatorIndex(2);
        notifyListeners();
        break;
      case 2:
        notifyListeners();
      // unawaited(requestRegistration());
    }
  }

  // 뒤로가기 버튼 클릭 시
  /// pageView 현재 인덱스에 따라 동작을 다르게 함.
  void onBackBtnTapped() {
    switch (currentPageViewIndex) {
      case 0:
        context.pop();
        break;
      case 1:
        contentFormFocusNode.unfocus();
        togglePageIndicatorIndex(0);
        pageViewController.animateToPage(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
        notifyListeners();
        break;
      case 2:
        videoFormFocusNode.unfocus();
        togglePageIndicatorIndex(1);
        pageViewController.animateToPage(
          1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
        notifyListeners();
        break;
    }
  }

  // 입력된 컨텐츠 정보 저장
  Future<void> setContentInfo() async {
    final videoId = validateVideoUrlUseCase.selectedVideoId;
    final channelId = validateVideoUrlUseCase.selectedChannelId;
    final response = await YoutubeMetaData.yt.channels.get(channelId);

    curationContent = Content(
      id: _selectedContent!.id,
      type: _selectedContent!.type,
      videoId: videoId,
      youtubeVideo: YoutubeVideo(
        channelName: response.title,
        channelImg: response.logoUrl,
        subscriberCount: response.subscribersCount,
      ),
      detail: ContentDetail(
        title: _selectedContent?.detail?.title,
        posterImgUrl: _selectedContent?.detail?.posterImgUrl,
        releaseDate: _selectedContent?.detail?.releaseDate,
      ),
    );
  }


  Future<void> requestRegistration() async {
    if (curationContent == null) {
      //TODO
      // unawaited(AlertWidget.newToast('선택된 데이터가 없습니다. 다시 시도해주세요'));
    }

    final requestData = ContentRegistrationRequest.fromContentModelWithUserId(
      content: curationContent!,
      userId: _userService.userInfo.value.id!,
    );

    final response = await _requestContentRegistrationUseCase.call(requestData);
    await response.fold(
      onSuccess: (data) async {
        log('컨텐츠 등록 성공');
        context.pop();

        await showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            return AppDialog.dividedBtn(
              title: '큐레이션 요청 완료',
              subTitle: _selectedContent!.detail!.title,
              description: '검토 후 순삭 콘텐츠에 정식 등록됩니다',
              leftBtnContent: '큐레이션 내역',
              rightBtnContent: '확인',
              onRightBtnClicked: () {
                dialogContext.pop();
              },
              onLeftBtnClicked: () {  
                dialogContext
                    .push(AppRoutes.tabs + AppRoutes.curationHistory)
                    .whenComplete(dialogContext.pop);
              },
            );
          },
        );

        /// 다른 화면 데이터 갱신
        /// 1. 큐레이션 스크린 (진행 중 큐레이션 내역)
        /// 2. 마이페이지 스크린 (큐레이션 내역)
        await _curationViewModel.fetchInProgressCurationList();
        await _myPageViewModel.fetchUserCurationSummary();
      },
      onFailure: (e) {
        // TODO
        // AlertWidget.newToast(message: '콘텐츠 등록 요청에 실패했습니다. 다시 시도해주세요',);
        log('RegisterViewModel : $e');
      },
    );
  }

  // TextForm 'X' 버튼 토글 로직
  void toggleVideoCloseBtn() {
    final String term = validateVideoUrlUseCase.textEditingController.text;
    if (showVideoFormCloseBtn == false && term.isNotEmpty) {
      showVideoFormCloseBtn = true;
      notifyListeners();
    }
    if (showVideoFormCloseBtn == true && term.isEmpty) {
      showVideoFormCloseBtn = false;
      notifyListeners();
    }
  }

  void toggleContentCloseBtn() {
    final String term = pagedSearchHandler.textEditingController.text;
    if (showContentFormCloseBtn == false && term.isNotEmpty) {
      showContentFormCloseBtn = true;
      notifyListeners();
    }
    if (showContentFormCloseBtn == true && term.isEmpty) {
      showContentFormCloseBtn = false;
      notifyListeners();
    }
  }

  @override
  void onInit() {
    super.onInit();
    pagedSearchHandler.initUseCase(forcedContentType: selectedContentType);
    // TODO: 업데이트 listner 범위 최소화
    textEditingController.addListener(notifyListeners);
    videoFormController.addListener(toggleVideoCloseBtn);
    pageViewController = PageController();
  }
}
