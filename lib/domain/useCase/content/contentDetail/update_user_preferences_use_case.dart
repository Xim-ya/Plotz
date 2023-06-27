import 'dart:developer';
import 'package:soon_sak/data/api/user/request/preferred_content_request.dart';
import 'package:soon_sak/data/repository/user/user_repository.dart';

class UpdateUserPreferencesUserCase {
  UpdateUserPreferencesUserCase({required UserRepository userRepository})
      : _userRepository = userRepository;

  final UserRepository _userRepository;

  void call({required List<String> genresName, required String channelId}) {
    Future.wait([
      updateGenrePreferences(genresName),
      updateChannelPreferences(channelId),
    ]);
  }

  Future<void> updateGenrePreferences(List<String> genresName) async {
    final List<PreferredRequestContent> req = genresName
        .map((e) => PreferredRequestContent.fromGenresName(name: e))
        .toList();
    final response = await _userRepository.updateUserGenrePreference(req);
    response.fold(onSuccess: (_) {
      print('유저 취향 장르 정보 업데이트 완료');
    }, onFailure: (e) {
      log('UpdateUserPreferencesUseCase -$e');
    });
  }

  Future<void> updateChannelPreferences(String channelId) async {
    final response =
        await _userRepository.updateUserChannelPreference(channelId);
    response.fold(
      onSuccess: (_) {
        print('유저 취향 채널 정보 업데이트 완료');
      },
      onFailure: (e) {
        log('UpdateUserPreferencesUseCase -$e');
      },
    );
  }
}
