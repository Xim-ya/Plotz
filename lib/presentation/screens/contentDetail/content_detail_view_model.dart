import 'dart:developer';
import 'dart:io';

import 'package:uppercut_fantube/domain/enum/content_type_enum.dart';
import 'package:uppercut_fantube/domain/model/content/content_main_info.dart';
import 'package:uppercut_fantube/domain/useCase/load_content_main_info_use_case.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class ContentDetailViewModel extends BaseViewModel {
  ContentDetailViewModel(this._loadContentMainInfo);

  /* [Variables] */

  /// Data Variables
  final Rxn<ContentMainInfo> _contentMainInfo = Rxn(); // 헤더 + 컨텐츠탭 데이터

  /* [UseCase] */
  final LoadContentMainInfoUseCase _loadContentMainInfo;

  /* [Intent ] */

  /// 컨텐츠 상단 핵심 정보
  Future<void> fetchContentMainInfo() async {
    const tempContentId = 'N16uIvWozVk';
    final responseResult = await _loadContentMainInfo.call(tempContentId);

    responseResult.fold(
      onSuccess: (data) {
        _contentMainInfo.value = data;
      },
      onFailure: (e) {
        log(e.toString());
      },
    );
  }


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    fetchContentMainInfo();
  }

  ContentMainInfo? get contentMainInfo => _contentMainInfo.value;
  bool get isContentMainInfoLoading => _contentMainInfo.value == null;
  bool get isSingleEpisodeContent => _contentMainInfo.value?.contentEpicType == ContentEpicType.single;
}
