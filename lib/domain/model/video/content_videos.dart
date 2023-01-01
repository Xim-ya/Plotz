import 'package:uppercut_fantube/utilities/index.dart';

// class ContentVideoFormatParam {

class ContentVideos {
  final List<YoutubeVideo> videos;
  final ContentVideoFormat contentVideoFormat;
  RxBool isDetailInfoLoaded = false.obs;

  // Getters
  YoutubeVideo get singleTypeVideo => videos[0];
  List<YoutubeVideo> get multipleTypeVideos => videos;


  void updateLoadingState() {
    isDetailInfoLoaded(true);
  }

  ContentVideos({required this.videos, required this.contentVideoFormat});

  factory ContentVideos.fromDramaJson(List<Map<String, dynamic>> json) {
    return ContentVideos(
        videos: json.map((e) => YoutubeVideo.fromJson(e)).toList(),
        // 비디오 response 개수에 따라 타입이 결정됨.
        contentVideoFormat: json.length > 1
            ? ContentVideoFormat.multipleTv
            : ContentVideoFormat.singleTv);
  }

  factory ContentVideos.fromMovieJson(List<Map<String, dynamic>> json) {
    return ContentVideos(
        videos: json.map((e) => YoutubeVideo.fromJson(e)).toList(),
        // 비디오 response 개수에 따라 타입이 결정됨.
        contentVideoFormat: json.length > 1
            ? ContentVideoFormat.multipleMovie
            : ContentVideoFormat.singleMovie);
  }
}
