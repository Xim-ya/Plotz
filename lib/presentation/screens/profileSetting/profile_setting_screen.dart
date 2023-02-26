import 'package:soon_sak/presentation/screens/profileSetting/profile_setting_view_model.dart';
import 'package:soon_sak/utilities/constants/regex.dart';
import 'package:soon_sak/utilities/index.dart';

class ProfileSettingScreen extends BaseScreen<ProfileSettingViewModel> {
  const ProfileSettingScreen({Key? key}) : super(key: key);

  @override
  Widget buildScreen(BuildContext context) {
    return Padding(
      padding: AppInset.horizontal16,
      child: Center(
        child: Column(
          children: <Widget>[
            AppSpace.size16,
            // 프로필 이미지
            GestureDetector(
              onTap: vm.pickProfileImage,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Stack(
                  children: [
                    Obx(() {
                      if (vm.pickedImgFile.value.hasData) {
                        return ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.file(
                              vm.pickedImgFile.value!,
                              height: 84,
                              width: 84,
                              fit: BoxFit.fitHeight,
                            ));
                      } else {
                        return Obx(
                          () => RoundProfileImg(size: 84, imgUrl: vm.photoUrl),
                        );
                      }
                    }),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        color: Colors.black.withOpacity(0.6),
                        height: 20,
                        width: 84,
                        child: Center(
                          child: Opacity(
                            opacity: 0.9,
                            child: Text(
                              '변경',
                              style: AppTextStyle.alert2,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            AppSpace.size24,

            // 닉네임 입력 Field
            Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: TextFormField(
                validator: (value) {
                  if (value == null || value == '') {
                    return '닉네임을 입력해주세요';
                  } else if (Regex.hasSpaceOnString(value)) {
                    return '닉네임에는 공백을 사용할 수 없습니다';
                  } else if (value.trim().length < 2 ||
                      value.trim().length > 10) {
                    return '닉네임은 2에서 10글자 사이여야 합니다';
                  } else if (Regex.hasProperCharacter(value)) {
                    return '닉네임에는 한글, 알파벳, 숫자, 언더스코어(_), 하이픈(-)만 사용할 수 있습니다';
                  } else if (Regex.hasContainFWord(value)) {
                    return '비속어, 욕설 단어는 사용할 수 없습니다';
                  } else if (Regex.hasContainOperationWord(value) ||
                      value == '순삭') {
                    return '사용할 수 없는 닉네임 입니다';
                  } else {
                    return null;
                  }
                },
                onFieldSubmitted: (_) {},
                keyboardAppearance: Brightness.dark,
                onChanged: (_) {},
                controller: vm.textEditingController,
                cursorColor: AppColor.lightGrey,
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontFamily: 'pretendard_regular'),
                decoration: InputDecoration(
                  border: _outLinedBorder(),
                  filled: true,
                  contentPadding: const EdgeInsets.only(left: 18, right: 40),
                  hintText: '닉네임을 입력해주세요',
                  errorBorder: _errorBorder(),
                  focusedErrorBorder: _errorBorder(),
                  enabledBorder: _outLinedBorder(),
                  disabledBorder: _fixedOutLinedBorder(),
                  focusedBorder: _outLinedBorder(),
                  fillColor: AppColor.strongGrey,
                  errorStyle: AppTextStyle.alert2.copyWith(color: AppColor.red),
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: AppColor.lightGrey.withOpacity(0.4),
                    fontFamily: 'pretendard_regular',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  OutlineInputBorder _errorBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: AppColor.red, width: 0.6),
    );
  }

  OutlineInputBorder _outLinedBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.4), // 테두리 색상
        width: 0.6, // 테두리 너비
      ),
    );
  }

  // [TextField] OutLinedBorder 속성
  OutlineInputBorder _fixedOutLinedBorder() {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        borderSide: BorderSide(color: Colors.transparent));
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 56,
      elevation: 0,
      leading: GestureDetector(
        onTap: vm.routeBack,
        child: const Icon(
          Icons.arrow_back_ios,
          color: AppColor.mixedWhite,
        ),
      ),
      title: Text(
        '프로필 설정',
        style: AppTextStyle.title2,
      ),
      actions: [
        TextButton(
          onPressed: vm.saveProfileChanges,
          child: Text(
            '저장',
            style:
                AppTextStyle.title2.copyWith(fontFamily: 'pretendard_medium'),
          ),
        )
      ],
      backgroundColor: AppColor.black,
    );
  }
}
