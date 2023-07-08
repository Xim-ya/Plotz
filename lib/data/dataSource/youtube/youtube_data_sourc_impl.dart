import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/utilities/index.dart';

class YoutubeDataSourceImpl
    implements YoutubeDataSource {
  YoutubeDataSourceImpl(this._api);

  final YoutubeApi _api;

  @override
  Future<CommentsList?> loadVideoComments(String videoId) =>
      _api.loadVideoComments(videoId);
}
