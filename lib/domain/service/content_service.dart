import 'dart:developer';

import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2022.12.24
 *  ContentService 모듈에서는 전역으로 사용되는
 *  모든 [content] 데이터와 관련된 객체와 메소드를 관리함.
 *
 *  관리하고 있는 리소스
 *  1. 정적 컨텐츠 키 리스트
 *  2. 모든 컨텐츠 id 값 (TODO : firebase 인덱싱 개념을 적용하면 배제할 필요 있음)
 * */

class ContentService {
  ContentService(
      {required ContentRepository contentRepository,
      required StaticContentRepository staticContentRepository})
      : _contentRepository = contentRepository,
        _staticContentRepository = staticContentRepository;

  /* Data Modules */
  final ContentRepository _contentRepository;
  final StaticContentRepository _staticContentRepository;

  /* Variables */

  // 전체 컨텐츠 id 정보 객체
  late final ContentIdInfoModel _contentTotalIdInfo;

  // 정적 컨텐츠 키 리스트
  StaticContentKeys? _staticContentKeys;

  /* Intents */
  // 정적 컨텐츠 키 리스트 호출
  Future<void> fetchStaticContentKeys() async {
    final response = await _staticContentRepository.loadStaticContentKeys();
    response.fold(
      onSuccess: (data) {
        _staticContentKeys = data;
        print("========== 전달 받은 키 ${data.newlyAddedContentKey}");
      },
      onFailure: (e) {
        log('ContentService : $e');
      },
    );
  }

  // 전체 컨텐츠 id 정보 호출
  Future<void> fetchTotalInfoList() async {
    final response = await _contentRepository.loadContentIds();
    response.fold(
      onSuccess: (data) {
        _contentTotalIdInfo = ContentIdInfoModel(data);
      },
      onFailure: (e) {
        log('ContentService : $e');
      },
    );
  }

  // Service 리소스 initialize 구문
  Future<void> prepare() async {
    await fetchTotalInfoList();
    await fetchStaticContentKeys();
  }

  ContentIdInfoModel? get contentIdInfo => _contentTotalIdInfo;

  StaticContentKeys? get staticContentKeys => _staticContentKeys;

  String? get bannerKey => _staticContentKeys?.bannerKey;

  String? get topTenContentKey => _staticContentKeys?.topTenContentKey;

  String? get newlyAddedContentKey => _staticContentKeys?.newlyAddedContentKey;

  String? get topPositionedCollectionKey =>
      _staticContentKeys?.topPositionedCollectionKey;

  String? returnCategoryContentKey(int currentPage) => currentPage == 1
      ? _staticContentKeys?.categoryContentKey1
      : _staticContentKeys?.categoryContentKey2;

  static ContentService get to => locator<ContentService>();
}
