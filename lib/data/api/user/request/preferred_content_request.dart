import 'package:soon_sak/domain/enum/content_genre_enum.dart';
import 'package:soon_sak/domain/model/content/onboarding/preference_content.dart';

class PreferredRequestContent {
  int count;
  final String genreName;
  final int genreId;

  PreferredRequestContent({
    required this.count,
    required this.genreName,
    required this.genreId,
  });

  factory PreferredRequestContent.fromRes(
          {required PreferredContent response, required ContentGenre genre}) =>
      PreferredRequestContent(
        count: 2,
        genreName: genre.name,
        genreId: genre.id,
      );

  factory PreferredRequestContent.fromGenresName({required String name}) {
    print("아지랑이 ${name}");
  return  PreferredRequestContent(
      count: 1,
      genreName: ContentGenre.getContentGenre(name).name,
      genreId: ContentGenre.getContentGenre(name).id,
    );
  }

}
