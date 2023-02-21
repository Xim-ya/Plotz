import 'package:soon_sak/data/api/youtube/youtube_api.dart';
import 'package:soon_sak/data/dataSource/youtube/youtube_data_source.dart';
import 'package:soon_sak/utilities/index.dart';

class YoutubeDataSourceImpl implements YoutubeDataSource {
  YoutubeDataSourceImpl(this._api);

  final YoutubeApi _api;

  @override
  Future<CommentsList?> loadVideoComments(String videoId) =>
      _api.loadVideoComments(videoId);
}
