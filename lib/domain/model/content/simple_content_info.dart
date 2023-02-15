class SimpleContentInfo {
  final int contentId;

  SimpleContentInfo({required this.contentId});

  factory SimpleContentInfo.fromJson(int json) {
    return SimpleContentInfo(contentId: json);
  }
}
