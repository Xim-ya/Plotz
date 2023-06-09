import 'dart:developer';
import 'package:soon_sak/data/api/channel/request/channe_contents_request.dart';
import 'package:soon_sak/data/repository/channel/channel_respoitory.dart';
import 'package:soon_sak/domain/model/channel/channel_content_list.dart';
import 'package:soon_sak/domain/model/content/home/content_poster_shell.dart';
import 'package:soon_sak/utilities/index.dart';

class LoadPagedChannelContentsUseCase {
  LoadPagedChannelContentsUseCase(this._channelRepository);

  /* Variables */
  DocumentSnapshot? lastPagedDocument;
  Timer? _debounce;
  static const int pageSize = 10;

  /* Controllers */
  late final PagingController<int, ContentPosterShell> pagingController =
      PagingController<int, ContentPosterShell>(firstPageKey: 0);

  /* Repository */
  final ChannelRepository _channelRepository;

  @override
  Future<ChannelContentList> call(ChannelContentsRequest request) {
    // TODO: implement call
    throw UnimplementedError();
  }

  Future<void> _fetchPage(String channelId) async {
    final response = await _channelRepository.loadPagedChannelContents(
      ChannelContentsRequest(
        channelId: channelId,
        lastDocument: lastPagedDocument,
      ),
    );
    response.fold(
      onSuccess: (data) {
        final bool isLastPage = data.contents.length < pageSize;
        if (isLastPage) {
          pagingController.appendLastPage(data.contents);
          pagingController.dispose();
        } else {
          final nextPageKey = pagingController.value.itemList?.length ??
              0 + data.contents.length;
          pagingController.appendPage(data.contents, nextPageKey);
          lastPagedDocument = data.lastDocument;
        }
      },
      onFailure: (e) {
        log('LoadPagedChannelCOntentsUseCase - $e');
      },
    );
  }

  void initUseCase({required String channelId}) {
    pagingController.addPageRequestListener((pageKey) {
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 50), () {
        _fetchPage(channelId);
      });
    });
  }
}
