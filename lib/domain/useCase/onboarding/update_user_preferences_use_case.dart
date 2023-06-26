import 'package:soon_sak/data/api/channel/response/channel_response.dart';
import 'package:soon_sak/data/api/user/request/preferred_content_request.dart';
import 'package:soon_sak/data/api/user/request/user_onboarding_preferred_request.dart';
import 'package:soon_sak/domain/model/content/onboarding/preference_content.dart';
import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2023.06.25
 * 온보딩 단계에서 수집한 유저 선호 '채널' & '콘텐츠' 정보를 업데업이트하는 useCase
 * 해당 useCase에서는 2가지 유형의 정보를 가공 및 업데이트 함
 *
 * 1. 콘텐츠: type / genres - count(f)
 * user > userId > favoriteGenre > genreId 데이터베이스에 저장이 됨
 * 온보딩 단계에서 선택한 유저의 취향 장르 값에 더 중점을 주기 위해 각 값이 2번 곱해져 업데이트 됨
 *
 * 2. 채널 : channel Id -  count(f)
 * 마찬가지로 온보딩 단계에서 유저 선택한 채널에 더 강한 값을 부여하기 위해 값이 2번 곱해져 업데이트 됨
 *
 *
 * */

class UpdateUserPreferencesUseCase {
  UpdateUserPreferencesUseCase(
      {required List<PreferredContent> selectedContents,
      required UserRepository userRepository,
      required UserService userService})
      : _selectedContents = selectedContents,
        _userRepository = userRepository,
        _userService = userService;

  late final List<PreferredContent> _selectedContents;
  final UserRepository _userRepository;
  final UserService _userService;
  final List<PreferredRequestContent> _contentReq = [];

  /// 콘텐츠 request 데이터 생성
  /// 1. 콘텐츠 타입 분류
  /// 2. 콘텐츠 타입에 따른 장르 분류
  /// 3. 콘텐츠 타입에 따른 장르 누적 개수 확인
  void createContentReq() {
    for (var content in _selectedContents) {
      var isUpdated = false;
      for (var i = 0; i < _contentReq.length; i++) {
        if (content.genres.contains(_contentReq[i].genreId)) {
          _contentReq[i].count++;
          _contentReq[i].count++;
          isUpdated = true;
          break;
        }
      }
      if (!isUpdated) {
        _contentReq.add(
          PreferredRequestContent.fromRes(
            response: content,
            genre: content.genres[0],
          ),
        );
      }
    }
  }

  // 유저 선호 콘텐츠 및 채널 업데이트
  Future<void> updateUserPreferences(
      List<ChannelBasicResponse> selectedChannels) async {
    final UserOnboardingPreferredRequest req = UserOnboardingPreferredRequest(
      contents: _contentReq,
      channels: selectedChannels,
    );

    final response = await _userRepository.updateUserPreferences(req);
    response.fold(onSuccess: (data) {
      print('업데이트 성공!');
    }, onFailure: (e) {
      print('업데이트 실패!');
    });
  }
}
