import 'dart:developer';
import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2022.12.24
 *  ContentService 모듈에서는 전역으로 사용되는
 *  모든 [content] 데이터와 관련된 객체와 메소드를 관리함.
 * */

class ContentService extends GetxService {
  ContentService(this._contentRepository, this._staticContentRepository);

  /* Data Modules */
  final ContentRepository _contentRepository;
  final StaticContentRepository _staticContentRepository;

  /* Variables */

  // 전체 컨텐츠 id 정보 객체
  late final ContentIdInfoModel _contentTotalIdInfo;

  // 정적 컨텐츠 키 리스트
  late final StaticContentKeys _staticContentKeys;

  /* Intents */

  // 정적 컨텐츠 키 리스트 호출
  Future<void> fetchStaticContentKeys() async {
    final response = await _staticContentRepository.loadStaticContentKeys();
    response.fold(onSuccess: (data) {
      _staticContentKeys = data;
    }, onFailure: (e) {
      log('ContentService : $e');
    });
  }

  // 전체 컨텐츠 id 정보 호출
  Future<void> fetchTotalInfoList() async {
    final response = await _contentRepository.loadContentIdInfoList();
    response.fold(
      onSuccess: (data) {
        _contentTotalIdInfo = ContentIdInfoModel(data);
      },
      onFailure: (e) {
        log('ContentService : $e');
      },
    );
  }

  Future<void> prepare() async {
    await fetchTotalInfoList();
    await fetchStaticContentKeys();
  }

  ContentIdInfoModel? get contentIdInfo => _contentTotalIdInfo;

  StaticContentKeys? get staticContentKeys => _staticContentKeys;
  String get bannerKey => _staticContentKeys.bannerKey;
  String get topTenContentKey => _staticContentKeys.topTenContentKey;
  String get categoryContentKey => _staticContentKeys.categoryContentKey;

  static ContentService get to => Get.find();
}
