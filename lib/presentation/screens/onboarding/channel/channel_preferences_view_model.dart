import 'package:go_router/go_router.dart';
import 'package:soon_sak/data/api/channel/response/channel_response.dart';
import 'package:soon_sak/domain/useCase/channel/load_paged_preferences_channel_list_use_case.dart';
import 'package:soon_sak/domain/useCase/onboarding/update_onboarding_preferences_use_case.dart';
import 'package:soon_sak/utilities/index.dart';

class ChannelPreferencesViewModel extends BaseViewModel {
  ChannelPreferencesViewModel({
    required LoadPagedPreferenceChannelListUseCase loadChannelsUseCase,
    required UpdateOnboardingPreferencesUseCase updateUserPreferencesUseCase,
  })  : _loadChannelsUseCase = loadChannelsUseCase,
        _updateUserPreferencesUseCase = updateUserPreferencesUseCase;

  /* State Variables */
  bool hideGradient = true; // 상단 Gradiet Box 노출 여부
  List<ChannelBasicResponse> selectedChannels = []; // 선택된 채널 아이디 리스트
  int get countOfSelectedChannel => selectedChannels.length; // 선택된 콘텐츠 개수
  bool get isSufficient => selectedChannels.isNotEmpty; // 선택 조건 만족 여부

  /* UseCases */
  final LoadPagedPreferenceChannelListUseCase _loadChannelsUseCase;
  final UpdateOnboardingPreferencesUseCase _updateUserPreferencesUseCase;

  /* Controllers */
  late final ScrollController scrollController;
  PagingController<int, ChannelBasicResponse> get pagingController =>
      _loadChannelsUseCase.pagingController;

  /* Intent */

  /// 채널 리스트 아이템이 선택 되었을 때
  /// 토글 로직 적용
  void onChannelItemTapped(ChannelBasicResponse channel) {
    if (selectedChannels.contains(channel)) {
      selectedChannels.remove(channel);
    } else {
      selectedChannels.add(channel);
    }
    notifyListeners();
  }

  // 상단 Graidet Box 노출 여부
  void setGradientBoxVisibility() {
    if (scrollController.offset >= 11 &&
        hideGradient == true &&
        scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
      hideGradient = false;
      notifyListeners();
      return;
    } else if (scrollController.offset >= 20) {
      return;
    } else {
      if (hideGradient == false &&
          scrollController.position.userScrollDirection ==
              ScrollDirection.forward) {
        hideGradient = true;
        notifyListeners();
      }
    }
  }

  // 건너뛰기 버튼이 클릭 되었을 때
  void onSkipBtnClicked() {
    showDialog(
      context: context,
      builder: (_) {
        return AppDialog.dividedBtn(
          title: '알림',
          description: '선택시 추천된 콘텐츠를 받아보실 수 있습니다.\n건너뛰시겠습니까?',
          leftBtnContent: '취소',
          rightBtnContent: '건너뛰기',
          onLeftBtnClicked: context.pop,
          onRightBtnClicked: skipSelection,
        );
      },
    );
  }

  // 채널 선택 skip
  void skipSelection(){
    _updateUserPreferencesUseCase.updateUserPreferences([]);
    context.go(AppRoutes.onboarding3);
  }


  // '다음' 버튼이 클릭 되었을 때
  void onNextBtnTapped() {
    if (isSufficient) {
      _updateUserPreferencesUseCase.updateUserPreferences(selectedChannels);
      context.go(AppRoutes.onboarding3);
    } else {
      showDialog(
        context: context,
        builder: (_) {
          return AppDialog.dividedBtn(
            title: '알림',
            description: '선택시 추천된 콘텐츠를 받아보실 수 있습니다.\n건너뛰시겠습니까?',
            leftBtnContent: '취소',
            rightBtnContent: '건너뛰기',
            onLeftBtnClicked: context.pop,
            onRightBtnClicked: skipSelection,
          );
        },
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    scrollController.addListener(setGradientBoxVisibility);
    _loadChannelsUseCase.initUseCase();
    _updateUserPreferencesUseCase.createContentReq();
  }
}
