import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:soon_sak/utilities/index.dart';
import 'dart:io' show Platform, exit;

/** Created By Ximya - 2023.03.01
 *  버전 정보와 네트워크를 확인하는 UseCase
 *  앱 진입 단계에서 사용이됨
 *
 *  해당 UseCase에서 서버의 시스템 작동 여부 및 버전 정보와
 *  현재 앱의 버전 정보를 대조하여
 *  초기 진입시 필요한 조치를 할 수 있도록 함.
 *
 *  현재 앱 버전 정보는 [package_info_plus] 라이브러를 이용해서 불러들임
 * */

class CheckVersionAndNetworkUseCase extends BaseNoParamUseCase<Result<void>> {
  CheckVersionAndNetworkUseCase(this._repository, this._userService);

  final VersionRepository _repository;
  final UserService _userService;

  @override
  Future<Result<void>> call() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String platformPath = Platform.isIOS ? 'ios' : 'android';

    final response = await _repository.loadVersionInfo(platformPath);
    return response.fold(
      onSuccess: (version) {
        final serverVersionCode = Version.parse(version.versionCode);
        final appVersionCode = Version.parse(packageInfo.version);

        // 서비스 모듈 버전 정보 저장
        _userService.currentVersionNum = version.versionCode;

        /// 조건 : 시스템 점건 중이거나 작동을 할 수 있는 상태라면
        /// 시스템 점검 모달 노출
        if (version.systemAvailable == 'N') {
          showSystemIsNotAvailableModal();
          return Result.failure(Exception('시스템 점검 중'));
        }

        /// 조건: 서버 버전이 현재 앱 버전보다 높다면
        /// 앱 업데이트 모달 노출
        if (serverVersionCode > appVersionCode) {
          showNeedUpdateModal();
          return Result.failure(Exception('업데이트 필요'));
        }

        return Result.success(null);
      },
      onFailure: (e) {
        /// 조건 : 네트워크가 연결이 안되어 있다면
        /// 네트워크 불안정 모달 노출
        if (!(connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.wifi)) {
          showNetworkIsBadModal();
          return Result.failure(Exception('네트워크 불안정'));
        }

        /// 알 수 없는 오류라면
        somethingIsWrongModal();
        log('CheckVersionInfoUseCase : $e');
        return Result.failure(Exception('알 수 없는 오류'));
      },
    );
  }

  /* 모달 노출 메소드 */

  void showSystemIsNotAvailableModal() {
    Get.dialog(AppDialog.singleBtn(
      onBtnClicked: () async {
        Get.back();
        exit(9);
      },
      title: '시스템 점검 안내',
      description: '시스템 점검으로 서비스 이용이 제한됩니다',
    ));
  }

  void somethingIsWrongModal() {
    Get.dialog(AppDialog.singleBtn(
      onBtnClicked: () async {
        Get.back();
        exit(0);
      },
      title: '오류',
      description: '알 수 없는 오류가 발생했습니다',
    ));
  }

  void showNetworkIsBadModal() {
    Get.dialog(AppDialog.singleBtn(
      onBtnClicked: () {
        Get.back();
        exit(0);
      },
      title: '네트워크 불안정',
      description: 'Wi-Fi 또는 데이터를 활성화 해주세요.',
    ));
  }

  void showNeedUpdateModal() {
    Get.dialog(AppDialog.singleBtn(
      onBtnClicked: () async {
        Get.back();
        if (Platform.isIOS) {
          await launchUrl(
            Uri.parse(
                'https://apps.apple.com/kr/app/%EC%88%9C%EC%82%AD/id1671820197'),
            mode: LaunchMode.externalApplication,
          );
        } else if (Platform.isAndroid) {
          // TODO : 앱 코드 변경 필요[ANDROID]
          await launchUrl(
            Uri.parse('https://play.google.com/store'),
            mode: LaunchMode.externalApplication,
          );
        }
      },
      title: '업데이트 안내',
      description: '앱의 최신 버전이 출시되었습니다.\n최신 기능을 이용하기 위해 업데이트를 진행해주세요',
    ));
  }
}
