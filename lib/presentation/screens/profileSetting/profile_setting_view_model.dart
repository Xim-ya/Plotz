import 'dart:developer';

import 'package:image_picker/image_picker.dart';
import 'package:soon_sak/utilities/index.dart';

class ProfileSettingViewModel extends BaseViewModel {
  ProfileSettingViewModel(this._userService, this._userRepository);

  /* Data Modules */
  final UserService _userService;
  final UserRepository _userRepository;

  /* Controllers */
  late TextEditingController textEditingController;
  late ImagePicker _picker;

  /* Intents */

  // 이미지 선택
  void pickProfileImage() {
    _picker.pickImage(source: ImageSource.gallery);
  }

  // 프로필 정보 업데이트
  Future<void> updateUserProfile() async {
    final requestData = UserProfileRequest(
      photoImgUrl: _userService.userInfo.value!.photoUrl!,
      displayName: textEditingController.text,
      userId: _userService.userInfo.value!.id!,
    );
    final response = await _userRepository.updateUserProfile(requestData);
    response.fold(
      onSuccess: (data) {
        log('업데이트 성공');
        _userService.getUserInfo();
      },
      onFailure: (e) {
        log('ProfileSettingViewModel $e');
      },
    );
  }

  // 닉네임 중복 확인
  Future<void> checkDuplicateName() async {
    final response = await _userRepository
        .checkDuplicateDisplayName(textEditingController.text);
    response.fold(onSuccess: (isDuplicated) {
      if (isDuplicated) {
        print('중복된 이름');
      } else {
        print('유용한 이름');
      }
    }, onFailure: (e) {
      log('ProfileSettingViewModel : $e');
    });
  }

  /* Getters */
  UserModel get userInfo => _userService.userInfo.value!;

  @override
  void onInit() {
    super.onInit();
    textEditingController = TextEditingController();
    _picker = ImagePicker();
    textEditingController.text = userInfo.displayName!;
  }
}
