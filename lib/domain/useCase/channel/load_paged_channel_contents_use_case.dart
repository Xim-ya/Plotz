import 'dart:developer';

import 'package:soon_sak/data/api/channel/request/channe_contents_request.dart';
import 'package:soon_sak/data/repository/channel/channel_respoitory.dart';
import 'package:soon_sak/domain/model/channel/channel_content_list.dart';
import 'package:soon_sak/domain/model/content/home/new_content_poster_shell.dart';
import 'package:soon_sak/utilities/index.dart';

class LoadPagedChannelContentsUseCase {
  LoadPagedChannelContentsUseCase(this._channelRepository);

  /* Variables */
  DocumentSnapshot? lastPagedDocument;
  Timer? _debounce;
  static const int pageSize = 10;

  /* Controllers */
  late final PagingController<int, NewContentPosterShell> pagingController =
      PagingController<int, NewContentPosterShell>(firstPageKey: 0);

  /* Repository */
  final ChannelRepository _channelRepository;

  @override
  Future<ChannelContentList> call(ChannelContentsRequest request) {
    // TODO: implement call
    throw UnimplementedError();
  }

  Future<void> _fetchPage(String channelId) async {
    final response = await _channelRepository.loadChannelContents(
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
          print("마지막 호출");
        } else {
          final nextPageKey = pagingController.value.itemList?.length ??
              0 + data.contents.length;
          pagingController.appendPage(data.contents, nextPageKey);
          lastPagedDocument = data.lastDocument;
          print("첫 번째 호출");
        }
      },
      onFailure: (e) {
        log('LoadPagedChannelCOntentsUseCase - $e');
      },
    );
  }

  void initPaging({required String channelId}) {
    pagingController.addPageRequestListener((pageKey) {
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 50), () {
        _fetchPage(channelId);
      });
    });
  }
}