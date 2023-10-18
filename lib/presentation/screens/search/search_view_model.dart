import 'dart:developer';

import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/domain/model/content/search/searched_content.m.dart';
import 'package:soon_sak/presentation/index.dart';
import 'package:soon_sak/utilities/index.dart';

/// TODO: PAGING 고도화 로직 필요
/// Tabview를  제스처로 이동할 때 UX가 부자연스러움.
/// PAGING Controller를 두 개로 분리 필요. (메모리를 너무 많이 사용하는지 사전에 확인 필요)
/// NOTE By Ximya - 2023.02.23
/// NOTE : Paging Controller를 두 개를 적용하면 setState Builder 오류 발생
/// 자세한 원인 파악 필요.

class SearchViewModel extends BaseViewModel {
  SearchViewModel({
    required SearchedPagedContentUseCase searchHandler,
    required ContentRepository contentRepository,
    required UserService userService,
  })  : pagedSearchHandler = searchHandler,
        _contentRepository = contentRepository,
        _userService = userService;

  /* Data Modules */
  final ContentRepository _contentRepository;
  final UserService _userService;

  /* UseCases */
  final SearchedPagedContentUseCase pagedSearchHandler;

  /* Variables (State) */
  BehaviorSubject<bool> get isInitialState => pagedSearchHandler.isInitialState;

  bool get showRoundCloseBtn => pagedSearchHandler.showRoundClosedBtn;

  /* Controllers */
  TextEditingController get textEditingController =>
      pagedSearchHandler.fieldController;

  PagingController<int, SearchedContentNew> get pagingController =>
      pagedSearchHandler.pagingController;

  FocusNode get focusNode => pagedSearchHandler.fieldNode;

  VoidCallback get onTextChanged => pagedSearchHandler.onSearchTermEntered;

  /* Intents */

  // 컨텐츠 요청
  Future<void> requestContent(SearchedContentNew content) async {
    final id = Formatter.getOriginIdByTypeAndId(
      type: content.type,
      id: content.contentId,
    );

    final stateResponse =
        await _contentRepository.checkIfContentAlreadyRequested(id);
    final isAlreadyRegistered = stateResponse.getOrThrow();

    if (isAlreadyRegistered) {
      AlertWidget.newToast(
          message: '이미 요청된 콘텐츠입니다.', context, isUsedOnTabScreen: true);
      return context.pop();
    }

    final ContentRequest request = ContentRequest(
      contentId: id,
      title: content.title,
      userId: _userService.userInfo.value.id!,
      releaseDate: content.releaseDate,
      posterImgUrl: content.posterImgUrl,
    );
    final response = await _contentRepository.createRequestContent(request);
    response.fold(
      onSuccess: (data) {
        context.pop();

        _userService.updateUserRequestedContents();
        AlertWidget.newToast(
            message: '요청이 완료되었어요. 검토 후 빠른 시일 내 등록을 완료할게요.',
            context,
            isUsedOnTabScreen: true);
        log('콘텐츠 요청 성공');
      },
      onFailure: (e) {
        context.pop();
        AlertWidget.newToast(
            message: '콘텐츠 요청에 실패했습니다. 다시 시도해주세요',
            context,
            isUsedOnTabScreen: true);
        log('SearchViewModel : $e');
      },
    );
  }

  /// 검색된 컨텐츠 클릭 되었을 때
  /// 컨텐츠 등록 여부에 따라 다른 동작(1,2,3)을 실행
  void onSearchedContentTapped({
    required SearchedContentNew content,
  }) {
    final registeredValue = content.state;

    // 1. isRegistered 데이터가 로그 안되었다면 toast 메세지를 띄움
    if (registeredValue.value == RegistrationState.isLoading) {
      AlertWidget.newToast(message: '잠시만 기다려주세요. 데이터를 로딩하고 있습니다', context);
      return;
    }

    // 2. 등록된 컨텐츠라면 상세 페이지로 이동
    if (registeredValue.value == RegistrationState.registered) {
      context.push(
        AppRoutes.contentDetail,
        extra: {
          'arg1': ContentArgumentFormat(
            contentId: content.contentId,
            contentType: content.type,
            posterImgUrl: content.posterImgUrl,
            originId: Formatter.getOriginIdByTypeAndId(
              type: content.type,
              id: content.contentId,
            ),
          ),
        },
      );
    } else {
      // 3. 등록된 컨텐츠가 아니라면 유저에게 '요청해주세요' 다이어로그를 띄움.
      showDialog(
        context: context,
        builder: (_) => AppDialog.dividedBtn(
          title: '미등록 콘텐츠',
          subTitle: content.title,
          description: '미등록 콘텐츠입니다.\n콘텐츠 업로드 요청을 해주세요!',
          leftBtnContent: '닫기',
          rightBtnContent: '요청하기',
          // TODO: 실제 요청 로직 추가 필요
          onRightBtnClicked: () {
            requestContent(content);
          },
          onLeftBtnClicked: context.pop,
        ),
      );
    }
  }

  // 검색어 초기화 - 'X' 버튼이 클릭 되었을 때
  VoidCallback get onClosedBtnTapped => pagedSearchHandler.onCloseBtnTapped;

  void prepare() {
    loadingState = ViewModelLoadingState.loading;

    // TODO: 업데이트 listner 범위 최소화
    textEditingController.addListener(notifyListeners);
    loadingState = ViewModelLoadingState.done;
  }

  // @override
  @override
  void onInit() {
    pagedSearchHandler.initUseCase();
  }
}
