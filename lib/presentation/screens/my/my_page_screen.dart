import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/presentation/index.dart';
import 'package:soon_sak/presentation/screens/my/localWidget/my_page_scaffold.dart';
import 'package:soon_sak/presentation/screens/my/localWidget/my_profile_info_view.dart';
import 'package:soon_sak/presentation/screens/my/localWidget/my_watch_history_slider.dart';
import 'package:soon_sak/utilities/index.dart';

class MyPageScreen extends BaseScreen<MyPageViewModel> {
  const MyPageScreen({Key? key}) : super(key: key);

  @override
  Widget buildScreen(BuildContext context) {
    return MyPageScaffold(
      scrollController: vm(context).scrollController,
      profileInfoView: const MyProfileInfoView(),
      watchHistorySlider: const MyWatchHistorySlider(),
      currentVersionInfoTile: const _CurrentVersionInfoTile(),
      requestedContentIndicator: const _RequestedContentStatusIndicator(),
      settingBtnList: _buildSettingMenuList(context),
      hideTopLinearGradient: vm(context).hideGradient,
    );
  }

  // 환경설정 옵션 버튼 리스트 뷰
  List<Widget> _buildSettingMenuList(BuildContext context) {
    return [
      ...vm(context)
          .settingOptions
          .map(
            (e) => _settingMenu(
              title: e.name,
              onTap: () {
                vm(context).onSettingMenuTapped(e);
              },
            ),
          )
          .toList(),
    ];
  }

  InkWell _settingMenu({required String title, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: AppInset.vertical14 + AppInset.horizontal16,
        height: 20,
        child: Text(
          title,
          style: AppTextStyle.body3.copyWith(
            color: AppColor.gray01,
          ),
        ),
      ),
    );
  }

  @override
  MyPageViewModel createViewModel(BuildContext context) =>
      locator<MyPageViewModel>();
}

class _RequestedContentStatusIndicator extends BaseView<MyPageViewModel> {
  const _RequestedContentStatusIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: vm(context).routeToRequestedContentBoard,
      height: 54,
      padding: AppInset.horizontal16,
      minWidth: SizeConfig.to.screenWidth,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '콘텐츠 신청 내역',
            style: AppTextStyle.title2,
          ),
          Text(
            '1건',
            style: AppTextStyle.body3.copyWith(color: AppColor.main),
          )
        ],
      ),
    );
  }
}

/// 버전 정보 타일 뷰
class _CurrentVersionInfoTile extends BaseView<MyPageViewModel> {
  const _CurrentVersionInfoTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          AppInset.horizontal16 + const EdgeInsets.only(top: 24, bottom: 16),
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: '현재 버전  ',
              style: AppTextStyle.body3.copyWith(
                color: AppColor.gray01,
              ),
            ),
            TextSpan(
              text: vm(context).currentVersionNum,
              style: AppTextStyle.body3.copyWith(
                color: AppColor.gray01,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
