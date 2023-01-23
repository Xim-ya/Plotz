import 'package:uppercut_fantube/presentation/screens/my/localWidget/leading_icon_title.dart';
import 'package:uppercut_fantube/presentation/screens/my/my_page_view_model.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class MyPageScreen extends BaseScreen<MyPageViewModel> {
  const MyPageScreen({Key? key}) : super(key: key);

  @override
  Widget buildScreen(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          AppSpace.size16,

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
          AppSpace.size24,
          // 시청 기록
          Padding(
            padding: AppInset.left16,
            child: Text(
              '시청 기록',
              style:
                  AppTextStyle.alert1.copyWith(color: const Color(0xFF868585)),
            ),
          ),
          AppSpace.size8,
          ContentPostSlider(
            height: 168,
            itemCount: 12,
            itemBuilder: (BuildContext context, int index) {
              return const ContentPostItem(
                  ratio: 96 / 142, imgUrl: '/f2PVrphK0u81ES256lw3oAZuF3x.jpg');
            },
          ),
          AppSpace.size48,

          // 큐레이션
          Padding(
            padding: AppInset.left16,
            child: Text(
              '큐레이션 내역',
              style:
              AppTextStyle.alert1.copyWith(color: const Color(0xFF868585)),
            ),
          ),
          AppSpace.size2,
          Padding(
            padding: AppInset.left8,
            child:
                ToggleButtons(isSelected: vm.qurateOptionSelections, children: [
              qurationOptionBtn('진행중'),
              qurationOptionBtn('등록완료'),
              qurationOptionBtn('보류'),
            ]),
          )
        ],
      ),
    );
  }

  Widget qurationOptionBtn(String content) {
    return Container(
      child: TextButton(
        onPressed: () {},
        child: Text(
          content,
          style: AppTextStyle.headline3.copyWith(color: AppColor.mixedWhite),
        ),
      ),
    );
  }
}
