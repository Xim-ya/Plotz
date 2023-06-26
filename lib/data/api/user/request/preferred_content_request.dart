import 'package:soon_sak/domain/model/content/onboarding/preference_content.dart';

class PreferredRequestContent {
  int count;
  final String genreId;

  PreferredRequestContent({
    required this.count,
    required this.genreId,
  });

  factory PreferredRequestContent.fromRes(
          {required PreferredContent response, required String genre}) =>
      PreferredRequestContent(count: 2, genreId: genre);
}
