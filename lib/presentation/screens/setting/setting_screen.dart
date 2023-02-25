import 'package:soon_sak/presentation/screens/setting/setting_view_model.dart';
import 'package:soon_sak/utilities/index.dart';

class SettingScreen extends BaseScreen<SettingViewModel> {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget buildScreen(BuildContext context) {
    return Column(
      children: <Widget>[
        _settingMenu(title: '프로필 설정', onTap: vm.routeToProfileSetting),
        _settingMenu(title: '로그아웃', onTap: vm.signOut),
        _settingMenu(title: '회원탈퇴', onTap: () {}),
      ],
    );
  }

  InkWell _settingMenu({required String title, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: AppInset.all16,
        height: 20,
        child: Text(
          title,
          style: AppTextStyle.title2.copyWith(fontFamily: 'pretendard_regular'),
        ),
      ),
    );
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
        '설정',
        style: AppTextStyle.title2,
      ),
      backgroundColor: AppColor.black,
    );
  }
}
