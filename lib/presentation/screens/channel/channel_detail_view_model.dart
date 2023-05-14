import 'package:soon_sak/domain/model/channel/channel_model.dart';
import 'package:soon_sak/domain/model/content/home/new_content_poster_shell.dart';
import 'package:soon_sak/domain/useCase/channel/load_paged_channel_contents_use_case.dart';
import 'package:soon_sak/presentation/base/new_base_view_model.dart';
import 'package:soon_sak/utilities/index.dart';

class ChannelDetailViewModel extends NewBaseViewModel {
  ChannelDetailViewModel(this._loadChannelContentsUseCase, {required argument})
      : channelInfo = argument;

  // 이전 페이지에서 전달 받는 argument
  final ChannelModel channelInfo;

  /* Data Variables */
  final List<NewContentPosterShell> contents = [];

  /* Controllers */
  late final ScrollController scrollController;

  PagingController<int, NewContentPosterShell> get pagingController =>
      _loadChannelContentsUseCase.pagingController;

  /* UseCase */
  final LoadPagedChannelContentsUseCase _loadChannelContentsUseCase;

  @override
  void onInit() {
    scrollController = ScrollController();
    _loadChannelContentsUseCase.initPaging(channelId: channelInfo.channelId);
    // _fetchChannelContents();
  }
}
