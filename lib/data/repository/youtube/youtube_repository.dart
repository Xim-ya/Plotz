import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/utilities/index.dart';

/* Created By Ximya - 2022.11.22
*  [YoutubeAPI] [YoutubeExplore] API 데이터를 호출을 관리하는 Repository
* */

abstract class YoutubeRepository {
  Future<Result<List<YoutubeContentComment>>> loadContentComments(
    String videoId,
  );

  Future<Result<YoutubeVideoContentInfo>> loadYoutubeVideoContentInfo(
    String videoId,
  );
}
