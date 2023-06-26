import 'dart:developer';

import 'package:go_router/go_router.dart';
import 'package:rxdart/rxdart.dart';
import 'package:soon_sak/utilities/index.dart';

class UserService {
  UserService(
      {required AuthRepository authRepository,
      required UserRepository userRepository})
      : _authRepository = authRepository,
        _userRepository = userRepository,
        userWatchHistory = BehaviorSubject<List<UserWatchHistoryItem>>(),
        userInfo = BehaviorSubject<UserModel>();

  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  late final String currentVersionNum; // 버전정보
  bool isUserSignIn = false; // 유저 로그인 여부
  bool isOnboardingProgressDone = true; // 온보딩 완료 여부
  final BehaviorSubject<UserModel> userInfo; // 유저 정보
  final BehaviorSubject<List<UserWatchHistoryItem>>
      userWatchHistory; // 유저 시청 기록

  /* Intents */
  // 유저 시청 기록 호출
  Future<void> updateUserWatchHistory() async {
    print("아투 아지랑이 ${userInfo.value.id}");
    final response =
        await _userRepository.loadUserWatchHistory(userInfo.value.id!);
    response.fold(
      onSuccess: (data) {
        userWatchHistory.add(data);
      },
      onFailure: (e) {
        log('UserService : $e');
      },
    );
  }

  // 유저 정보 호출
  Future<void> getUserInfo() async {
    print("아지랑이--");
    final response = await _authRepository.loadUserInfo();
    response.fold(
      onSuccess: (data) {
        userInfo.add(data);

        print("아지랑이 ${data.id}");
      },
      onFailure: (e) {
        print("아지랑이 실패");
        log('UserService : $e');
      },
    );
  }

  // 유저 접속일 최신화
  Future<void> updateUserLoginDate() async {
    final response = await _authRepository.updateLoginDate(userInfo.value.id!);
    response.fold(
      onSuccess: (_) {},
      onFailure: (e) {
        log('UserService - 유저 접속일 최신화 실패 $e');
      },
    );
  }

  /// 유저 로컬 정보 저장
  /// 업데이트가 필요할 때만 저장 로직 실행
  void saveUserLocalDataIfNeeded() {
    print('로컬 저장 시작');
    final userLocalData = _userRepository.getUserLocalData().getOrThrow();
    if (userLocalData?.userId != userInfo.value.id) {
      final response = _userRepository.saveUserLocalData(userInfo.value.id!);
      response.fold(
        onSuccess: (_) {
          print('로컬 저장 시작--');
        },
        onFailure: (e) {
          log('UserService - 유저 로컬 데이터 저장 실패');
        },
      );
    }
  }

  // 유저 온보딩 완료 여부
  Future<void> checkOnBoardingProgressState() async {
    // 로컬 정보 확인
    final response = _userRepository.isOnboardingProgressDone();
    bool localResult = response.getOrThrow();
    if (localResult == true) {
      isOnboardingProgressDone = true;
      print("==========1[PLOTZ BP]===========");
      return;
    } else {
      // 서버 정보 확인
      print("aim-- ${userInfo.value.id}");
      final response = await _userRepository
          .checkIfUserHasPreferencesData(userInfo.value.id!);
      response.fold(
        onSuccess: (data) {
          print("==========2[PLOTZ BP]===========${data}");
          isOnboardingProgressDone = data;
          if (data == true) {
            print("==========2-2[PLOTZ BP]===========");
            _userRepository.changeUserOnboardingState(userInfo.value.id!);
          }
        },
        onFailure: (e) {
          print("==========3[PLOTZ BP]===========");
          isOnboardingProgressDone = true;
          log('UserService - 유저 취향 데이터 존재 여부 확인 실패 == $e');
        },
      );
    }
  }

  // 유저 등록 여부 확인
  Future<void> checkUserSignInState() async {
    final response = await _authRepository.isUserSignedIn();
    response.fold(
      onSuccess: (data) {
        isUserSignIn = data;
      },
      onFailure: (e) {
        log('UserService : $e');
      },
    );
  }

  /// 네트워크 상태를 관찰하는 메소드
  /// 네트워크가 불안정할 시 snackBar message를 보여줌
  /// 맨 처음 로드시에는 무조건 [ConnectivityResult.none]을 반환하여
  /// [isReadyToActivate] boolean 값으로 snackbar message 노출 여부를 결정함
  void listenNetworkConnection(BuildContext context) {
    bool isReadyToActivate = false;
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (isReadyToActivate && result == ConnectivityResult.none) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Wi-Fi 또는 데이터를 활성화 해주세요.'),
            action: SnackBarAction(
              label: '확인',
              onPressed: () {},
            ),
          ),
        );
      } else {
        isReadyToActivate = true;
      }
    });
  }

  /// 리소스 initialize 메소드
  /// [SplashViewModel]에서 사용됨
  Future<void> prepare(BuildContext context) async {
    await checkUserSignInState();
    listenNetworkConnection(context);
  }

// 로그인 프로세스가 끝났을 떄
// 유저 접속일 최신화 + 유저 로컬 정보 저장(필요시)
// Future<void> updateAndSaveUserInfo() async {
//   await updateUserLoginDate();
//   saveUserLocalDataIfNeeded();
// }
}
