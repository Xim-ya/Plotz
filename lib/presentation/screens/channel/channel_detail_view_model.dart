import 'package:soon_sak/domain/model/channel/channel_model.dart';
import 'package:soon_sak/domain/model/content/home/new_content_poster_shell.dart';
import 'package:soon_sak/domain/useCase/channel/load_paged_channel_contents_use_case.dart';
import 'package:soon_sak/utilities/index.dart';

class ChannelDetailViewModel extends NewBaseViewModel {
  ChannelDetailViewModel(
      {required ChannelModel argument,
      required LoadPagedChannelContentsUseCase loadChannelContentsUseCase})
      : channelInfo = argument,
        _loadChannelContentsUseCase = loadChannelContentsUseCase;

  // 이전 페이지에서 전달 받는 argument
  final ChannelModel channelInfo;

  /* State Variables */
  // 상단 gradient box enable 여부
  bool isScrolledOnPosition = false;
  final double standardOffset = 26;

  /* Controllers */
  PagingController<int, NewContentPosterShell> get pagingController =>
      _loadChannelContentsUseCase.pagingController;
  late final ScrollController scrollController;

  /* UseCase */
  final LoadPagedChannelContentsUseCase _loadChannelContentsUseCase;

  /* Intents */

  // 콘텐츠 상세 페이지로 이동
  void routeToContentDetail(NewContentPosterShell item) {
    final ContentArgumentFormat argument = ContentArgumentFormat(
      originId: item.originId,
      contentId: item.contentId,
      contentType: item.contentType,
      channelName: channelInfo.name,
      channelLogoImgUrl: channelInfo.logoImgUrl,
      videoTitle: item.videoTitle,
      posterImgUrl: item.posterImgUrl,
      subscribersCount: channelInfo.subscribersCount,
    );
    Get.toNamed(AppRoutes.contentDetail, arguments: argument);
  }

  // 스크롤 동작 관련 이벤트
  // 상단 gradient box enable 여부를 설정하기 위함.
  void _manageInteractionOnScroll() {
    if (scrollController.offset < standardOffset &&
        isScrolledOnPosition == false) return;
    if (scrollController.offset >= standardOffset &&
        isScrolledOnPosition == true) return;

    if (scrollController.offset >= standardOffset) {
      isScrolledOnPosition = true;
    } else {
      isScrolledOnPosition = false;
    }
    notifyListeners();
  }

  @override
  void onInit() {
    scrollController = ScrollController();
    _loadChannelContentsUseCase.initUseCase(channelId: channelInfo.channelId);
    scrollController.addListener(_manageInteractionOnScroll);
    // _channelApi.removeZeroContainedChannel();
  }

  Future<void> setChannelField() async {}

  @override
  void onDispose() {
    // ChannelDetailBinding().unRegisterDependencies();
  }
}
