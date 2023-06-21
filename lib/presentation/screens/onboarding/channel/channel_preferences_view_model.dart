import 'package:go_router/go_router.dart';
import 'package:soon_sak/data/api/channel/response/channel_response.dart';
import 'package:soon_sak/domain/useCase/channel/load_paged_preferences_channel_list_use_case.dart';
import 'package:soon_sak/utilities/index.dart';

class ChannelPreferencesViewModel extends BaseViewModel {
  ChannelPreferencesViewModel(
      {required LoadPagedPreferenceChannelListUseCase loadChannelsUseCase})
      : _loadChannelsUseCase = loadChannelsUseCase;

  /* State Variables */
  bool hideGradient = true; // 상단 Gradiet Box 노출 여부
  List<String> selectedChannelIds = []; // 선택된 채널 아이디 리스트
  int get countOfSelectedChannel => selectedChannelIds.length; // 선택된 콘텐츠 개수
  bool get isSufficient => selectedChannelIds.length >= 3; // 선택 조건 만족 여부

  /* UseCases */
  final LoadPagedPreferenceChannelListUseCase _loadChannelsUseCase;

  /* Controllers */
  late final ScrollController scrollController;

  PagingController<int, ChannelBasicResponse> get pagingController =>
      _loadChannelsUseCase.pagingController;

  /* Intent */

  /// 채널 리스트 아이템이 선택 되었을 때
  /// 토글 로직 적용
  void onChannelItemTapped(ChannelBasicResponse item) {
    final selectedId = item.channelId;
    if (selectedChannelIds.contains(selectedId)) {
      selectedChannelIds.remove(selectedId);
    } else {
      selectedChannelIds.add(selectedId);
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

  // 다음 버튼이 클릭 되었을 때
  void onNextBtnTapped() {
    if (isSufficient) {
      context.go(AppRoutes.onboarding3);
    } else {}
  }

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    scrollController.addListener(setGradientBoxVisibility);
    _loadChannelsUseCase.initUseCase();
  }
}
