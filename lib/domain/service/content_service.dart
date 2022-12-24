import 'dart:developer';

import 'package:get/get.dart';
import 'package:uppercut_fantube/data/repository/content/content_repository.dart';
import 'package:uppercut_fantube/domain/model/content/simple_content_info.dart';

class ContentService extends GetxService {
  // 전체 tv 컨텐츠 리스트
  final Rxn<List<SimpleContentInfo>> totalListOfTvContent = Rxn();

  Future<void> fetchTotalListOfTvContent() async {
    final responseResult = await ContentRepository.to.loadTotalTvContentList();
    responseResult.fold(
      onSuccess: (data) {
        totalListOfTvContent.value = data;
      },
      onFailure: (e) {
        log('[ContentService] - 전체 TV 컨텐츠 리스트 호출 실패');
      },
    );
  }

  static ContentService get to => Get.find();
}
