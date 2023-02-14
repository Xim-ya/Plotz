import 'dart:developer';

import 'package:soon_sak/utilities/index.dart';

class ContentIdInfoModel {
  ContentIdInfoModel(this.totalIdInfoList);
  final List<ContentIdInfoItem> totalIdInfoList;

  // 전체 원형(db) 아이디 리스트
  List<String> get originIdList =>
      totalIdInfoList.map((e) => e.originId).toList();

  // 컨텐츠 아이디 리스트
  List<int> get contentIdList => totalIdInfoList.map((e) => e.id).toList();

  // Movie 컨텐츠 id 리스트
  List<int> get movieContentIdList =>
      totalIdInfoList.where((e) => e.type.isMovie).map((e) => e.id).toList();

  // TV 컨텐츠 id 리스트
  List<int> get tvContentIdList =>
      totalIdInfoList.where((e) => e.type.isTv).map((e) => e.id).toList();

}

class ContentIdInfoItem {
  final String originId;
  final int id; // TMDMB 컨텐츠 id
  final ContentType type; // 컨텐츠 타입 (movie or tv)

  ContentIdInfoItem(
      {required this.originId, required this.id, required this.type});

  factory ContentIdInfoItem.fromOriginId(String originId) => ContentIdInfoItem(
      id: SplittedIdAndType.fromOriginId(originId).id,
      type: SplittedIdAndType.fromOriginId(originId).type,
      originId: originId);
}
