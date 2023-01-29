import 'package:uppercut_fantube/presentation/common/button/linear_background_bottom_floating_btn.dart';
import 'package:uppercut_fantube/presentation/screens/quration/register/localWidget/url_validation_indicator.dart';
import 'package:uppercut_fantube/presentation/screens/quration/register/register_view_model.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class RegisterVideoLinkPageView extends BaseView<RegisterViewModel> {
  const RegisterVideoLinkPageView({Key? key}) : super(key: key);

  @override
  Widget buildView(BuildContext context) {
    return GestureDetector(
      onTap: () {
        vm.focusNode.unfocus();
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Padding(
            padding: AppInset.horizontal16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // 리딩 문구
                Padding(
                  padding: AppInset.top10 + AppInset.bottom16,
                  child: Text(
                    '유튜브 영상의\n링크를 입력해주세요',
                    style: AppTextStyle.headline1,
                  ),
                ),

                // 검색 창
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Expanded(
                          child: SearchBar(
                            hintText:
                                'ex)https://www.youtube.com/watch?v=HgyUW1dWkgo',
                            focusNode: vm.focusNode,
                            showPrefixIcon: false,
                            textEditingController: vm.textEditingController,
                            onChanged: vm.onVideoLinkFieldChanged,
                            onFieldSubmitted: (_) {},
                            resetSearchValue:vm.resetSearchValue,
                            showRoundCloseBtn: vm.showRoundCloseBtn,
                          ),
                        ),
                        AppSpace.size8,
                        MaterialButton(
                          minWidth: 68,
                          padding: EdgeInsets.zero,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          onPressed: vm.onPasteBtnTapped,
                          child: Center(
                            child: Text(
                              '붙여넣기',
                              style: AppTextStyle.body2,
                            ),
                          ),
                        )
                      ],
                    ),

                    // 링크 유효성 여부 인데이케이터
                    Obx(
                      () => Padding(
                        padding: AppInset.left4 + AppInset.top6,
                        child: UrlValidationIndicator(
                            validationState: vm.isEnteredVideoUrlValid.value),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 주소 복사 방법 예시 이미지
          Positioned(
            bottom: 0,
            child: Obx(
              () => AnimatedOpacity(
                opacity: vm.show2StepFloatingBtn.value ? 0 : 1,
                duration: const Duration(milliseconds: 845),
                child: Column(
                  children: [
                    Text(
                      '유튜브 앱에서\n\'공유하기\' 버튼을 눌러 주소를 복사해보세요',
                      style: AppTextStyle.title3,
                      textAlign: TextAlign.center,
                    ),
                    AppSpace.size16,
                    Image.asset(
                      'assets/images/how_to_copy_url_phone_mock.png',
                      fit: BoxFit.fitWidth,
                      width: SizeConfig.to.screenWidth - 32,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 하단 고정 버튼
          Positioned(
            bottom: 0,
            child: Obx(
              () => AnimatedOpacity(
                opacity: vm.show2StepFloatingBtn.value ? 1 : 0,
                duration: const Duration(milliseconds: 500),
                child: Visibility(
                  visible: vm.show2StepFloatingBtn.value ? true : false,
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: 72,
                          width: SizeConfig.to.screenWidth,
                          color: AppColor.black,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            bottom: SizeConfig.to.responsiveBottomInset),
                        child: LinearBgBottomFloatingBtn(
                          text: '다음',
                          onTap: vm.onFloatingStepBtnTapped,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
