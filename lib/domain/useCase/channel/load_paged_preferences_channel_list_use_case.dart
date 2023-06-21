import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:soon_sak/data/api/channel/response/channel_response.dart';
import 'package:soon_sak/data/repository/channel/channel_respoitory.dart';

/** Created By Ximya - 2023.06.20
 *  온보딩 섹션에서 사용되는 UseCase [ChannelPreferencesScreen][ChannelPreferencesViewModel]
 *  유저에게 본인이 선호하는 채널에 대한 정보를 수집하기 위해 채널 리스트를 제공
 *  - 리스트는 'paged' 호출 방식이 적용되어 있으며
 *  - 상단에 보여지는 4개의 채널 정보는 고정 값임
 *  - 나머지는 데이테베이스에 랜덤으로 호출됨
 * */

class LoadPagedPreferenceChannelListUseCase {
  LoadPagedPreferenceChannelListUseCase(
      {required ChannelRepository channelRepository})
      : _channelRepository = channelRepository;

  /* State Variables */
  int pageSize = 10;
  DocumentSnapshot? lastChannelDocument;

  /* Variables */
  final List<String> topExposedIds = [
    'UCuK80YHBZyyKrr2B1oHrgrw',
    'UCRT4hxfWfXEP7Iiv3ovI'
  ];

  // 기본 상단 노출 채널 데이터
  final List<ChannelBasicResponse> topExposedChannels = [
    ChannelBasicResponse(
      name: '어퍼컷Tube',
      channelId: 'UCuK80YHBZyyKrr2B1oHrgrw',
      logoImgUrl:
          'https://yt3.googleusercontent.com/ytc/AL5GRJU2gWJ6id4Yr_xWJ1me6iy_5NjUyYjdy1YRX5SY0w=s900-c-k-c0x00ffffff-no-rj',
      subscribersCount: 859000,
      totalContentCount: 46,
    ),
    ChannelBasicResponse(
      name: '영읽남',
      channelId: 'UCRT4hxfWfXEP7Iiv3ovI-0A',
      logoImgUrl:
          'https://yt3.googleusercontent.com/rbdoz4WVvAsqv-OWVanKm6dit-1U1u-EDVa-7w07rqho6TRR8EUtboqC_rE4JmEnhQIl6SO49oI=s900-c-k-c0x00ffffff-no-rj',
      subscribersCount: 259000,
      totalContentCount: 20,
    ),
  ];

  /* Controllers */
  late final PagingController<int, ChannelBasicResponse> pagingController;

  /* Data Modules */
  final ChannelRepository _channelRepository;

  /* Intents */
  // 채널 리스트 호출(paged)
  Future<void> _fetchPage() async {
    final response =
        await _channelRepository.loadPagedChannels(lastChannelDocument);
    response.fold(onSuccess: (data) {
      if (data.channelList.length >= 10) {
        // 이미 불려진 데이터 제거 & shuffle
        data.channelList
            .removeWhere((e) => topExposedIds.contains(e.channelId));
        data.channelList.shuffle();
        lastChannelDocument = data.lastDocument;
        pagingController.appendPage(data.channelList, 0);
      } else {
        data.channelList
            .removeWhere((e) => topExposedIds.contains(e.channelId));
        data.channelList.shuffle();
        pagingController.appendLastPage(data.channelList);
      }
    }, onFailure: (e) {
      print(e.toString());
    });
  }

  // UseCase를 초기화 시키는 메소드
  void initUseCase() {
    pagingController =
        PagingController<int, ChannelBasicResponse>(firstPageKey: 0);
    topExposedChannels.shuffle();
    pagingController.appendPage(topExposedChannels, 0);
    pagingController.addPageRequestListener((_) {
      _fetchPage();
    });
  }
}
