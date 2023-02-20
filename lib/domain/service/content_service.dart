import 'dart:developer';
import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2022.12.24
 *  ContentService 모듈에서는 전역으로 사용되는
 *  모든 [content] 데이터와 관련된 객체와 메소드를 관리함.
 * */

class ContentService extends GetxService {
  ContentService(this._contentRepository);

  // 등록된 전체 tv 컨텐츠 리스트
  final Rxn<List<SimpleContentInfo>> totalListOfRegisteredTvContent = Rxn();

  // 등록된 전체 movie 컨텐츠 리스트
  final Rxn<List<SimpleContentInfo>> totalListOfRegisteredMovieContent = Rxn();

  late final ContentIdInfoModel _contentIdInfo;

  ContentIdInfoModel? get contentIdInfo => _contentIdInfo;

  final ContentRepository _contentRepository;

  /* Intent */
  // 인자로 전달 받은 타입에 따라 등록된 전체 컨텐츠 리스트를 반환
  List<SimpleContentInfo>? returnTotalListBaseOnType(
      {required ContentType type}) {
    if (type.isTv) {
      return totalListOfRegisteredTvContent.value;
    } else {
      return totalListOfRegisteredMovieContent.value;
    }
  }




  Future<void> fetchTotalInfoList() async {
    final response = await _contentRepository.loadContentIdInfoList();
    response.fold(
      onSuccess: (data) {
        _contentIdInfo = ContentIdInfoModel(data);
      },
      onFailure: (e) {
        log('ContentService : $e');
      },
    );
  }


  Future<void> prepare() async {
    await fetchTotalInfoList();
  }

  static ContentService get to => Get.find();
}
