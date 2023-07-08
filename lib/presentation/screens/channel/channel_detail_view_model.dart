import 'package:go_router/go_router.dart';
import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/presentation/index.dart';
import 'package:soon_sak/utilities/index.dart';

class ChannelDetailViewModel extends BaseViewModel {
  ChannelDetailViewModel(
      {required ChannelModel channelArg,
      required LoadPagedChannelContentsUseCase loadChannelContentsUseCase})
      : channelInfo = channelArg,
        _loadChannelContentsUseCase = loadChannelContentsUseCase;

  // 이전 페이지에서 전달 받는 argument
  final ChannelModel channelInfo;

  /* State Variables */
  // 상단 gradient box enable 여부
  bool isScrolledOnPosition = false;
  final double standardOffset = 26;

  /* Controllers */
  PagingController<int, ContentPosterShell> get pagingController =>
      _loadChannelContentsUseCase.pagingController;
  late final ScrollController scrollController;

  final binding = ContentDetailBinding();

  /* UseCase */
  final LoadPagedChannelContentsUseCase _loadChannelContentsUseCase;

  /* Intents */

  // 콘텐츠 상세 페이지로 이동
  void routeToContentDetail(ContentPosterShell item) {
    final arg = ContentArgumentFormat(
      originId: item.originId,
      contentId: item.contentId,
      contentType: item.contentType,
      channelName: channelInfo.name,
      channelLogoImgUrl: channelInfo.logoImgUrl,
      videoTitle: item.videoTitle,
      posterImgUrl: item.posterImgUrl,
      subscribersCount: channelInfo.subscribersCount,
    );

    safeUnregister<ContentDetailViewModel>();
    safeUnregister<LoadContentDetailInfoUseCase>();
    safeUnregister<LoadContentCreditInfoUseCase>();
    safeUnregister<LoadContentVideoInfoUseCase>();

    final prevLocation =
        GoRouter.of(context).routeInformationProvider.value.location;
    final currentLocation = GoRouter.of(context).location;
    binding.isDependenciesDeleted = true;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        if (currentLocation == prevLocation &&
            binding.isDependenciesDeleted == true) {
          binding.arg1 = arg;
          binding.arg2 = false;
          binding.dependencies();
        }

        return const ContentDetailScreen();
      }),
    );

    // context.push('/temp', extra: argument);
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
  }

  @override
  void onDispose() {
    super.onDispose();
    safeUnregister<ContentDetailViewModel>();
    safeUnregister<LoadContentDetailInfoUseCase>();
    safeUnregister<LoadContentCreditInfoUseCase>();
    safeUnregister<LoadContentImgListUseCase>();
  }
}
