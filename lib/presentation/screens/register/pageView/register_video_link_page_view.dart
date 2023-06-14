import 'package:provider/provider.dart';
import 'package:soon_sak/presentation/base/base_view.dart';
import 'package:soon_sak/utilities/index.dart';


class RegisterVideoLinkPageView extends BaseView<RegisterViewModel> {
  const RegisterVideoLinkPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(SizeConfig.to.screenHeight);
    return RegisterVideoLinkPageViewScaffold(
      onBackgroundLayerTapped: vm(context).videoFormFocusNode.unfocus,
      leadingTitle: _buildLeadingTitle(),
      searchBar: const _InputField(),
      pasteIntroductionView: _buildPateIntroductinoView(context),
      bottomFixedStepBtn: _buildBottomFixedStepBtn(context),
    );
  }

  // 리딩 문구
  Widget _buildLeadingTitle() => Column(
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
        ],
      );



  // 주소 복사 방법 설명
  Widget _buildPateIntroductinoView(BuildContext context) => Positioned(
        bottom: SizeConfig.to.screenWidth < 600 ? -50 : 0,
        child: StreamBuilder<ValidationState>(
          stream: vm(context).videoUrlValidState.stream,
          builder: (context, snapshot) {
            return AnimatedOpacity(
              opacity: snapshot.data.hasData && snapshot.data!.isValid ? 0 : 1,
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
            );
          },
        ),
      );

  // 하단 고정 버튼
  Widget _buildBottomFixedStepBtn(BuildContext context) => Positioned(
        bottom: 0,
        child: StreamBuilder<ValidationState>(
          stream: vm(context).videoUrlValidState.stream,
          builder: (context, snapshot) {
            return AnimatedOpacity(
              opacity: snapshot.data.hasData && snapshot.data!.isValid ? 1 : 0,
              duration: const Duration(milliseconds: 500),
              child: Visibility(
                visible:  snapshot.data.hasData && snapshot.data!.isValid  ? true : false,
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
                        bottom: SizeConfig.to.responsiveBottomInset,
                      ),
                      child: LinearBgBottomFloatingBtn(
                        text: '다음',
                        onTap: vm(context).onFloatingStepBtnTapped,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
}

// 입력창
class _InputField extends BaseView<RegisterViewModel> {
  const _InputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            Selector<RegisterViewModel, bool>(
              selector: (context, vm) => vm.showVideoFormCloseBtn,
              builder: (context, showCloseBtn, _) {
                return Expanded(
                  child: AppSearchBar(
                    hintText: 'ex)https://www.youtube.com/watch?v=HgyUW1dWkgo',
                    focusNode: vm(context).videoFormFocusNode,
                    showPrefixIcon: false,
                    textEditingController: vm(context).videoFormController,
                    onChanged: (_) {
                      vm(context).validateVideoUrlUseCase.onSearchTermEntered();
                    },
                    onFieldSubmitted: (_) {},
                    resetSearchValue:
                        vm(context).validateVideoUrlUseCase.onCloseBtnTapped,
                    showRoundCloseBtn: showCloseBtn,
                  ),
                );
              },
            ),
            AppSpace.size8,
            MaterialButton(
              minWidth: 68,
              padding: EdgeInsets.zero,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onPressed: () {
                vm(context).validateVideoUrlUseCase.onPasteBtnTapped(context);
              },
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
        Padding(
          padding: AppInset.left4 + AppInset.top6,
          child: StreamBuilder<ValidationState>(
            stream: vm(context).videoUrlValidState.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return UrlValidationIndicator(
                  validationState: snapshot.data!,
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ],
    );
  }
}
