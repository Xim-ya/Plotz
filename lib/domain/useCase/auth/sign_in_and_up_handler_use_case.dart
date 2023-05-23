import 'dart:developer';
import 'package:soon_sak/utilities/constants/basic_profile_img_list_constants.dart';
import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2022.02.15
 *  로그인과 회원가입을 진행하는 UseCase
 *  Google SignIn & AppnIn 으로 구성
 *  데이터 레이로부터 유저의 정보를 받아오고, 해당 UseCase 에서 Firebase Auth에 등록하는 구조
 *
 *  아래와 같은 기능을 포함하고 있음
 *
 *  1. 유저 데이터 호출 (google, apple)
 *  2. Firebase Auth 등록
 *  3. 기존에 등록된 유저인지 아닌지 확인
 *  4. 신규유저라면 서버의 유저 정보 저장
 * */

class SignInAndUpHandlerUseCase extends BaseUseCase<Sns, Result<void>> {
  SignInAndUpHandlerUseCase(
      {required AuthRepository authRepository,
      required UserService userService})
      : _authRepository = authRepository,
        _userService = userService;

  final AuthRepository _authRepository;
  final UserService _userService;

  @override
  Future<Result<void>> call(Sns request) async {
    switch (request) {
      case Sns.google:
        final response = await _authRepository.getGoogleUserInfo();
        return response.fold(
          onSuccess: (data) async {
            await signWithCredential(data, snsType: Sns.google);
            await signUp(data);
            return Result.success(null);
          },
          onFailure: (e) {
            final errorText = e.toString();
            if (errorText.contains(
              '600 seconds before or after the current time, null',
            )) {
              Get.snackbar('로그인 오류', '디바이스의 시간 설정을 확인 해주세요');
            }
            return Result.failure(e);
          },
        );

      case Sns.apple:
        final response = await _authRepository.getAppleUserInfo();
        return response.fold(
          onSuccess: (data) async {
            await signWithCredential(data, snsType: Sns.apple);
            await signUp(data);
            return Result.success(null);
          },
          onFailure: Result.failure,
        );
    }
  }

  /// 회원가입
  /// Firesotre에 유저 데이터 자장
  Future<void> signUp(UserModel userInfo) async {
    User? user = FirebaseAuth.instance.currentUser;
    final response = await _authRepository.isUserAlreadyRegistered(user!.uid);
    await response.fold(
      onSuccess: (isRegisteredUser) async {
        // 조건 : 이전에 등록에 유저가 아니라면
        if (!isRegisteredUser) {
          userInfo.id = user.uid; // uid 필드값 업데이트
          userInfo.photoUrl ??= basicProfileImgList
              .randomItem(); // 프로필 이미지가 없을 경우 랜덤 기본 프로필 이미지로 필드 값 업데이트
          await _authRepository.saveUserInfo(userInfo); // 서버에 유저 정보 저장
          await _userService.getUserInfo(); // service 레이어 유저 정보 업데이트
          await AppAnalytics.instance.logSignUp(
            signUpMethod:
                userInfo.provider?.originString ?? 'undefined_provider',
          ); // Analytics 설정
          return;
        }
      },
      onFailure: (e) {
        log('SocialSignInHandlerUseCase $e');
      },
    );
  }

  // Firebase Auth 등록
  Future<void> signWithCredential(
    UserModel user, {
    required Sns snsType,
  }) async {
    late final OAuthCredential credential;

    if (snsType == Sns.google) {
      credential = GoogleAuthProvider.credential(
        accessToken: user.token?.accessToken,
        idToken: user.token?.idToken,
      );
    } else {
      credential = OAuthProvider('apple.com').credential(
        idToken: user.token?.idToken,
        accessToken: user.token?.accessToken,
      );
    }

    await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
