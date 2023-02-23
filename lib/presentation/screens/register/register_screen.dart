import 'package:soon_sak/presentation/screens/register/register_view_model.dart';
import 'package:soon_sak/utilities/index.dart';

class RegisterScreen extends BaseScreen<RegisterViewModel> {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget buildScreen(BuildContext context) {
    return Container(
      color: AppColor.black,
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: vm.pageViewController,
        children: const <Widget>[
          SearchContentPageView(),
          RegisterVideoLinkPageView(),
          ConfirmCurationPageView(),
        ],
      ),
    );
  }

  // 앱바
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(0, 56 + SizeConfig.to.statusBarHeight),
      child: Container(
        margin: EdgeInsets.only(top: SizeConfig.to.statusBarHeight),
        padding: AppInset.horizontal16,
        height: 56,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: vm.onBackBtnTapped,
              child: const Icon(
                Icons.arrow_back_ios,
                color: AppColor.mixedWhite,
              ),
            ),
            // 진행 단계 Indicator
            Obx(
              () => ToggleButtons(
                constraints: BoxConstraints.loose(Size.infinite),
                renderBorder: false,
                isSelected: vm.selectedSteps,
                children: [
                  _circleBtnIndicator('1', vm.selectedSteps[0]),
                  _circleBtnIndicator('2', vm.selectedSteps[1]),
                  _circleBtnIndicator('3', vm.selectedSteps[2]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _circleBtnIndicator(String step, bool isSelected) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(right: step == '2' ? 0 : 6),
      height: 22,
      width: 22,
      decoration: BoxDecoration(
        color: AppColor.strongGrey.withOpacity(isSelected ? 1 : 0.4),
        shape: BoxShape.circle,
      ),
      child: Text(
        step,
        style: AppTextStyle.alert2.copyWith(
          color: Colors.white.withOpacity(isSelected ? 1 : 0.2),
        ),
      ),
    );
  }

  @override
  bool get wrapWithSafeArea => false;

  @override
  bool get resizeToAvoidBottomInset => false;
}