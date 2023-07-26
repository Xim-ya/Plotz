import 'package:soon_sak/data/api/tmdb/response/newResponse/searched_content_response.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/utilities/extensions/determine_content_type.dart';
import 'package:soon_sak/utilities/index.dart';

class SearchedContentNew {
  final int contentId;
  final String title;
  final MediaType type;
  final String? releaseDate;
  final BehaviorSubject<RegistrationState> state;
  final String posterImgUrl;

  SearchedContentNew(
      {required this.contentId,
      required this.title,
      required this.type,
      required this.releaseDate,
      required this.state,
      required this.posterImgUrl});

  factory SearchedContentNew.fromResponse(
      SearchedContentItemResponse response) {
    final data = SearchedContentNew(
      contentId: response.id,
      title: response.title ?? response.name ?? '제목 없음',
      type: MediaType.fromString(response.mediaType),
      releaseDate: response.releaseDate ?? response.firstAirDate,
      posterImgUrl: response.posterPath,
      state: BehaviorSubject<RegistrationState>.seeded(
        RegistrationState.isLoading,
      ),
    );

    if (data.type.isMovie) {
      if (ContentService.to.contentIdInfo!.movieContentIdList
          .contains(response.id)) {
        data.state.add(RegistrationState.registered);
      } else {
        data.state.add(RegistrationState.unRegistered);
      }
    } else {
      if (ContentService.to.contentIdInfo!.tvContentIdList
          .contains(response.id)) {
        data.state.add(RegistrationState.registered);
      } else {
        data.state.add(RegistrationState.unRegistered);
      }
    }

    return data;
  }
}

// 등록 여부 필드 enum 값
enum RegistrationState {
  isLoading,
  registered,
  unRegistered,
}
