import 'package:uppercut_fantube/data/dataSource/content/content_data_source.dart';
import 'package:uppercut_fantube/domain/enum/content_type_enum.dart';
import 'package:uppercut_fantube/domain/enum/ott_type_enum.dart';
import 'package:uppercut_fantube/domain/model/content/content_main_info.dart';
import 'package:uppercut_fantube/domain/model/content/top_exposed_content_list.dart';
import 'package:uppercut_fantube/domain/model/content/youtube_content.dart';
import 'package:uppercut_fantube/domain/repository/content/content_repository.dart';
import 'package:uppercut_fantube/utilities/result.dart';
import 'package:uppercut_fantube/utilities/youtube_meta_data.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class ContentRepositoryImpl implements ContentRepository {
  ContentRepositoryImpl(this._contentDataSource);

  final ContentDataSource _contentDataSource;

  /* 유튜브 컨텐츠 댓글 리스트 호출 */
  @override
  Future<Result<CommentsList?>> loadContentCommentList(String videoId) async {
    try {
      // 유튜브 댓글
      final video = await YoutubeMetaData.yt.videos.get(videoId);
      final commentList =
          await YoutubeMetaData.yt.videos.commentsClient.getComments(video);
      return Result.success(commentList);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  /* 유튜브 컨텐츠 정보 (컨텐츠탭 + 헤더) */
  @override
  Future<Result<ContentMainInfo>> loadContentMainInfo() async {
    try {
      final ContentMainInfo response = ContentMainInfo(
        id: 'V2sdf20aQ',
        title: '올드맨',
        ottTypeList: [OttType.netflix],
        rate: 8.2,
        genreList: ['드라마', '액션'],
        releaseDate: '2022-10-15',
        contentEpicType: ContentSeasonType.single,
        contentDescription:
            '수십 년 전 잠적한 전직 CIA 요원 댄 체이스. 과거의 비밀을 안고 은둔한 채 살악던 중 결국 정체가 탄로 난다. 하지만 미래를 위해서 더 이상 숨어 살 수 없는 그는 과거의 매듭을 풀고자 하는데',
        youtubeContents: [
          YoutubeContent(
            likes: 990000,
            viewCount: 5293315,
            releaseDate: '2022-11-19',
            lastUpdateDate: '2022-11-22',
            videoId: 'TXMtLF5OANI',
          )
        ],
      );
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<TopExposedContent>>> loadTopExposedContent() async {
    try {
      final response = await _contentDataSource.loadTopExposedContentList();
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
