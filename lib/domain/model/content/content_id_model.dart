import 'dart:developer';

import 'package:uppercut_fantube/utilities/index.dart';

class ContentIdInfoModel {
  late final List<ContentIdInfoItem> totalIdInfoList;

  // 컨텐츠 아이디 리스트
  List<int> get contentIdList => totalIdInfoList.map((e) => e.id).toList();

  // Movie 컨텐츠 id 리스트
  List<int> get movieContentIdList =>
      totalIdInfoList.where((e) => e.type.isMovie).map((e) => e.id).toList();

  // TV 컨텐츠 id 리스트
  List<int> get tvContentIdList =>
      totalIdInfoList.where((e) => e.type.isTv).map((e) => e.id).toList();

  // 컨텐츠 아이디 정보 리스트 호출
  Future<void> fetchContentIdList() async {
    final response = await ContentRepository.to.loadContentIdInfoList();
    response.fold(
      onSuccess: (data) {
        totalIdInfoList = data;
      },
      onFailure: (e) {
        log('ContentIdInfoModel : $e');
      },
    );
  }
}

class ContentIdInfoItem {
  final int id; // TMDMB 컨텐츠 id
  final ContentType type; // 컨텐츠 타입 (movie or tv)

  ContentIdInfoItem({required this.id, required this.type});

  factory ContentIdInfoItem.fromOriginId(String originId) => ContentIdInfoItem(
      id: SplittedIdAndType.fromOriginId(originId).id,
      type: SplittedIdAndType.fromOriginId(originId).type);
}
