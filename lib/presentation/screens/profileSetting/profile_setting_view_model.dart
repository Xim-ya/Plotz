import 'dart:developer';
import 'dart:io';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soon_sak/utilities/constants/regex.dart';
import 'package:soon_sak/utilities/index.dart';

class ProfileSettingViewModel extends BaseViewModel {
  ProfileSettingViewModel(
      {required UserService userService,
      required UserRepository userRepository})
      : _userRepository = userRepository,
        _userService = userService;

  /* Variables */
  File? pickedImgFile;

  /* Data Modules */
  final UserService _userService;
  final UserRepository _userRepository;

  /* Controllers */
  late TextEditingController textEditingController;
  late GlobalKey<FormState> formKey;
  late FocusNode focusNode;
  late ImagePicker _picker;

  /* Intents */
  // 닉네임 유효성 검사 로직
  String? nickNameValidation(String? value) {
    if (value == null || value == '') {
      return '닉네임을 입력해주세요';
    } else if (Regex.hasSpaceOnString(value)) {
      return '닉네임에는 공백을 사용할 수 없습니다';
    } else if (value.trim().length < 2 || value.trim().length > 10) {
      return '닉네임은 2에서 10글자 사이여야 합니다';
    } else if (Regex.hasProperCharacter(value)) {
      return '닉네임에는 한글, 알파벳, 숫자, 언더스코어(_), 하이픈(-)만 사용할 수 있습니다';
    } else if (Regex.hasContainFWord(value)) {
      return '비속어, 욕설 단어는 사용할 수 없습니다';
    } else if (Regex.hasContainOperationWord(value)) {
      return '사용할 수 없는 닉네임 입니다';
    } else {
      return null;
    }
  }

  // 프로필 변경 정보 저장
  Future<void> saveProfileChanges() async {
    focusNode.unfocus();
    if (loading == true) {
      return;
    }

    loading = true;
    String? changedNickName;
    String? changedProfileImageUrl;

    // 입력된 닉네임이 유효하지 않다면
    if (!formKey.currentState!.validate()) {
      await AlertWidget.newToast(message: '유효한 닉네임이 아닙니다', context);
      loading = false;
      return;
    }

    // 이미지나 닉네임이 변경되었다면
    if (pickedImgFile.hasData || isNickNameChanged) {
      await EasyLoading.show(status: '잠시만 기다려주세요');
      if (pickedImgFile.hasData) {
        changedProfileImageUrl = await storeImgFileAndReturnUrl(pickedImgFile!);
      }
      if (isNickNameChanged) {
        final isDuplicatedNickName =
            await checkDuplicateName(textEditingController.text);
        if (isDuplicatedNickName) {
          await AlertWidget.newToast(message: '중복된 닉네임 입니다', context);
          loading = false;
          return;
        }
        changedNickName = textEditingController.text;
      }

      final request = UserProfileRequest(
        photoImgUrl: changedProfileImageUrl,
        displayName: changedNickName,
        userId: _userService.userInfo.value.id!,
      );
      await updateUserProfile(request);
    } else {
      await AlertWidget.newToast(message: '변경된 정보가 없어요', context);
      loading = false;
    }
  }

  void routeBack() {
    if (loading == true) return;
    context.pop();
  }

  // 이미지 업로드 및 downloadImgUrl 값 리턴 (FireStore)
  Future<String?> storeImgFileAndReturnUrl(File file) async {
    final response = await _userRepository.uploadUserProfileImgAndReturnUrl(
      file: file,
    );
    return await response.fold(
      onSuccess: (imageUrl) async {
        return imageUrl;
      },
      onFailure: (e) {
        log('ProfileSettingViewModel : $e');
        EasyLoading.showError('프로필 정보를 업데이트하지 못했습니다');
        return null;
      },
    );
  }

  Future<void> onProfileUpdateSuccess() async {
    unawaited(EasyLoading.showSuccess('프로필 정보를 업데이트 했습니다'));
    loading = false;
    context.pop();
  }

  // 이미지 선택
  Future<void> pickProfileImage() async {
    focusNode.unfocus();
    try {
      await EasyLoading.show();
      final imageSource = await _picker.pickImage(source: ImageSource.gallery);
      if (imageSource.hasData) {
        pickedImgFile = File(imageSource!.path);
        notifyListeners();
      }
      unawaited(EasyLoading.dismiss());
    } catch (e) {
      unawaited(EasyLoading.dismiss());
      log(e.toString());
      await AlertWidget.newToast(
          message: '사진첩에서 정상적으로 이미지를 불러오지 못했어요. 다시 시도해주세요', context);
    }
  }

  // 프로필 정보 업데이트
  Future<void> updateUserProfile(UserProfileRequest requestInfo) async {
    final response = await _userRepository.updateUserProfile(requestInfo);
    response.fold(
      onSuccess: (data) {
        log('업데이트 성공');
        _userService.getUserInfo();
        onProfileUpdateSuccess();
      },
      onFailure: (e) {
        EasyLoading.showError('프로필 정보를 업데이트하지 못했습니다');
        log('ProfileSettingViewModel $e');
      },
    );
  }

  // 닉네임 중복 확인
  Future<bool> checkDuplicateName(String value) async {
    final response = await _userRepository.checkDuplicateDisplayName(value);
    return response.fold(
      onSuccess: (isDuplicated) {
        if (isDuplicated) {
          return true;
        } else {
          return false;
        }
      },
      onFailure: (e) {
        log('ProfileSettingViewModel : $e');
        EasyLoading.showError('프로필 정보를 업데이트하지 못했습니다');
        return true;
      },
    );
  }

  /* Getters */
  UserModel get userInfo => _userService.userInfo.value;

  String? get photoUrl => _userService.userInfo.value.photoUrl;

  bool get isNickNameChanged =>
      textEditingController.text != _userService.userInfo.value.displayName;

  @override
  void onInit() {
    super.onInit();
    textEditingController = TextEditingController();
    formKey = GlobalKey<FormState>();
    _picker = ImagePicker();
    focusNode = FocusNode();

    // Text Field 초기 설정
    textEditingController.text = userInfo.displayName!;
    focusNode.requestFocus();
  }
}
