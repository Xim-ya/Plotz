import 'package:uppercut_fantube/presentation/screens/my/my_page_view_model.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class MyPageScreen extends BaseScreen<MyPageViewModel> {
  const MyPageScreen({Key? key}) : super(key: key);

  @override
  Widget buildScreen(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          // 설정 버튼
          Padding(
            padding: AppInset.right8,
            child: Align(
              alignment: Alignment.centerRight,
              child: IconInkWellButton.packageIcon(
                icon: Icons.settings,
                size: 24,
                onIconTapped: () {},
              ),
            ),
          ),

          // 프로필
          Padding(
            padding: AppInset.horizontal16,
            child: Row(
              children: <Widget>[
                const RoundProfileImg(
                  size: 58,
                  imgUrl: null,
                ),
                AppSpace.size10,
                Text(
                  '심야님',
                  style:
                      AppTextStyle.title1.copyWith(color: AppColor.mixedWhite),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
