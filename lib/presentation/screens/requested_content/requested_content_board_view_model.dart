import 'package:flutter/material.dart';
import 'package:soon_sak/domain/enum/requested_content_status.dart';
import 'package:soon_sak/domain/model/content/myPage/requested_content.m.dart';
import 'package:soon_sak/domain/useCase/content/user/load_user_requested_contents_use_case.dart';
import 'package:soon_sak/presentation/index.dart';
import 'package:soon_sak/presentation/screens/requested_content/requseted_content_board_screen.dart';
import 'package:soon_sak/utilities/data_status.dart';

class RequestedContentBoardViewModel extends BaseViewModel {
  RequestedContentBoardViewModel(this._loadUserRequestedContentsUseCase);

  final LoadUserRequestedContentsUseCase _loadUserRequestedContentsUseCase;

  final List<Ds<List<RequestedContent>>> requestedContentCollection = [
    ...List.generate(3, (_) => Initial())
  ];

  Ds<List<RequestedContent>> getContentsByKey(int key) {
    return requestedContentCollection[key];
  }

  late final TabController tabController;

  int get currentTabPage => tabController.index;

  ///
  /// 유저의 요청 콘텐츠 리스트를 호출하는 메소드
  /// 호출 인자로 넘겨지는 status (신청, 완료, 보류)에 따라
  /// 호출하는 콘텐츠 status 종류가 달라지
  ///
  Future<void> _fetchRequestedContentsByStatus(int statusKey) async {
    final response = await _loadUserRequestedContentsUseCase.call(statusKey);
    response.fold(
      onSuccess: (data) {
        requestedContentCollection[statusKey] = Fetched(data);
      },
      onFailure: (e) {
        requestedContentCollection[statusKey] = Failed(e);

        AlertWidget.newToast(context,
            message:
                '${RequestedContentStatus.fromKeyValue(key: statusKey, pendingReason: null).text} 콘텐츠 목록을 불러오지 못하였습니다');
      },
    );

    notifyListeners();
  }

  ///
  /// 현재 바인딩되는 Screen[RequestedContentBoardScreen]이
  /// Stateful Widget으로 감싸져 있기 때문에 초기화 동작을 지정할 때
  /// 기존 [onInit] 오버라이드 사용하지 않음
  ///
  void onIntentInit(TabController controller) {
    tabController = controller;
    _fetchRequestedContentsByStatus(0);

    tabController.addListener(_fetchContentsIfNeeded);
  }

  ///
  /// [RequestedContentStatus] 타입에 해당되는
  /// 각각 콘텐츠들이 호출 되었는지 확인하고
  /// 호출되지 않았다면 콘텐츠를 호출.
  /// 모든 콘텐츠들이 호출되었다면 listener를 해제함
  ///
  void _fetchContentsIfNeeded() {
    if (requestedContentCollection[currentTabPage].cycle ==
        DataStatus.initial) {
      _fetchRequestedContentsByStatus(currentTabPage);
    }

    if (tabController.hasListeners &&
        requestedContentCollection
            .every((e) => e.cycle == DataStatus.fetched)) {
      tabController.removeListener(_fetchContentsIfNeeded);
    }
  }
}
