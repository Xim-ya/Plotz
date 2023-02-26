import 'dart:developer';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:soon_sak/utilities/index.dart';

class ProfileSettingViewModel extends BaseViewModel {
  ProfileSettingViewModel(this._userService, this._userRepository);

  /* Variables */
  final Rxn<File> pickedImgFile = Rxn();

  /* Data Modules */
  final UserService _userService;
  final UserRepository _userRepository;

  /* Controllers */
  late TextEditingController textEditingController;
  late ImagePicker _picker;

  /* Intents */

  // 프로필 변경 정보 저장
  Future<void> saveProfileChanges() async {
    String? changedNickName;
    String? changedProfileImageUrl;

    // 이미지나 닉네임이 변경되었다면
    if (pickedImgFile.value.hasData || isNickNameChanged) {
      if (pickedImgFile.value.hasData) {
        changedProfileImageUrl =
            await storeImgFileAndReturnUrl(pickedImgFile.value!);
      }
      if (isNickNameChanged) {
        changedNickName = textEditingController.text;
      }

      final request = UserProfileRequest(
          photoImgUrl: changedProfileImageUrl,
          displayName: changedNickName,
          userId: _userService.userInfo.value!.id!);
      await updateUserProfile(request);
    } else {
      await AlertWidget.animatedToast('변경된 정보가 없어요');
    }
  }

  // 이미지 업로드 및 downloadImgUrl 값 리턴 (FireStore)
  Future<String?> storeImgFileAndReturnUrl(File file) async {
    final response = await _userRepository.uploadUserProfileImgAndReturnUrl(
        userId: _userService.userInfo.value!.id!, file: file);
    return await response.fold(
      onSuccess: (imageUrl) async {
        return imageUrl;
      },
      onFailure: (e) {
        log('ProfileSettingViewModel : $e');
        return null;
      },
    );
  }

  // 이미지 선택
  Future<void> pickProfileImage() async {
    try {
      final imageSource = await _picker.pickImage(source: ImageSource.gallery);
      if (imageSource.hasData) {
        pickedImgFile.value = File(imageSource!.path);
      }
    } catch (e) {
      log(e.toString());
      await AlertWidget.animatedToast('사진첩에서 정상적으로 이미지를 불러오지 못했어요. 다시 시도해주세요');
    }
  }

  // 프로필 정보 업데이트
  Future<void> updateUserProfile(UserProfileRequest requestInfo) async {
    final response = await _userRepository.updateUserProfile(requestInfo);
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
    response.fold(
      onSuccess: (isDuplicated) {
        if (isDuplicated) {
          print('중복된 이름');
        } else {
          print('유용한 이름');
        }
      },
      onFailure: (e) {
        log('ProfileSettingViewModel : $e');
      },
    );
  }

  /* Getters */
  UserModel get userInfo => _userService.userInfo.value!;

  String get photoUrl => _userService.userInfo.value!.photoUrl!;

  bool get isNickNameChanged =>
      textEditingController.text != _userService.userInfo.value!.displayName;

  @override
  void onInit() {
    super.onInit();
    textEditingController = TextEditingController();
    _picker = ImagePicker();
    textEditingController.text = userInfo.displayName!;
  }
}
