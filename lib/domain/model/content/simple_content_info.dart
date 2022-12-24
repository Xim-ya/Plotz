class SimpleContentInfo {
  final int contentId;
  final String videoId;

  SimpleContentInfo({required this.contentId, required this.videoId});

  factory SimpleContentInfo.fromJson(Map<String, dynamic> json) {
    return SimpleContentInfo(
        contentId: json['contentId'], videoId: json['videoId']);
  }
}
