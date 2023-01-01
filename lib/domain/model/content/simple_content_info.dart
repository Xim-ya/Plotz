class SimpleContentInfo {
  final int contentId;

  SimpleContentInfo({required this.contentId});

  factory SimpleContentInfo.fromJson(int json) {
    return SimpleContentInfo(contentId: json);
  }

// factory SimpleContentInfo.fromJson(Map<String, dynamic> json) {
//   return SimpleContentInfo(
//       contentId: json['contentId'], videoId: json['videoId']);
// }
}
